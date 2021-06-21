import { HttpService }  from '../../core'

export class CategoryService{

   private httpService: any = new HttpService();

   constructor(){
      this.httpService.resourceName  = 'categories';
   }

   public getCategory(categoryId? : any) {
      return this.httpService.find(categoryId);
   }

   public getCategories() {
      return this.httpService.fetchAll()
   }

   public updateCategory(category, id) {
      return this.httpService.update(category, id);
   }

   public addCategory(category) {
      return this.httpService.save(category);
   }

   public deleteCategory(categoryId) {
      return this.httpService.delete(categoryId);
   }

   public getCategoriesWithProductsTotal() {
    return this.httpService.get('/products-total');
  }



}
