import { Picture, IPicture } from './picture.model'
import { Addresse, IAddresse } from './addresse.model'
import { Role, IRole } from './role.model'


/**
 * User model
 */
export interface IUser {
        id: number;
        firstName: string;
        lastName: string;
        email: string;
        password: string;
        gender: string;
        phone: string;
        picture: IPicture;
        addresse: IAddresse;
        role: IRole;
        createdAt: string;
        updatedAt: string;
}

export class User {

        id: number;
        firstName: string;
        lastName: string;
        email: string;
        password: string;
        gender: string;
        phone: string;
        picture: IPicture;
        addresse: IAddresse;
        role: IRole;
        createdAt: string;
        updatedAt: string;

        constructor();
        constructor(user: IUser); 
        constructor(user? : any) { 
                this.id = user && user.id || 0;
                this.firstName = user && (user.firstName || user.first_name )|| '';
                this.lastName = user && user && (user.lastName || user.last_name )|| '';
                this.email = user && user.email || '';
                this.password = user && user.password || '';
                this.gender = user && user.gender || '';
                this.phone = user && user.phone || '';
                this.picture = user && new Picture(user.picture) || new Picture();
                this.addresse =  user && new Addresse(user.addresse) || new Addresse();
                this.role = user && new Role(user.role) || new Role();
                this.createdAt = user && (user.createdAt || user.created_at ) || '';
                this.updatedAt = user && (user.updatedAt || user.updated_at ) || '';
        }
}
