import { HttpService }  from '../../core'

export class ShippingService{

   private httpService: any = new HttpService();
      

   constructor(){
      this.httpService.resourceName  = 'shipping';
   }

   public getShipping(shippingId? : any) {
      return this.httpService.get('/id/'+shippingId);
   }

   public getShippings() {
      return this.httpService.fetchAll()
   }

   public updateShipping(shipping, id) {
      return this.httpService.update(shipping, id);
   }

   public addShipping(shipping) {
      return this.httpService.save(shipping);
   }

   public deleteShipping(shippingId) {
      return this.httpService.delete(shippingId);
   }

   public getShippingByZone(shipping) {
      return this.httpService.get(`/getShippingByZone/${shipping.from.code}/${shipping.to.code}`);
   }

   public getShippingsByZone(shipping) {
      return this.httpService.get(`/getShippingsByZone/${shipping.from.code}/${shipping.to.code}`);
   }

   

}