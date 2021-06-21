import { Component, Vue } from 'vue-property-decorator'
import { CurrencyService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"

declare const $: any;

@Component
export default class CurrencyListPage extends Vue {
     currencyService: any = new CurrencyService();
     logger: any = new Logger();
    currencies: Array<object> = [];

    pullCurrencies() {
        this.currencyService.getCurrencies().then((response) => {
            this.currencies = response.data.currencies;
            setTimeout(function () {
                $("#dataTable").DataTable({
                    responsive: true,
                });
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    currencyDelete(e, currencyId) {
        e.preventDefault();
        $(e.target).closest("tr").addClass("selected");
        this.currencyService.deleteCurrency(currencyId).then((response) => {
            setTimeout(function () {
                $('#dataTable').DataTable().row('.selected').remove().draw();
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }
    created() {
        this.pullCurrencies();
    }

    mounted() {
    }
}
