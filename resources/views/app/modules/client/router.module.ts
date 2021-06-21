import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      redirect: '/home',
      component: () => import("./layout/master/master.component.vue"),
      children: [
        {
          path: '/home',
          name: 'home',
          component : () => import("./pages/home/home.page.vue"),
        },
        {
          path: '/about',
          name: 'about',
          component: () => import("./pages/about/about.page.vue")
        },
        {
          path: '/shop',
          name: 'shop',
          component: () => import("./pages/shop/shop.page.vue")
        },
        {
          path: '/shop-details/:slug',
          name: 'shop-details',
          component: () => import("./pages/shop-details/shop-details.page.vue")
        },
        {
          path: '/cart',
          name: 'cart',
          component: () => import("./pages/cart/cart.page.vue")
        },
        {
          path: '/checkout',
          name: 'checkout',
          component: () => import("./pages/checkout/checkout.page.vue")
        },
        {
          path: '/contact',
          name: 'contact',
          component: () => import("./pages/contact/contact.page.vue")
        }
      ]
    }
  ]
})
