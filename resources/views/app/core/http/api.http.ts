import { environment } from "../";
import { CredentialsService } from "../../core";
import { notify } from "../../shared/notify/notify.service";
import axios from "axios";
import qs from "qs";
const _self : any = this;
/**
 * parse response
 */
function parseBody(response) {
    if (response.status === 200) {
        return response;
    } else if (response.status === 401 || response.status === 403) {
        localStorage.clear();
       _self.$router.replace({ name: 'login' });
    } else {
        return errorHandling(response.data.messages);
    }
}

/**
 * axios instance
 */

let instance = axios.create({
    baseURL: `${environment.serverUrl}`,
    paramsSerializer: function (params) {
        return qs.stringify(params, { indices: false });
    }
});

// request header
instance.interceptors.request.use(
    config => {
        const credentialsService = new CredentialsService();
        const el: any = document.querySelector("head meta[name='csrf-token']");
        const apiToken = "Bearer  " + el.getAttribute("content");
        config.headers = { "X-CSRF-TOKEN": apiToken };
        credentialsService.getCredentials();
        if (credentialsService.isAuthenticated() && credentialsService.isAdmin()) {
            config.headers['Authorization'] = "Bearer  " + credentialsService.credentials?.token;
        }
        return config;
    },
    error => {
        return Promise.reject(error);
    }
);

// response parse
instance.interceptors.response.use(
    response => {
        return parseBody(response);
    },
    error => {
        console.error(error);
        notify.topEnd("error", "Ops!!", error.response.status + ' ' + error.response.statusText, true, 4000);
        if (error.response) {
            return errorHandling(error.response);
        } else {
            return Promise.reject(error);
        }
    }
);

function errorHandling(error) {
    if (error) {
        console.log(error.status);
        if (error.status === 403 || error.status === 401) {
            localStorage.clear();
           setTimeout(() => {
             window.location.href = '/';
           }, 5000);
            return error;
        }
        if (error instanceof Array) {
            return Promise.reject({ messages: error });
        } else {
            return Promise.reject({ messages: [error] });
        }
    } else {
        return Promise.reject({
            messages: ["An error has occurred. Please try again"]
        });
    }
}

export const apiHttp = instance;
