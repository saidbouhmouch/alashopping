import { Carrier, ICarrier } from "./carrier.model";
import { ICountry, Country } from "./country.model";
import { ICurrency, Currency } from "./currency.model";

/**
 * Shipping model
 */
export interface IShipping {
        id: number;
        from: ICountry;
        to: ICountry;
        price: number;
        currency : ICurrency;
        estimatedDeliveryMin: number;
        estimatedDeliveryMax: number;
        carrier: ICarrier;
        createdAt: string;
        updatedAt: string;                    
}

export class Shipping {
        id: number;
        from: ICountry;
        to: ICountry;
        price: number;
        currency : ICurrency;
        estimatedDeliveryMin: number;
        estimatedDeliveryMax: number;
        carrier: ICarrier;
        createdAt: string;
        updatedAt: string;

        constructor();
        constructor(shipping: IShipping); 
        constructor(shipping?: any) {    
                this.id = shipping && shipping.id || 0;
                this.from = shipping && new Country(shipping.delivery_from || shipping.from ) || new Country();
                this.to = shipping && new Country(shipping.delivery_to || shipping.to) || new Country();
                this.price = shipping && shipping.price || 0;
                this.currency = shipping && new Currency(shipping.currency) || new Currency();
                this.estimatedDeliveryMin = shipping && shipping.estimatedDeliveryMin || 1;
                this.estimatedDeliveryMax = shipping && shipping.estimatedDeliveryMax || 1;
                this.carrier = shipping && new Carrier(shipping.carrier) || new Carrier();
                this.createdAt = shipping && (shipping.createdAt || shipping.created_at) || '';
                this.updatedAt = shipping && (shipping.updatedAt || shipping.updated_at) || '';
        }
}
