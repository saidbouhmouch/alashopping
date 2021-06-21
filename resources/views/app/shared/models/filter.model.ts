
import { ISearch , Search , searchByTerms } from './search.model'
/**
 *   Filter model
 */
export interface IPrice {
    min: number;
    max: number;
};


export interface IFilter {
    price: IPrice;
    categories: string[];
    size: number;
    page: number;
    sortBy: ISearch[];
    totalElements:number;
    totalPages : number;
    from : number;
    to : number;
}


export class Filter {
    price: IPrice;
    categories: string[];
    size: number;
    page: number;
    sortBy: ISearch[];
    totalElements:number;
    totalPages : number;
    from : number;
    to : number;

    constructor();
    constructor(filter: IFilter);
    constructor(filter?: any) {
        this.price = filter && filter.price || {
            min: 0,
            max: 0
        };
        this.categories = filter && filter.categories || [];
        this.size = filter && filter.size || 9;
        this.page = filter && filter.page || 0;
        this.sortBy = filter && this.sortBy || searchByTerms;
        this.totalElements = filter && filter.totalElements || 0;
        this.totalPages = filter && filter.totalPages || 0;
        this.from = filter &&  filter.from || 0;
        this.to =  filter && filter.to || 0;
    }
}