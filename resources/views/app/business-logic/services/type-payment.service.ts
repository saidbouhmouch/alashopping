import { HttpService }  from '../../core'

export class TypePaymentService{

   private httpService: any = new HttpService();

   constructor(){
      this.httpService.resourceName  = 'type-payment';
   }

   public getTypePayment(typePaymentId? : any) {
      return this.httpService.find(typePaymentId);
   }

   public getTypePayments() {
      return this.httpService.fetchAll()
   }

   public updateTypePayment(typePayment, id) {
      return this.httpService.update(typePayment, id);
   }

   public addTypePayment(typePayment) {
      return this.httpService.save(typePayment);
   }

   public deleteTypePayment(typePaymentId) { 
      return this.httpService.delete(typePaymentId);
   }

}