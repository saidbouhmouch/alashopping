import { Component, Vue  } from 'vue-property-decorator'
import { CarrierService } from "../../../../../business-logic"
import { Logger } from "../../../../../core"

declare const $: any;

@Component
export default class CarrierListPage extends Vue {

    carriers: Array<object> = [];
     carrierService: any = new CarrierService();
     logger: any = new Logger();

    constructor() {
        super();
    }

    pullCarriers() {
        this.carrierService.getCarriers().then((response) => {
            this.carriers = response.data.carriers;
            setTimeout(function () {
                $("#dataTable").DataTable({
                    responsive: true,
                });
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }


    carrierDelete(e, carrierId) {
        e.preventDefault();
        $(e.target).closest("tr").addClass("selected");
        this.carrierService.deleteCarrier(carrierId).then((response) => {
            setTimeout(function () {
                $('#dataTable').DataTable().row('.selected').remove().draw();
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    created() {
        this.pullCarriers();
    }

    mounted() { }

}
