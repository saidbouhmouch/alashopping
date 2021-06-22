import Vue from "vue";
import Router from "vue-router";
import { CredentialsService } from "../../core";
const credentialsService = new CredentialsService();
Vue.use(Router);

export default new Router({
    mode: "history",
    routes: [
        { path: '*', component: () => import("./pages/not-found/not-found.page.vue") },
        {
            path: '/admin/login',
            component: () => import("./pages/login/login.page.vue"),
            name: "login"
        },
        {
            path: "/admin",
            redirect: "/admin/dashboard",
            component: () => import("./layout/master/master.component.vue"),
            beforeEnter: (to, from, next) => {
                credentialsService.getCredentials();
                console.log('enter');
                if (!credentialsService.isAuthenticated() && !credentialsService.isAdmin()) {
                    next({ name: 'login' })
                }
                else {
                    next();
                }
            },
            children: [
                {
                    path: "/admin/dashboard",
                    name: "dashboard",
                    component: () => import("./pages/dashboard/dashboard.page.vue")
                }, {
                    path: "/admin/users",
                    redirect: "/admin/users/list",
                    name: "users",
                    component: () => import("./pages/users/users.page.vue"),
                    children: [
                        {
                            path: "/admin/users/list",
                            name: "userList",
                            component: () => import("./pages/users/list/list.page.vue")
                        },
                        {
                            path: "/admin/users/create",
                            name: "userCreate",
                            component: () => import("./pages/users/store/store.page.vue")
                        },
                        {
                            path: "/admin/users/:id/edit",
                            name: "userUpdate",
                            component: () => import("./pages/users/update/update.page.vue")
                        }
                    ]
                },
                {
                    path: "/admin/categories",
                    redirect: "/admin/categories/list",
                    name: "categories",
                    component: () => import("./pages/categories/categories.page.vue"),
                    children: [
                        {
                            path: "/admin/categories/list",
                            name: "categoryList",
                            component: () => import("./pages/categories/list/list.page.vue")
                        },
                        {
                            path: "/admin/categories/create",
                            name: "categoryCreate",
                            component: () => import("./pages/categories/store/store.page.vue")
                        },
                        {
                            path: "/admin/categories/:id/edit",
                            name: "categoryUpdate",
                            component: () => import("./pages/categories/update/update.page.vue")
                        }
                    ]
                },
                {
                    path: "/admin/tags",
                    redirect: "/admin/tags/list",
                    name: "tags",
                    component: () => import("./pages/tags/tag.page.vue"),
                    children: [
                        {
                            path: "/admin/tags/list",
                            name: "tagList",
                            component: () => import("./pages/tags/list/list.page.vue")
                        },
                        {
                            path: "/admin/tags/create",
                            name: "tagCreate",
                            component: () => import("./pages/tags/store/store.page.vue")
                        },
                        {
                            path: "/admin/tags/:id/edit",
                            name: "tagUpdate",
                            component: () => import("./pages/tags/update/update.page.vue")
                        }
                    ]
                },
                {
                    path: "/admin/taxes",
                    redirect: "/admin/taxes/list",
                    name: "taxes",
                    component: () => import("./pages/taxes/taxes.page.vue"),
                    children: [
                        {
                            path: "/admin/taxes/list",
                            name: "taxeList",
                            component: () => import("./pages/taxes/list/list.page.vue")
                        },
                        {
                            path: "/admin/taxes/create",
                            name: "taxeCreate",
                            component: () => import("./pages/taxes/store/store.page.vue")
                        },
                        {
                            path: "/admin/taxes/:id/edit",
                            name: "taxeUpdate",
                            component: () => import("./pages/taxes/update/update.page.vue")
                        }
                    ]
                },
                {
                    path: "/admin/currencies",
                    redirect: "/admin/currencies/list",
                    name: "currencies",
                    component: () => import("./pages/currencies/currencies.page.vue"),
                    children: [
                        {
                            path: "/admin/currencies/list",
                            name: "currencyList",
                            component: () => import("./pages/currencies/list/list.page.vue")
                        },
                        {
                            path: "/admin/currencies/create",
                            name: "currencyCreate",
                            component: () => import("./pages/currencies/store/store.page.vue")
                        },
                        {
                            path: "/admin/currencies/:id/edit",
                            name: "currencyUpdate",
                            component: () => import("./pages/currencies/update/update.page.vue")
                        }
                    ]
                },
                {
                    path: "/admin/type-payment",
                    redirect: "/admin/type-payment/list",
                    name: "typePayment",
                    component: () => import("./pages/type-payment/type-payment.page.vue"),
                    children: [
                        {
                            path: "/admin/type-payment/list",
                            name: "typePaymentList",
                            component: () => import("./pages/type-payment/list/list.page.vue")
                        },
                        {
                            path: "/admin/type-payment/create",
                            name: "typePaymentCreate",
                            component: () => import("./pages/type-payment/store/store.page.vue")
                        },
                        {
                            path: "/admin/type-payment/:id/edit",
                            name: "typePaymentUpdate",
                            component: () => import("./pages/type-payment/update/update.page.vue")
                        }
                    ]
                },
                {
                    path: "/admin/carriers",
                    redirect: "/admin/carriers/list",
                    name: "carriers",
                    component: () => import("./pages/carriers/carriers.page.vue"),
                    children: [
                        {
                            path: "/admin/carriers/list",
                            name: "carrierList",
                            component: () => import("./pages/carriers/list/list.page.vue")
                        },
                        {
                            path: "/admin/carriers/create",
                            name: "carrierCreate",
                            component: () => import("./pages/carriers/store/store.page.vue")
                        },
                        {
                            path: "/admin/carriers/:id/edit",
                            name: "carrierUpdate",
                            component: () => import("./pages/carriers/update/update.page.vue")
                        }
                    ]
                },
                {
                    path: "/admin/products",
                    redirect: "/admin/products/list",
                    name: "products",
                    component: () => import("./pages/products/products.page.vue"),
                    children: [
                        {
                            path: "/admin/products/list",
                            name: "productList",
                            component: () => import("./pages/products/list/list.page.vue")
                        }
                        , {
                            path: "/admin/products/create",
                            name: "productCreate",
                            component: () => import("./pages/products/store/store.page.vue")
                        },
                        {
                            path: "/admin/products/:id/edit",
                            name: "ProductUpdate",
                            component: () => import("./pages/products/update/update.page.vue")
                        }
                    ]
                },
                {
                    path: "/admin/specific-prices",
                    redirect: "/admin/specific-prices/list",
                    name: "specific-prices",
                    component: () => import("./pages/specific-prices/specific-price.page.vue"),
                    children: [
                        {
                            path: "/admin/specific-prices/list",
                            name: "specificPricesList",
                            component: () => import("./pages/specific-prices/list/list.page.vue")
                        }
                        , {
                            path: "/admin/specific-prices/create",
                            name: "specificPriceCreate",
                            component: () => import("./pages/specific-prices/store/store.page.vue")
                        }
                        , {
                            path: "/admin/specific-prices/:id/edit",
                            name: "specificPriceUpdate",
                            component: () => import("./pages/specific-prices/update/update.page.vue")
                        }
                    ]
                },
                {
                    path: "/admin/shipping",
                    redirect: "/admin/shipping/list",
                    name: "shipping",
                    component: () => import("./pages/shipping/shipping.page.vue"),
                    children: [
                        {
                            path: "/admin/shipping/list",
                            name: "shippingList",
                            component: () => import("./pages/shipping/list/list.page.vue")
                        }
                        , {
                            path: "/admin/shipping/create",
                            name: "shippingCreate",
                            component: () => import("./pages/shipping/store/store.page.vue")
                        }
                        // , {
                        //     path: "/admin/shipping/:id/edit",
                        //     name: "specificPriceUpdate",
                        //     component: () => import("./pages/shipping/update/update.page.vue")
                        // }
                    ]
                }
            ]
        }
    ]
});
