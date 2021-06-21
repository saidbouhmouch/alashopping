import { HttpService }  from '../../core'

declare const _ : any;
export class SpecificPriceService{


   private httpService: any = new HttpService();

   constructor(){
      this.httpService.resourceName  = 'specific-prices';
   }

   public getSpecificPrice(SpecificPriceId? : any) {
      return this.httpService.find(SpecificPriceId);
   }

   public getSpecificPrices() {
      return this.httpService.fetchAll()
   }

   public updateSpecificPrice(specificPrice, id) {
      return this.httpService.update(specificPrice, id);
   }

   public addSpecificPrice(specificPrice,products) {
       delete specificPrice.product;
      return this.httpService.save({specificPrice,productsIds : _.map(products, (prd)=>{ return prd.id}) });
   }

   public deleteSpecificPrice(SpecificPriceId) {
      return this.httpService.delete(SpecificPriceId);
   }

}

