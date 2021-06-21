/**
 *   Tag model
 */
export interface ITag {

    id: number;
    name: string;
    slug: string;
    createdAt: string;
    updatedAt: string;
}

export class Tag {

    id: number;
    name: string;
    slug: string;
    createdAt: string;
    updatedAt: string;

    constructor() {
        this.id = -1;
        this.name = '';
        this.slug = '';
        this.createdAt = '';
        this.updatedAt = '';
    }

}
