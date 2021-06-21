import Vue from 'vue'
import router from './router.module'
import AppPage from './app.page.vue'


new Vue({
    el: '#app',
    name:"app",
    components: {
        'app-main': AppPage
    },
    router,
});
