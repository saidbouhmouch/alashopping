import { Component, Vue } from 'vue-property-decorator'
import { ProductService } from "../../../../../business-logic/services/product.service"
import { Product, IProduct } from "../../../../../shared/models/product.model"
import { notify } from "../../../../../shared/notify/notify.service"
import { SpecificPriceService } from "../../../../../business-logic/services/specific-price.service"
import { SpecificPrice, ISpecificPrice } from "../../../../../shared/models/specific-price.model"
import { Logger } from "../../../../../core/"
import vSelect from "vue-select";

declare const moment: any;
// declare const $: any;

@Component({
    components: {
        vSelect
    }
})
export default class SpecificPriceAddPage extends Vue {

    logger: any = new Logger();
    isLoading: boolean = false;

    productService: any = new ProductService();
    products: IProduct[] = [];
    optionsProducts: IProduct[] = [];
    discountType : string[] = ['amount', 'percent'];


    specificPriceService: any = new SpecificPriceService();
    specificPrice: ISpecificPrice = new SpecificPrice();



    init() {
        this.isLoading = false;
        this.getProducts();
    }

    getProducts() {
        this.productService.getProducts().then((response) => {
            this.optionsProducts = response.data.products;
        }).catch((error) => {
            this.logger.error(error);
        });
    }


    onSelectedProduct(products) {
        this.products = products;
    }

    onSelectedDiscountType(discountType) {
        this.specificPrice.discountType = discountType;
    }

    minDate(_date?){
        const date = (_date)?moment(_date).format() : moment().format();
        return date.substring(0, 16);
    }


    save(event) {
        event.preventDefault();
        this.isLoading = true;

        if(this.products.length < 1 ){
            notify.topEnd("warning", "Information", 'Ops!! Please select product', true, 4000)
            this.isLoading = false;
            return;
        }

        if(!this.specificPrice.discountType){
            notify.topEnd("warning", "Information", 'Ops!! Please select discount Type', true, 4000)
            this.isLoading = false;
            return;
        }

        if( ! (this.specificPrice.reduction > 0) ){
            notify.topEnd("warning", "Information", 'Ops!! reduction is not greater than 0', true, 4000)
            this.isLoading = false;
            return;
        }

        if(moment(this.specificPrice.expirationDate).isBefore(this.specificPrice.startDate)){
            notify.topEnd("warning", "Information", 'Ops!! Expiration date is less than the start date', true, 4000)
            this.isLoading = false;
            return;
        }

        this.specificPriceService.addSpecificPrice(this.specificPrice,this.products).then((resp) => {
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

    }


    created() {
        this.init();
    }

    mounted() {}
};


