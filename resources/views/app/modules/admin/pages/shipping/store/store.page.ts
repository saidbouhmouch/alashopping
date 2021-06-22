import { Component, Vue } from 'vue-property-decorator'
import { ShippingService } from "../../../../../business-logic/services/shipping.service"
import { CarrierService ,CountryService ,CurrencyService} from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"
import { ICountry , ICarrier, notify , ICurrency } from "../../../../../shared/"
import { Shipping , IShipping } from "../../../../../shared/models/shipping.model"
import vSelect from "vue-select";

@Component({
    components: {
        vSelect
    }
})
export default class ShippingAddPage extends Vue {

    shippingService: any = new ShippingService();
    shipping: IShipping = new Shipping();

    carrierService: any = new CarrierService();
    carriers: ICarrier[] = [];

    countryService = new CountryService();
    countries: ICountry[] = [];

    currencies: ICurrency[] = [];
    currencyService: any = new CurrencyService();


    logger: any = new Logger();
    isLoading: boolean = false;


    init() {
        this.isLoading = false;
        this.getCarriers();
        this.getCountries();
        this.getCurrencies();
    }

    getCountries() {
        this.countryService.getCountries().then((response) => {
            this.countries = response.data.countries;
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    getCarriers() {
        this.carriers = [];
        this.carrierService.getCarriers().then((response) => {
            this.carriers = response.data.carriers;
        }).catch((error) => {
            this.logger.error(error);
        });
    }

    getCurrencies() {
        this.currencyService.getCurrencies().then((response) => {
            this.currencies = response.data.currencies;
        }).catch((error) => {
            this.logger.error(error);
        });
    }

    onSelectedCurrency(currency) {
        this.shipping.currency = currency;
    }

    onSelectedFrom(country){
        this.shipping.from = country;
    }

    onSelectedTo(country){
        this.shipping.to = country;
    }

    onSelectedCarrier(carrier){
        this.shipping.carrier = carrier;
    }

    save(event) {
        event.preventDefault();
        this.isLoading = true;
        if (this.shipping.from.id !=0 && this.shipping.to.id !=0 && this.shipping.carrier.id !=0 && this.shipping.currency.id !=0 ) {

            this.shippingService.addShipping(this.shipping).then((resp) => {
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


