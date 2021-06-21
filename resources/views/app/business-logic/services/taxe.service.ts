import { HttpService }  from '../../core'

export class TaxeService {

   private httpService: any = new HttpService();

   constructor(){
      this.httpService.resourceName  = 'taxes';
   }

   public getTaxe(taxeId? : any) {
      return this.httpService.find(taxeId);
   }

   public getTaxes() {
      return this.httpService.fetchAll()
   }

   public updateTaxe(taxe, id) {
      return this.httpService.update(taxe, id);
   }

   public addTaxe(taxe) {
      return this.httpService.save(taxe);
   }

   public deleteTaxe(taxeId) { 
      return this.httpService.delete(taxeId);
   }
}