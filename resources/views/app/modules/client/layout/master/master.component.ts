import { Component, Vue } from 'vue-property-decorator'
import FooterComponent from '../footer/footer.component.vue';
import HeaderComponent from '../header/header.component.vue';
import Notifications from 'vue-notification'
import { StateService } from '../../../../core/state/state.service';

Vue.use(Notifications);

@Component({
  components: {
    HeaderComponent,
    FooterComponent
  }
})

export default class MasterComponent extends Vue {

  constructor() {
    super();
  }

  created() {
    StateService.$on('notify', (data) => {
      console.log('notify');
      this.notify(data);
    });
  }

  notify(msg) {
    this.$notify({
      group: 'alashopping',
      title: msg.title,
      text: msg.text,
      type:msg.type
    });
  }

  mounted() { }

  destroyed() {
  }

}
