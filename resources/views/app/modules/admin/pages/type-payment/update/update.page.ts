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
export default class TypePaymentUpdatePage extends Vue {

    typePaymentService: any = new TypePaymentService();
    logger: any = new Logger();
    isLoading: boolean = false;
    typePayment: ITypePayment = new TypePayment();


    init() {
        this.isLoading = false;
    }

    getTypePayment(id) {
        this.typePaymentService.getTypePayment(id).then((response) => {
            this.typePayment.id = response.data.typePayment.id,
            this.typePayment.name = response.data.typePayment.name;
            this.typePayment.slug = response.data.typePayment.slug
            this.typePayment.picture.id = response.data.picture.id;
            this.typePayment.picture.name = response.data.picture.name;
            this.typePayment.picture.url = response.data.picture.url;
            this.typePayment.picture.type = response.data.picture.type;
            this.typePayment.picture.update = false;
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    onChangePicture(picture) {
        this.typePayment.picture.name = picture.name;
        this.typePayment.picture.url = picture.url;
        this.typePayment.picture.type = picture.type;
        this.typePayment.picture.update = true;
    }

    save(event) {
        event.preventDefault();
        this.isLoading = true;
        if (this.typePayment.picture.url != '') {

            this.typePaymentService.updateTypePayment(this.typePayment, this.typePayment.id).then((resp) => {
                if (resp.data.success) {
                    notify.topEnd("success", "Information", resp.data.message, true, 4000)
                } else if (!resp.data.success) {
                    notify.topEnd("error", "Error", resp.data.message, true, 4000)
                }

                setTimeout(() => { this.isLoading = false; }, 1000);
                this.typePayment.picture.update = false;
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
        this.getTypePayment(this.$route.params.id);
    }

    mounted() { }
};


