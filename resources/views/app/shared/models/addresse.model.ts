import { ICountry, Country } from "./country.model";

/**
 * Addresse model
 */
export interface IAddresse {
        id: number;
        addresse: string;
        city: string;
        zipcode: string;
        type: string;
        country: ICountry;
        userId: number;
        createdAt: string;
        updatedAt: string;
}
export class Addresse {
        id: number;
        addresse: string;
        city: string;
        zipcode: string;
        type: string;
        country: ICountry;
        userId: number;
        createdAt: string;
        updatedAt: string;

        constructor();
        constructor(addresse: IAddresse); 
        constructor(addresse? : any) {
                this.id = addresse && addresse.id || 0;
                this.addresse = addresse && addresse.addresse || '';
                this.city = addresse && addresse.city ||"";
                this.zipcode = addresse && addresse.zipcode || "";
                this.type = addresse && addresse.type || "";
                this.country =  addresse && new Country(addresse.country)  || new Country();
                this.userId = addresse && addresse.userId || -1;
                this.createdAt = addresse && (addresse.createdAt || addresse.created_at) || '';
                this.updatedAt = addresse && (addresse.updatedAt || addresse.updated_at) || '';
        }
}
