import { IPicture, Picture } from './picture.model'

/**
 * Carrier model
 */
export interface ICarrier {
        id: number;
        name: string;
        slug: string;
        price: number;
        deliveryText: string;
        picture: IPicture;
        createdAt: string;
        updatedAt: string;
}

export class Carrier {
        id: number;
        name: string;
        slug: string;
        price: number;
        deliveryText: string;
        picture: IPicture;
        createdAt: string;
        updatedAt: string;

        constructor() {
                this.id = -1;
                this.name = '';
                this.slug = '';
                this.price = 0;
                this.deliveryText = '';
                this.picture = new Picture();
                this.createdAt = '';
                this.updatedAt = '';
        }
}
