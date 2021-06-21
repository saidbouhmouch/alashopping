import { Component, Vue } from 'vue-property-decorator'
import { CurrencyService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"
import { Currency, ICurrency, notify } from "../../../../../shared/"

declare const $: any;

@Component
export default class CurrencyUpdatePage extends Vue {

     currencyService: any = new CurrencyService();
     logger: any = new Logger();
    isLoading: boolean = false;
    currency: ICurrency = new Currency();


    init() {
        this.isLoading = false;
        this.getCurrency(this.$route.params.id);
    }

    getCurrency(id) {
        this.currencyService.getCurrency(id).then((response) => {
            this.currency.id = response.data.currency.id,
            this.currency.name = response.data.currency.name;
            this.currency.iso = response.data.currency.iso;
            this.currency.value = response.data.currency.value;
            this.currency.default = response.data.currency.default;
        }).catch((error) => {
            this.logger.error(error);
        })
    }


    update(event) {
        event.preventDefault();
        this.isLoading = true;
        this.currencyService.updateCurrency(this.currency, this.currency.id).then((resp) => {
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
    mounted() { }
};


