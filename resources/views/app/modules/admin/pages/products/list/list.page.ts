import { Component, Vue  } from 'vue-property-decorator'
import { ProductService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"

declare const $: any;

@Component
export default class ProductListPage extends Vue {

     productService: any = new ProductService();
     logger: any = new Logger();
     products: Array<object> = [];


    constructor() {
        super();
    }

    pullProducts() {
        this.productService.getProducts().then((response) => {
            this.products = response.data.products;
            setTimeout(function () {
                $("#dataTable").DataTable({
                    responsive: true,
                });
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    productDelete(e, productId) {
        e.preventDefault();
        $(e.target).closest("tr").addClass("selected");
        this.productService.deleteProduct(productId).then((response) => {
            setTimeout(function () {
                $('#dataTable').DataTable().row('.selected').remove().draw();
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    created() {
        this.pullProducts();
    }

    mounted() {
    }
}
