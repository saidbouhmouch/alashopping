export interface ILoginContext {
    username: string;
    password: string;
    remember?: boolean;
  }

  export class LoginContext {

    username: string;
    password: string;
    remember?: boolean;

    constructor() {
        this.username = '';
        this.password = '';
        this.remember = false;
    }
}