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
export default class CarrierUpdatePage extends Vue {

    carrierService: any = new CarrierService();
    logger: any = new Logger();

    carrier: ICarrier = new Carrier();
    isLoading: boolean = false;

    init() {
        this.isLoading = false;
        this.carrier.picture.url = '';
    }

    getCarrier(id) {
        this.carrierService.getCarrier(id).then((response) => {
            this.carrier.id = response.data.carrier.id;
            this.carrier.name = response.data.carrier.name;
            this.carrier.slug = response.data.carrier.slug;
            this.carrier.price = response.data.carrier.price;
            this.carrier.deliveryText = response.data.carrier.delivery_text;

            this.carrier.picture.id = response.data.picture.id;
            this.carrier.picture.name = response.data.picture.name;
            this.carrier.picture.url = response.data.picture.url;
            this.carrier.picture.type = response.data.picture.type;
            this.carrier.picture.update = false;

        }).catch((error) => {
            this.logger.error(error);
        })
    }

    onChangePicture(picture) {
        this.carrier.picture.name = picture.name;
        this.carrier.picture.url = picture.url;
        this.carrier.picture.type = picture.type;
        this.carrier.picture.update = true;
    }

    update(event) {
        event.preventDefault();
        this.isLoading = true;
        if (this.carrier.picture.url != '') {

            this.carrierService.updateCarrier(this.carrier, this.carrier.id).then((resp) => {
                if (resp.data.success) {
                    notify.topEnd("success", "Information", resp.data.message, true, 4000)
                } else if (!resp.data.success) {
                    notify.topEnd("error", "Error", resp.data.message, true, 4000)
                }
                setTimeout(() => { this.isLoading = false; }, 1000);
                this.carrier.picture.update = false;
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
        this.getCarrier(this.$route.params.id);
    }

    mounted() { }
};


