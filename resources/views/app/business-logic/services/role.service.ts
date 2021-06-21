import { HttpService }  from '../../core'


export class RoleService{

   private httpService: any = new HttpService();

   constructor(){
      this.httpService.resourceName  = 'roles';
   }

   public getRole(roleId? : any) {
      return this.httpService.find(roleId);
   }

   public getRoles() {
      return this.httpService.fetchAll()
   }

   public updateRole(role, id) {
      return this.httpService.update(role, id);
   }

   public addRole(role) {
      return this.httpService.save(role);
   }

   public deleteRole(roleId) { 
      return this.httpService.delete(roleId);
   }

}