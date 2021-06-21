import { Component, Vue } from 'vue-property-decorator'
import breadcrumbArea from '../../../../shared/components/client/breadcrumb-area/breadcrumb-area.component.vue'
import contactArea from '../../../../shared/components/client/contact-area/contact-area.component.vue'

declare const preloader : any ;

@Component({
  components: {
    breadcrumbArea,
    contactArea
  }
})

export default class ContactComponent extends Vue {

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



