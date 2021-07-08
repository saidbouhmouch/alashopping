<?php

namespace App\Http\Controllers\Ui;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use PayPal\Rest\ApiContext;
use PayPal\Auth\OAuthTokenCredential;
use PayPal\Api\Agreement;
use PayPal\Api\Payer;
use PayPal\Api\Plan;
use PayPal\Api\PaymentDefinition;
use PayPal\Api\PayerInfo;
use PayPal\Api\Item;
use PayPal\Api\ItemList;
use PayPal\Api\Amount;
use PayPal\Api\Transaction;
use PayPal\Api\RedirectUrls;
use PayPal\Api\Payment;
use PayPal\Api\PaymentExecution;
use Illuminate\Support\Facades\Input;
use App\Models\Order;
use Redirect;
use URL;

class PaymentController extends Controller {
    public function __construct() {
        /** PayPal api context **/
        $paypal_conf = [ 
            'client_id' => env('PAYPAL_CLIENT_ID',''),
            'secret' => env('PAYPAL_SECRET',''),
            'settings' => array(
                'mode' => env('PAYPAL_MODE','sandbox'),
                'http.ConnectionTimeOut' => 30,
                'log.LogEnabled' => true,
                'log.FileName' => storage_path() . '/logs/paypal.log',
                'log.LogLevel' => 'ERROR'
            ),
        ];

        $this->_api_context = new ApiContext(new OAuthTokenCredential(
            $paypal_conf['client_id'],
            $paypal_conf['secret'])
        );
        $this->_api_context->setConfig($paypal_conf['settings']);
    }

    public function payWithpaypal($orderId,Request $request) {
       
        $payer = new Payer();
        $payer->setPaymentMethod('paypal');

        $items = [];
        $order = Order::findOrFail($orderId);
        $products = $order->products;
        foreach ($products as $key => $product) {
            $item = new Item();
            $item->setName($product->name) /** item name **/
            ->setCurrency('USD')
            ->setQuantity($product->pivot->quantity)
            ->setPrice($product->pivot->total); /** unit price **/
            $items[] = $item;
        }

        $item_list = new ItemList();
        $item_list->setItems($items);

        $amount = new Amount();
        $amount->setCurrency('USD')
        ->setTotal($order->total);

        $redirect_urls = new RedirectUrls();
        /** Specify return URL **/
        $redirect_urls->setReturnUrl(url('api/payment/status'))
        ->setCancelUrl(url('api/payment/status'));

        $transaction = new Transaction();
        $transaction->setAmount($amount)
        ->setItemList($item_list)
        ->setDescription('Your transaction description');

        $payment = new Payment();
        $payment->setIntent('Sale')
        ->setPayer($payer)
        ->setRedirectUrls($redirect_urls)
        ->setTransactions(array($transaction));
        try {
            $payment->create($this->_api_context);
        } catch (\PayPal\Exception\PPConnectionException $ex) {
            if (env('APP_DEBUG')) {
                \LoggerService::writeln("--- Connection timeout");
                 app('request')->session()->put('error', 'Connection timeout');
                return redirect('/');
            } else {
                \LoggerService::writeln('error Some error occur, sorry for inconvenient');
                 app('request')->session()-> put('error', 'Some error occur, sorry for inconvenient');
                return redirect('/');
            }
        }
        foreach($payment->getLinks() as $link) {
            if ($link->getRel() == 'approval_url') {
                $redirect_url = $link->getHref();
                break;
            }
        }

        
        /** add payment ID to session **/
        \LoggerService::writeln($payment->getId());

         app('request')->session()->put('paypal_payment_id', $payment->getId());
        if (isset($redirect_url)) {
            /** redirect to paypal **/
            return redirect($redirect_url);
        }
        \LoggerService::writeln('Unknown error occurred');
         app('request')->session()->put('error', 'Unknown error occurred');
        return redirect('/');
    }

    public function getPaymentStatus(Request $request) {
        /** Get the payment ID before session clear **/
        $payment_id = app('request')->session()->get('paypal_payment_id');
        \LoggerService::writeln($payment_id);
        /** clear the session payment ID **/
        app('request')->session()->forget('paypal_payment_id');
        if (empty($request->PayerID) || empty($request->token)) {
            session()->flash('error', 'Payment failed');
            return redirect('/');
        }
        $payment = Payment::get($payment_id, $this->_api_context);
        $execution = new PaymentExecution();
        $execution->setPayerId($request->PayerID);
        /**Execute the payment **/
        $result = $payment->execute($execution, $this->_api_context);

        if ($result->getState() == 'approved') {
            session()->flash('success', 'Payment success');
            \LoggerService::writeln("'Payment success'");
            return redirect('/');
        }
        session()->flash('error', 'Payment failed');
        \LoggerService::writeln('Payment failed');
        return redirect('/');
    }

}
