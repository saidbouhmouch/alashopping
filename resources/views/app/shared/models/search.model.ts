/**
 *   Search model
 */
export interface ISearch {
    label: string;
    value: string;
    selected: boolean;
};

export class Search {
    label: string;
    value: string;
    selected: boolean;

    constructor();
    constructor(search: ISearch);
    constructor(search?: any) {
        this.label = search && search.label || '';
        this.value = search && search.value || '';
        this.selected =  search && search.selected || false;
    }
}

export const searchByTerms = [
    {
        label : 'New arrivals',
        value : 'newArrivals',
        selected : false
    },
    {
        label : 'Alphabetically, A-Z',
        value : 'alphabetically_az',
        selected : false
    },
    {
        label : 'Alphabetically, Z-A',
        value : 'alphabetically_za',
        selected : false
    },
    {
        label : 'Price: low to high',
        value : 'price_low_to_high',
        selected : false
    },
    {
        label : 'Price: high to low',
        value : 'price_high_to_low',
        selected : false
    }
]
