import { Interface } from 'readline';
import { IPicture, Picture } from './picture.model'

/**
 * Country model
 */
export interface ICountry {
        id: number;
        name: string;
        code: string;
        picture: IPicture;
        createdAt: string;
        updatedAt: string;
}


export class Country {
        id: number;
        name: string;
        code: string;
        picture: IPicture;
        createdAt: string;
        updatedAt: string;

        constructor();
        constructor(country: ICountry); 
        constructor(country? : any) {
                this.id = country && country.id || 0;
                this.name = country && country.name || '';
                this.code = country && country.code || '';
                this.picture = country &&  new Picture(country.picture) || new Picture();
                this.createdAt = country && (country.createdAt || country.created_at) || '';
                this.updatedAt = country && (country.updatedAt || country.updated_at) || '';
        }
}
