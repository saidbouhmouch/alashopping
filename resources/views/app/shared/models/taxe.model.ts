/**
 *   Taxe model
 */
export interface ITaxe {
    id: number;
    name: string;
    value: number;
    createdAt: string;
    updatedAt: string;
}

export class Taxe {
    id: number;
    name: string;
    value: number;
    createdAt: string;
    updatedAt: string;

    constructor();
    constructor(taxe: ITaxe); 
    constructor(taxe? : any) { 
        this.id = taxe && taxe.id || 0;
        this.name = taxe && taxe.name || '';
        this.value = taxe && taxe.value || 0;
        this.createdAt = taxe && (taxe.createdAt || taxe.created_at) || '';
        this.updatedAt = taxe && (taxe.updatedAt || taxe.updated_at) || '';
    }
}

