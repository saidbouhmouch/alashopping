import { Picture, IPicture } from './picture.model';
import { Currency, ICurrency } from './currency.model';
import { Taxe, ITaxe } from './taxe.model';
import { User, IUser } from './user.model';
import { Category, ICategory } from './category.model';
import { Tag, ITag } from './tag.model';
import { SpecificPrice , ISpecificPrice } from './specific-price.model';

/**
 *  Product model
 */
export interface IProduct {

    id: number;
    name: string;
    slug: string;
    price: number;
    descriptionShort: string;
    descriptionLong: string;
    sku: string;
    stock: number;
    additionalInformation: string;
    active: boolean;
    currency: ICurrency;
    picture: IPicture;
    taxe: ITaxe;
    user: IUser;
    categories: ICategory[];
    tags: ITag[];
    galleries: IPicture[];
    specificPrice : ISpecificPrice;
    createdAt: string;
    updatedAt: string;
    // totalPrice? : number;
    quantity? : number;

}


export class Product {

    id: number;
    name: string;
    slug: string;
    price: number;
    descriptionShort: string;
    descriptionLong: string;
    sku: string;
    stock: number;
    additionalInformation: string;
    active: boolean;
    currency: ICurrency;
    picture: IPicture;
    taxe: ITaxe;
    user: IUser;
    categories: ICategory[];
    tags: ITag[];
    galleries: IPicture[];
    specificPrice : ISpecificPrice;
    createdAt: string;
    updatedAt: string;
    // totalPrice? : number;
    quantity? : number;


    constructor();
    constructor(product: IProduct);
    constructor(product?: any) {
        this.id = product && product.id || 0;
        this.name = product && product.name || '';
        this.slug = product && product.slug || '';
        this.price = product && product.price || 0;
        this.descriptionShort = product && (product.descriptionShort || product.description_short) || '';
        this.descriptionLong = product && (product.descriptionLong || product.description_long) || '';
        this.sku = product && product.sku || '';
        this.stock = product && product.stock || 0;
        this.additionalInformation = product && (product.additionalInformation || product.additional_information) || '';;
        this.active = product && product.active || false;
        this.currency = product && new Currency(product.currency) || new Currency();
        this.picture = product && new Picture(product.picture) || new Picture();
        this.taxe = product && new Taxe(product.taxe) || new Taxe();
        this.user = product && new User(product.user) || new User();
        this.categories = product && product.categories || [];
        this.tags = product && product.tags || [];
        this.galleries = product && product.galleries || [];
        this.specificPrice =  product && product.specificPrice && new SpecificPrice(product.specificPrice)   || new SpecificPrice();
        this.createdAt = product && (product.createdAt || product.created_at) || '';
        this.updatedAt = product && (product.updatedAt || product.updated_at) || '';
        // this.totalPrice = product && product.totalPrice || 0;
        this.quantity  = product && product.quantity || 0;
    }

}