import { HttpService }  from '../../core'

export class TagService{
  
   private httpService: any = new HttpService();

   constructor(){
      this.httpService.resourceName  = 'tags';
   }

   public getTag(tagId? : any) {
      return this.httpService.find(tagId);
   }

   public getTags() {
      return this.httpService.fetchAll()
   }

   public updateTag(tag, id) {
      return this.httpService.update(tag, id);
   }

   public addTag(tag) {
      return this.httpService.save(tag);
   }

   public deleteTag(tagId) { 
      return this.httpService.delete(tagId);
   }
}