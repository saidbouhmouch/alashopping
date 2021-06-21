import { HttpService }  from '../../core'

export class CountryService{
      
   private httpService: any = new HttpService();

   constructor(){
      this.httpService.resourceName  = 'countries';
   }

   public getCountry(countryId? : any) {
      return this.httpService.find(countryId);
   }

   public getCountries() {
      return this.httpService.fetchAll()
   }

   public updateCountry(country, id) {
      return this.httpService.update(country, id);
   }

   public addCountry(country) {
      return this.httpService.save(country);
   }

   public deleteCountry(countryId) { 
      return this.httpService.delete(countryId);
   }
     

}