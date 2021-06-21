import { Component, Vue } from 'vue-property-decorator'
import { CarrierService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"
import { Carrier, ICarrier, notify } from "../../../../../shared/"
import uploadImage from '../../../../../shared/components/admin/upload-image/upload-image.component.vue'


@Component({
    components: {
        "upload-image": uploadImage
    }
})
export default class CarrierAddPage extends Vue {

     carrierService: any = new CarrierService();
    logger: any = new Logger();
    isLoading: boolean = false;
    carrier: ICarrier = new Carrier();


    init() {
        this.isLoading = false;
        this.carrier.picture.url = '';

    }

    onChangePicture(picture) {
        this.carrier.picture.name = picture.name;
        this.carrier.picture.url = picture.url;
        this.carrier.picture.type = picture.type;
    }

    save(event) {
        event.preventDefault();
        this.isLoading = true;
        if (this.carrier.picture.url != '') {

            this.carrierService.addCarrier(this.carrier).then((resp) => {
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


