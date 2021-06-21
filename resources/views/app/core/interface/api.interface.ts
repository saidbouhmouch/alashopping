export interface IApi {
    resourceName : string;
    get(path : any);
    post(path, data);
    put(path, data);
    delete(id : any);

}