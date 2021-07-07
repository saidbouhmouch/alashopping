import { HttpService }  from '../../core'

export class CheckoutService{

   private httpService: any = new HttpService();
      

   constructor(){
      this.httpService.resourceName  = 'checkout';
   }


   public placeOrder(order) {
      return this.httpService.post('/place-order',order);
   }

}