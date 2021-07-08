import { HttpService }  from '../../core'

export class PaymentService{

   private httpService: any = new HttpService();
      

   constructor(){
      this.httpService.resourceName  = 'payment';
   }


   public payWithpaypal(orderId) {
      return this.httpService.post('/'+orderId,{});
   }

}