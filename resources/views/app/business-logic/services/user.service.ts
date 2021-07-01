import { HttpService } from '../../core'
import { CredentialsService, JwtService } from '../../core'


export class UserService {

   private credentialsService = new CredentialsService();
   private jwtService: any = new JwtService();
   private httpService: any = new HttpService();


   constructor() {
      this.httpService.resourceName = 'users';
   }

   getCurrentUser(){
     return this.httpService.get('/getcurrentuser');
   }

   public getUser(userId?: any) {
      if (userId) {
         return this.httpService.find(userId);
      } else {
         this.credentialsService.getCredentials();
         let credentials: any = this.credentialsService.credentials;
         const user: any = this.jwtService.decrypt(credentials.token);
         if (user) {
            return {
               email: user.email,
               firstName: user.firstName,
               lastName: user.lastName,
               image: user.image
            }
         } else {
            return null
         }
      }
   }

   public getUsers() {
      return this.httpService.fetchAll()
   }

   public updateUser(user, id) {
      return this.httpService.update(user, id);
   }

   public addUser(user) {
      return this.httpService.save(user);
   }

   public deleteUser(userId) {
      return this.httpService.delete(userId);
   }

}