import { Component, Vue } from 'vue-property-decorator'
import { CurrencyService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"
import { Currency, ICurrency, notify } from "../../../../../shared/"

declare const $: any;

@Component
export default class CurrencyAddPage extends Vue {

     currencyService: any = new CurrencyService();
     logger: any = new Logger();
    isLoading: boolean = false;
    currency: ICurrency = new Currency();

    init() {
        this.isLoading = false;
        this.currency.default = false;
    }

    save(event) {
        event.preventDefault();
        this.isLoading = true;
        this.currencyService.addCurrency(this.currency).then((resp) => {
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


