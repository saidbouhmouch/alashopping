  import { Component, Vue } from 'vue-property-decorator'
  import FooterComponent from '../footer/footer.component.vue';
  import HeaderComponent from '../header/header.component.vue';
  import SideBarComponent from '../sidebar/sidebar.component.vue';

  
  @Component({
    components: {
       HeaderComponent,
       SideBarComponent,
       FooterComponent
    }
  })

  export default class MasterComponent extends Vue {

  }
