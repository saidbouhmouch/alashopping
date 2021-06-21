import { Component, Vue ,Prop , Watch} from 'vue-property-decorator'

@Component
export default class LoaderComponent extends Vue {

    @Prop({default: true}) isVisible: boolean;

    constructor(){
        super();
    }

    created() { }

    mounted() { }
}


