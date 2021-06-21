import { Currency, ICurrency } from './currency.model';
import { Product, IProduct } from './product.model';

declare const moment: any;
/**
 * SpecificPrice model
 */
export interface ISpecificPrice {
        id: number;
        product : IProduct;
        reduction: number;
        discountType: string; //'amount', 'percent'
        startDate: Date;
        expirationDate: Date;
        currency: ICurrency;
        reducedPrice: number;
        percentReduction : number;
        price? : number;
        createdAt: Date;
        updatedAt: Date;
}

export class SpecificPrice {
            id: number;
            product : IProduct;
            reduction: number;
            discountType: string; //'amount', 'percent'
            startDate: Date;
            expirationDate: Date;
            currency: ICurrency;
            reducedPrice: number;
            percentReduction : number;
            price? : number;
            createdAt: Date;
            updatedAt: Date;

            constructor();
            constructor(specificPrice: ISpecificPrice);
            constructor(specificPrice?: any) {
                this.id = specificPrice && specificPrice.id || -1;
                this.product = specificPrice && specificPrice.product || null ;
                this.reduction = specificPrice && specificPrice.reduction || 0;
                this.price = specificPrice && specificPrice.price || null;
                this.discountType = specificPrice && (specificPrice.discountType || specificPrice.discount_type) || '';
                this.startDate = specificPrice && this.dateFormat((specificPrice.startDate || specificPrice.start_date)) || '' ;
                this.expirationDate = specificPrice && this.dateFormat((specificPrice.expirationDate || specificPrice.expiration_date )) || '' ;
                this.currency = specificPrice && new Currency(specificPrice.currency) || new Currency();
                this.createdAt = specificPrice && (specificPrice.createdAt || specificPrice.created_at) || '';
                this.updatedAt = specificPrice && (specificPrice.updatedAt || specificPrice.updated_at) || '';
                this.reducedPrice = 0;
                this.percentReduction = 0;
                this.calculateReducedPrice();
        }

        dateFormat(_date){
            const date = (_date)?moment(_date).format() : moment().format();
            return date.substring(0, 16);
        }

        calculateReducedPrice(){
                
                if(this.discountType == 'amount'){
                        this.reducedPrice = this.reduction;
                        this.percentReduction =(this.price)? (this.price / this.reduction) : 0;
                        
                }else if(this.discountType == 'percent'){
                        this.reducedPrice =(this.price)? (this.price * ( this.reduction/ 100 )):0;
                        this.percentReduction = this.reduction;
                }
               
        }
}
