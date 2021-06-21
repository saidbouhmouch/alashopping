import { Component, Vue } from 'vue-property-decorator'
import { TaxeService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"

declare const $: any;

@Component
export default class TaxeListPage extends Vue {

    taxeService: any = new TaxeService();
    logger: any = new Logger();
   taxes: Array<object> = [];


    pullTaxes() {
        this.taxeService.getTaxes().then((response) => {
            this.taxes = response.data.taxes;
            setTimeout(function () {
                $("#dataTable").DataTable({
                    responsive: true,
                });
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    taxeDelete(e, taxeId) {
        e.preventDefault();
        $(e.target).closest("tr").addClass("selected");
        this.taxeService.deleteTaxe(taxeId).then((response) => {
            setTimeout(function () {
                $('#dataTable').DataTable().row('.selected').remove().draw();
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    created() {
        this.pullTaxes();
    }

    mounted() {
    }
}
