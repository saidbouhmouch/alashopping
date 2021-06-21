import { Component, Vue } from 'vue-property-decorator'
import breadcrumbArea from '../../../../shared/components/client/breadcrumb-area/breadcrumb-area.component.vue'
import aboutUsArea from '../../../../shared/components/client/about-us-area/about-us-area.component.vue'
import servicesArea from '../../../../shared/components/client/services-area/services-area.component.vue'
import testimonialArea from '../../../../shared/components/client/testimonial-area/testimonial-area.component.vue'
import coolFactsArea from '../../../../shared/components/client/cool-facts-area/cool-facts-area.component.vue'
import teamArea from '../../../../shared/components/client/team-area/team-area.component.vue'

declare const preloader : any ;

@Component({
  components: {
    breadcrumbArea,
    aboutUsArea,
    servicesArea,
    testimonialArea,
    coolFactsArea,
    teamArea
  }
})

export default class AboutComponent extends Vue {

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




