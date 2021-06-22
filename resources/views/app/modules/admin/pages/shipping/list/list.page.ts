import { Component, Vue  } from 'vue-property-decorator'
import { ShippingService } from "../../../../../business-logic/services/shipping.service"
import { Logger } from "../../../../../core"
import { Shipping } from '../../../../../shared/models/shipping.model';

declare const $: any;
declare const _: any;

@Component
export default class ShippingListPage extends Vue {

     shippings: Array<object> = [];
     shippingService: any = new ShippingService();
     logger: any = new Logger();

    constructor() {
        super();
    }

    getShippings() {
        this.shippingService.getShippings().then((response) => {
        
            this.shippings = [];
            _.forEach(response.data.shippings,(shipping)=>{
                this.shippings.push(new Shipping(shipping));
            })
            console.log(this.shippings);
            setTimeout(function () {
                $("#dataTable").DataTable({
                    responsive: true,
                });
            }, 100);
        }).catch((error) => {
            this.logger.error(error);
        })
    }


    deleteShipping(e, shippingId) {
        e.preventDefault();
        $(e.target).closest("tr").addClass("selected");
        this.shippingService.deleteShipping(shippingId).then((response) => {
            setTimeout(function () {
                $('#dataTable').DataTable().row('.selected').remove().draw();
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    created() {
        this.getShippings();
    }

    mounted() { }

}
