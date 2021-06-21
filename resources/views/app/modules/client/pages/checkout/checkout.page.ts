import { Component, Vue } from 'vue-property-decorator'
import breadcrumbArea from '../../../../shared/components/client/breadcrumb-area/breadcrumb-area.component.vue'
declare const preloader : any ;

@Component({
  components: {
    breadcrumbArea
  }
})

export default class CheckoutComponent extends Vue {

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
