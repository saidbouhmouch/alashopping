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

        constructor();
        constructor(carrier: ICarrier); 
        constructor(carrier?: any) {  
                this.id = carrier && carrier.id || 0;
                this.name = carrier && carrier.name || '';
                this.slug = carrier && carrier.slug || '';
                this.price = carrier && carrier.price || 0;
                this.deliveryText = carrier && carrier.deliveryText || '';
                this.picture = carrier && new Picture(carrier.image || carrier.picture ) || new Picture();
                this.createdAt = carrier && (carrier.createdAt || carrier.created_at) || '';
                this.updatedAt = carrier && (carrier.updatedAt || carrier.updated_at) || '';
        }

}
