import { HttpService }  from '../../core'

export class CurrencyService {
  
   private httpService: any = new HttpService();

   constructor(){
      this.httpService.resourceName  = 'currencies';
   }

   public getCurrency(currencyId? : any) {
      return this.httpService.find(currencyId);
   }

   public getCurrencies() {
      return this.httpService.fetchAll()
   }

   public updateCurrency(currency, id) {
      return this.httpService.update(currency, id);
   }

   public addCurrency(currency) {
      return this.httpService.save(currency);
   }

   public deleteCurrency(currencyId) { 
      return this.httpService.delete(currencyId);
   }

}