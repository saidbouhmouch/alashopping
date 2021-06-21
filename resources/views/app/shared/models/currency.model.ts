/**
 *   Currency model
 */
export interface ICurrency {
        id: number;
        name: string;
        iso: string;
        value: string;
        default: boolean;
        createdAt: string;
        updatedAt: string;
}

export class Currency {
        id: number;
        name: string;
        iso: string;
        value: string;
        default: boolean;
        createdAt: string;
        updatedAt: string;

        constructor();
        constructor(currency: ICurrency); 
        constructor(currency?: any) {    
                this.id = currency && currency.id || 0;
                this.name = currency && currency.name || '';
                this.iso = currency && currency.iso || '';
                this.value = currency && currency.value || '';
                this.default = currency && currency.default || false;
                this.createdAt = currency && (currency.createdAt || currency.created_at) || '';
                this.updatedAt = currency && (currency.updatedAt || currency.updated_at) || '';
        }   
}