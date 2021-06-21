import { Component, Vue  } from 'vue-property-decorator'
import { SpecificPriceService } from "../../../../../business-logic/services/specific-price.service"
import { Logger } from "../../../../../core/logger/logger.service"

declare const $: any;
declare const _: any;

@Component
export default class SpecificPriceListPage extends Vue {

     specificPriceService: any = new SpecificPriceService();
     logger: any = new Logger();
     specificPrices: Array<object> = [];


    constructor() {
        super();
    }

    pullSpecificPrices() {
        console.log('pullSpecificPrices');
        this.specificPriceService.getSpecificPrices().then((response) => {
            this.mappingData(response.data.specificPrices)
            setTimeout(function () {
                $("#dataTable").DataTable({
                    responsive: true,
                });
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    specificPriceDelete(e, specificPriceId) {
        e.preventDefault();
        $(e.target).closest("tr").addClass("selected");
        this.specificPriceService.deleteSpecificPrice(specificPriceId).then((response) => {
            setTimeout(function () {
                $('#dataTable').DataTable().row('.selected').remove().draw();
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    mappingData(specificPrices){
        this.specificPrices = [];
        this.specificPrices = specificPrices;
    }

    reductionFormat(specificPrice){
      return (specificPrice.discount_type == "amount")? specificPrice.reduction +" "+specificPrice.product.currency.iso : specificPrice.reduction+"%";
    }

    caluculeReducedPrice(specificPrice){
        return (specificPrice.discount_type == "amount")?
        (specificPrice.product.price - specificPrice.reduction)+" "+specificPrice.product.currency.iso
        : (specificPrice.product.price - (specificPrice.product.price * ( specificPrice.reduction /100)  )).toFixed(2)+" "+specificPrice.product.currency.iso;
    }

    created() {
        this.pullSpecificPrices();
    }

    mounted() {
    }
}
