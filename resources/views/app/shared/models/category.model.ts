/**
 *   Category model
 */
export interface ICategory {

        id: number;
        name: string;
        slug: string;
        description: string;
        parentId: any;
        createdAt: string;
        updatedAt: string;
}

export class Category {

        id: number;
        name: string;
        slug: string;
        description: string;
        parentId: any;
        createdAt: string;
        updatedAt: string;

        constructor() {
                this.id = -1;
                this.name = '';
                this.slug = '';
                this.description = '';
                this.parentId = null;
                this.createdAt = '';
                this.updatedAt = '';
        }
}

