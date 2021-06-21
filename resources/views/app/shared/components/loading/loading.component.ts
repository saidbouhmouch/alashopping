import { Component, Vue,Prop } from 'vue-property-decorator'

@Component
export default class LoadingComponent extends Vue {

  @Prop() height!: number;
  @Prop() width!: number;

  constructor() {
    super();
  }

  created() { }

  mounted() { }

  destroyed() { }

}



