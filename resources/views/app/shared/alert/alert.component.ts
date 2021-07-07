import { Component, Vue, Prop } from 'vue-property-decorator'
import { NotifyEnum} from '../../core/enum/notify.enum'; 

@Component({
    components: {}
})

export default class ErrorComponent extends Vue {

    @Prop() data!: any;
    type : NotifyEnum = NotifyEnum.info;
    notifyEnum = NotifyEnum;
    constructor() {
        super();
    }

    closeModal(event) {
        event.preventDefault();
        this.$emit('closeModal', true)
    }

    created() {
        this.type = this.data.type;
    }


    mounted() { }

    destroyed() {
    }

}
