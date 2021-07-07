import { Component, Vue } from 'vue-property-decorator'
import FooterComponent from '../footer/footer.component.vue';
import HeaderComponent from '../header/header.component.vue';
import { StateService } from '../../../../core/state/state.service';
// import { NotifyEnum} from '../../../../core/enum/notify.enum'; 
import AlertComponent from '../../../../shared/alert/alert.component.vue'


@Component({
  components: {
    HeaderComponent,
    FooterComponent,
    AlertComponent
  }
})

export default class MasterComponent extends Vue {
  isShowAlert: boolean = false;
  notifyData : any = {};

  constructor() {
    super();
  }

  created() {
    StateService.$on('notify', (data) => {
      console.log('notify');
      this.notify(data);
    });
  }

  toggleAlert() {
    this.isShowAlert = !this.isShowAlert;
  }

  notify(notify) {
    this.notifyData = notify;
    this.toggleAlert();
    if (notify.time > -1) {
      setTimeout(() => { this.toggleAlert() }, notify.time)
    }
  }

  mounted() { }

  destroyed() {
  }

}
