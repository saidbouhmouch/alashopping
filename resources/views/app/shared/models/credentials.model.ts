export interface ICredentials {
        username: string;
        token: string;
        remember?: boolean;
}

export class Credentials {
        username: string;
        token: string;
        remember?: boolean;
        
        constructor() {
                this.username = '';
                this.token = '';
                this.remember = false;
        }
}
