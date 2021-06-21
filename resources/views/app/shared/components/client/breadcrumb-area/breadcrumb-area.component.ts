import { Component, Prop,Vue } from 'vue-property-decorator'

@Component
export default class BreadCrumbAreaComponent extends Vue {

    @Prop() title!: string;
    constructor() {
        super();
    }

    created() {
    }

    mounted() {}

    destroyed(){
    }

}
