
/**
 * Picture model
 */
export interface IPicture {

        id: number;
        name: string;
        url: string;
        type: string;
        update : boolean;
        createdAt?: string;
        updatedAt?: string;
}

export class Picture {

        id: number;
        name: string;
        url: string;
        type: string;
        update : boolean;
        createdAt?: string;
        updatedAt?: string;


        constructor();
        constructor(picture: IPicture); 
        constructor(picture? : any) {
                this.id = picture && picture.id || 0;
                this.name = picture && picture.name || '';
                this.url = picture && picture.url || '';
                this.type = picture && picture.type || '';
                this.update = picture && picture.update || false;
                this.createdAt = picture && (picture.createdAt || picture.created_at ) || '';
                this.updatedAt = picture && (picture.updatedAt || picture.updated_at ) || '';
        }
}

