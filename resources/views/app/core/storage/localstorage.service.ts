import { environment } from "../"

export class LocalStorageService {

  resourceName: string = '';
  version: string = '';

  constructor() {
    this.resourceName = environment.appName;
    this.version = environment.version;
  }


  setItem(key: string, data: any) {
    key = this.generateKey(key);
    localStorage.setItem(key, JSON.stringify(data));
  }

  removeItem(key) {
    key = this.generateKey(key);
    localStorage.removeItem(key);
  }

  getItem(key) {
    key = this.generateKey(key);
    if (localStorage.getItem(key)) {
      return JSON.parse(JSON.stringify(localStorage.getItem(key)));
    }
    return undefined;
  }

  generateKey(key): string {
    return this.resourceName.toLocaleUpperCase() +'-'+ key.toLocaleUpperCase() +'-'+ this.version;
  }

  clear() {
    localStorage.clear();
  }
}
