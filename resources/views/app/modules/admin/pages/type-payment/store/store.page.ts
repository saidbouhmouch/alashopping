import { Component, Vue } from 'vue-property-decorator'
import { TypePaymentService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"
import { TypePayment, ITypePayment, notify } from "../../../../../shared/"
import uploadImage from '../../../../../shared/components/admin/upload-image/upload-image.component.vue'


@Component({
    components: {
        "upload-image": uploadImage
    }
})
export default class TypePaymentAddPage extends Vue {

     typePaymentService: any = new TypePaymentService();
     logger: any = new Logger();
    isLoading: boolean = false;
    typePayment: ITypePayment = new TypePayment();


    init() {
        this.isLoading = false;
        this.typePayment.picture.url = '';
    }

    onChangePicture(picture) {
        this.typePayment.picture.name = picture.name;
        this.typePayment.picture.url = picture.url;
        this.typePayment.picture.type = picture.type;
    }

    save(event) {
        event.preventDefault();
        this.isLoading = true;
        if (this.typePayment.picture.url != '') {

            this.typePaymentService.addTypePayment(this.typePayment).then((resp) => {
                if (resp.data.success) {
                    notify.topEnd("success", "Information", resp.data.message, true, 4000)
                } else if (!resp.data.success) {
                    notify.topEnd("error", "Error", resp.data.message, true, 4000)
                }
                setTimeout(() => { this.isLoading = false; }, 1000);
            }).catch((error) => {
                this.logger.error(error);
                this.isLoading = false;
            });
        } else {
            this.isLoading = false;
            notify.topEnd("warning", "Information", 'Ops!! Please select an image', true, 4000)
        }
    }

    created() {
        this.init();
    }

    mounted() { }
}


