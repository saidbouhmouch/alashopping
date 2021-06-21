import { Component, Vue } from 'vue-property-decorator'
import sliderArea from '../../../../shared/components/client/slider-area/slider-area.component.vue'
import servicesArea from '../../../../shared/components/client/services-area/services-area.component.vue'
import aboutUsArea from '../../../../shared/components/client/about-us-area/about-us-area.component.vue'
import portfolioArea  from '../../../../shared/components/client/portfolio-area/portfolio-area.component.vue'
import testimonialArea from '../../../../shared/components/client/testimonial-area/testimonial-area.component.vue'
import newArrivalsProductsArea from '../../../../shared/components/client/new-arrivals-products-area/new-arrivals-products-area.component.vue'
import blogArea from '../../../../shared/components/client/blog-area/blog-area.component.vue'
import subscribeNewsletterArea from '../../../../shared/components/client/subscribe-newsletter-area/subscribe-newsletter-area.component.vue'
import contactArea from '../../../../shared/components/client/contact-area/contact-area.component.vue'
// import breadcrumbArea from '../../../../shared/components/client/breadcrumb-area/breadcrumb-area.component.vue'

declare const preloader : any ;
@Component({
  components: {
    // breadcrumbArea,
    contactArea,
    sliderArea,
    servicesArea,
    aboutUsArea,
    portfolioArea,
    testimonialArea,
    newArrivalsProductsArea,
    blogArea,
    subscribeNewsletterArea
  }
})

export default class HomeComponent extends Vue {

    constructor() {
        super();
    }

    created() {
    }

    mounted() {
        preloader();
    }

    destroyed(){
        document.querySelector(".preloader")?.classList.remove("hidden");
    }

}








