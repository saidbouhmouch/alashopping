import { Component, Vue } from 'vue-property-decorator'
import breadcrumbArea from '../../../../shared/components/client/breadcrumb-area/breadcrumb-area.component.vue'
import relatedProductsArea from '../../../../shared/components/client/related-products-area/related-products-area.component.vue'
import CountDownComponent from '../../../../shared/components/client/countdown/countdown.component.vue'

import { ProductService } from '../../../../business-logic/services/product.service';
import { LocalStorageService } from '../../../../core/storage/localstorage.service';
import { Logger } from "../../../../core/logger/logger.service"
import { Product , IProduct } from '../../../../shared/models/product.model'
// import LoadingComponent from '../../../../shared/components/loading/loading.component.vue'
// import VueAdsPagination, { VueAdsPageButton } from 'vue-ads-pagination';
import { CartService } from '../../../../business-logic/services/cart.service'
declare const preloader : any;
declare const _ : any;
declare const $ : any;

@Component({
    components: {
        breadcrumbArea,
        relatedProductsArea,
        CountDownComponent
        // LoadingComponent
    }
})

export default class ShopDetailComponent extends Vue {

    isLoading: boolean = false;
    productService: any = new ProductService();
    localStorageService: any = new LocalStorageService();
    cartService: any = new CartService();
    logger: any = new Logger();

    product: IProduct = new Product();
    categories: string = '';
    tags: string = '';
    quantity : number =1;
    isAddProduct : boolean = false;

    constructor() {
        super();
    }

    getProduct(slug) {
        this.isLoading = false;
        this.productService.getProductBySlug(slug).then((response) => {
            const product : any  = response.data.product;
            this.tags = response.data.tags ;
            this.categories = response.data.categories;
            if(product.specificPrice){
                product.specificPrice = {...response.data.product.specificPrice,price:product.price};
            }
            this.product = new Product(product);
            setTimeout(() => { this.isLoading = true; preloader(); }, 2000);

        }).catch((error) => {
            this.logger.error(error);
            this.product = new Product();
            setTimeout(() => { this.isLoading = true;  preloader();}, 2000);
        })
    }

    qtyMinus(){
        if(this.quantity > 1){
            this.quantity--;
        }
    }

    qtyplus(){
        this.quantity++;
    }

    addProductToCart(){
        this.cartService.addItem(this.product,this.quantity);
        this.isAddProduct = true;
        setTimeout(() => { this.isAddProduct =false; }, 2100);
    }
   
    init() {
        this.getProduct(this.$route.params.slug);
    }

    created() {
        console.log(this.product);
        this.init();
    }

    mounted() {
    }

    destroyed() {
        document.querySelector(".preloader")?.classList.remove("hidden");
    }

}











