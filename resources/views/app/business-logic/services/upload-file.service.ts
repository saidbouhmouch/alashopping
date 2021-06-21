import { apiHttp }  from '../../core'

export class UploadFileService{
      

   constructor(){}

   public uploadFile(data) {
      return apiHttp.post('/upload-file',{ data: JSON.stringify(data) });
   }

}