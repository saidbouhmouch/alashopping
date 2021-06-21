import { apiHttp } from '../';
import { environment,LocalStorageService,IApi } from '../';

export class HttpService  implements IApi{
   localStorageService = new LocalStorageService();
   resourceName: string = '';
   constructor() { }

   public fetchAll(): Promise<any> {
      return  apiHttp.get(`${environment.apiUrl}${this.resourceName}`);
   }

   public save(data): Promise<any>  {
      return apiHttp.post(`${environment.apiUrl}${this.resourceName}`, { data: JSON.stringify(data) });
   }

   public find(id): Promise<any>  {
      return apiHttp.get(`${environment.apiUrl}${this.resourceName}/${id}/edit`);
   }

   public update(data, id): Promise<any>  {
      return apiHttp.put(`${environment.apiUrl}${this.resourceName}/${id}`, { data: JSON.stringify(data) });
   }

   public delete(id) : Promise<any> {
      return apiHttp.delete(`${environment.apiUrl}${this.resourceName}/${id}`);
   }

   public post(path, data) : Promise<any> {
      return apiHttp.post(`${environment.apiUrl}${this.resourceName}${path}`, { data: JSON.stringify(data) });
   }

   public get(path): Promise<any>  {
      return apiHttp.get(`${environment.apiUrl}${this.resourceName}${path}`);
   }

   public put(path, data): Promise<any>  {
      return apiHttp.put(`${environment.apiUrl}${this.resourceName}${path}`, { data: JSON.stringify(data) });
   }


}
