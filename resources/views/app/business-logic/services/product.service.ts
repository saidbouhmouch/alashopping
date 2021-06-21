import { HttpService }  from '../../core'

export class ProductService{


   private httpService: any = new HttpService();

   constructor(){
      this.httpService.resourceName  = 'products';
   }

   public getProduct(productId? : any) {
      return this.httpService.find(productId);
   }

   public getProductBySlug(slug? : any) {
      return this.httpService.get('/slug/'+slug);
   }

   public getProducts() {
      return this.httpService.fetchAll()
   }

   public updateProduct(product, id) {
      return this.httpService.update(product, id);
   }

   public addProduct(product) {
      return this.httpService.save(product);
   }

   public deleteProduct(productId) {
      return this.httpService.delete(productId);
   }

   public getMaxPrice() {
    return this.httpService.get("/max-price");
   }

   public getProductsByfilter(filter : any) {
      return this.httpService.post('/fetchByfilter',filter);
   }

   public getProductsByIds(ids : any[]) {
      return this.httpService.post('/fetchByIds',ids);
   }


}
