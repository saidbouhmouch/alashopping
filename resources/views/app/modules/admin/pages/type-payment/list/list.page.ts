import { Component, Vue } from 'vue-property-decorator'
import { TypePaymentService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"

declare const $: any;

@Component
export default class TypePaymentListPage extends Vue {

    typePayments: Array<object> = [];
     typePaymentService: any = new TypePaymentService();
     logger: any = new Logger();

    pullTypePayments() {
        this.typePaymentService.getTypePayments().then((response) => {
            this.typePayments = response.data.typePayments;
            setTimeout(function () {
                $("#dataTable").DataTable({
                    responsive: true,
                });
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    typePaymentDelete(e, typePaymentId) {
        e.preventDefault();
        $(e.target).closest("tr").addClass("selected");
        this.typePaymentService.deleteTypePayment(typePaymentId).then((response) => {
            setTimeout(function () {
                $('#dataTable').DataTable().row('.selected').remove().draw();
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    created() {
        this.pullTypePayments();
    }

    mounted() {
    }
}
