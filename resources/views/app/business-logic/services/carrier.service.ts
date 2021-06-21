import { HttpService }  from '../../core'

export class CarrierService{

   private httpService: any = new HttpService();
      

   constructor(){
      this.httpService.resourceName  = 'carriers';
   }

   public getCarrier(carrierId? : any) {
      return this.httpService.find(carrierId);
   }

   public getCarriers() {
      return this.httpService.fetchAll()
   }

   public updateCarrier(carrier, id) {
      return this.httpService.update(carrier, id);
   }

   public addCarrier(carrier) {
      return this.httpService.save(carrier);
   }

   public deleteCarrier(carrierId) {
      return this.httpService.delete(carrierId);
   }

}