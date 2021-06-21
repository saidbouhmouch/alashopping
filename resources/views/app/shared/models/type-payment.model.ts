import { Picture, IPicture } from './picture.model'

/**
 * Type Payment model
 */
export interface ITypePayment {

    id: number;
    name: string;
    slug?:string;
    picture: IPicture;
    createdAt: string;
    updatedAt: string;

}

export class TypePayment {

    id: number;
    name: string;
    picture: IPicture;
    slug?:string;
    createdAt: string;
    updatedAt: string;

    constructor() {
        this.id = -1;
        this.name = '';
        this.slug = '';
        this.picture = new Picture();
        this.createdAt = '';
        this.updatedAt = '';
    }

}

