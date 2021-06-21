import { Component, Vue } from 'vue-property-decorator'
import { ProductService } from '../../../../business-logic/services/product.service';
import { CategoryService } from '../../../../business-logic/services/category.service';
import { LocalStorageService } from '../../../../core/storage/localstorage.service';
import { Logger } from "../../../../core/logger/logger.service"
import { Filter, IFilter } from '../../../../shared/models/filter.model'
import { ISearch } from '../../../../shared/models/search.model'
import { CartService } from '../../../../business-logic/services/cart.service'

import VueAdsPagination, { VueAdsPageButton } from 'vue-ads-pagination';
import breadcrumbArea from '../../../../shared/components/client/breadcrumb-area/breadcrumb-area.component.vue'
import LoadingComponent from '../../../../shared/components/loading/loading.component.vue'
import CountDownComponent from '../../../../shared/components/client/countdown/countdown.component.vue'
import { Product } from '../../../../shared/models/product.model';



declare const preloader: any;
declare const _: any;
declare const $: any;

@Component({
    components: {
        breadcrumbArea,
        VueAdsPagination,
        VueAdsPageButton,
        LoadingComponent,
        CountDownComponent
    }
})

export default class ShopComponent extends Vue {

    isLoading: boolean = false;
    productService: any = new ProductService();
    categoryService: any = new CategoryService();
    localStorageService: any = new LocalStorageService();
    cartService: any = new CartService();
    logger: any = new Logger();
    filter: IFilter = new Filter();
    priceMax = 0;

    categories: Array<object> = [];
    products: Array<object> = [];
    priceRange = [0, 0];
    sizes = [9,12,18,24];

    searchByTerms: Array<ISearch> = [];


    constructor() {
        super();
    }

    getFilter() {
        this.filter = (this.localStorageService.getItem('filter')) ? JSON.parse(this.localStorageService.getItem('filter')) : new Filter();
        this.searchByTerms = this.filter.sortBy;
    }

    setFilter() {
        this.localStorageService.setItem('filter', this.filter);
    }

    getMaxPrice() {
        this.productService.getMaxPrice().then((response) => {
            this.priceMax = this.filter.price.max = response.data.maxPrice;
            this.setFilter();
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    getCategoriesWithProductsTotal() {
        this.categoryService.getCategoriesWithProductsTotal().then((response) => {
            this.categories = _.map(response.data.categories, (cat) => {
                return { ...cat, selected: false };
            });

            _.forEach(this.categories, (cat) => {
                const exist = _.findIndex(this.filter.categories, (slug) => {
                    return cat.slug == slug;
                });
                cat.selected = (exist == -1) ? false : true;
            });

        }).catch((error) => {
            this.logger.error(error);
        })
    }


    getProducts() {
        this.isLoading = false;
        this.scrollTop();
        this.products = [];
        this.productService.getProductsByfilter(this.filter).then((response) => {
            this.filter.from = response.data.products.from;
            this.filter.size = parseInt(response.data.products.size);
            this.filter.to = response.data.products.to;
            this.filter.totalElements = response.data.products.totalElements;
            this.filter.totalPages = response.data.products.totalPages;
            this.fillProducts(response.data.products.content);
            // this.setFilter();
            setTimeout(() => { this.isLoading = true; }, 2000);

        }).catch((error) => {
            this.logger.error(error);
            this.products = [];
            setTimeout(() => { this.isLoading = true; }, 2000);
        })
    }

    onChangeSize(e) {
        this.filter.size = parseInt(e.target.value);
        this.setFilter();
        this.getProducts();
    }

    onChangeSort(event, searchByTerm) {
        this.onCheckSearchByTerm(searchByTerm)
        this.filter.sortBy = this.searchByTerms;
        this.setFilter();
        this.getProducts();
    }

    onCheckSearchByTerm(searchByTerm) {

        if (searchByTerm.value == 'alphabetically_za' && searchByTerm.selected) {
            const exist = _.find(this.searchByTerms, (term) => {
                return term.value == 'alphabetically_az' && term.selected;
            });

            if (exist) {
                exist.selected = false;
            }
        }

        if (searchByTerm.value == 'alphabetically_az' && searchByTerm.selected) {
            const exist = _.find(this.searchByTerms, (term) => {
                return term.value == 'alphabetically_za' && term.selected;
            });

            if (exist) {
                exist.selected = false;
            }
        }

        if (searchByTerm.value == 'price_low_to_high' && searchByTerm.selected) {
            const exist = _.find(this.searchByTerms, (term) => {
                return term.value == 'price_high_to_low' && term.selected;
            });

            if (exist) {
                exist.selected = false;
            }
        }

        if (searchByTerm.value == 'price_high_to_low' && searchByTerm.selected) {
            const exist = _.find(this.searchByTerms, (term) => {
                return term.value == 'price_low_to_high' && term.selected;
            });

            if (exist) {
                exist.selected = false;
            }
        }
    }

    pageChange(page) {
        this.filter.page = page
        this.setFilter();
        this.getProducts();
    }
    onPriceChange(e) {
        console.log(e);
    }

    rangeChange(start, end) {
        console.log(start, end);
    }

    scrollTop() {
        $("html, body").animate({ scrollTop: 0 }, 600);
    }

    sliderRangePrice() {

        var min = this.filter.price.min;
        var max = this.filter.price.max;
        var value_min = 0;
        var value_max = this.priceMax;
        $('.slider-range-price').slider({
            range: true,
            min: value_min,
            max: value_max,
            values: [min, max],
            slide: (event, ui) => {
                this.filter.price.min = ui.values[0];
                this.filter.price.max = ui.values[1];
            }
        });
    }

    onSelectAllCategories(event) {

        _.forEach(this.categories, (cat) => {
            cat.selected = event.target.checked;
        });

        if (event.target.checked == false) {
            this.filter.categories = [];
        }

        this.filter.page = 0;
        this.setFilter();
        this.getProducts();
    }

    onCategoryChange(event) {

        const categories = _.filter(this.categories, (cat) => {
            return cat.selected
        });
        this.filter.categories = _.map(categories, (cat) => {
            return cat.slug
        });

        this.filter.page = 0;
        this.setFilter();
        this.getProducts();
    }

    addProductToCart(product) {
        this.cartService.addItem(product,1);
    }

    fillProducts(products : any){
       _.forEach(products,(prod : any)=>{
            const specificPrice = {...prod.specificPrice,price : prod.price};
            const product : any = {
                id : prod.id,
                name : prod.name,
                price : prod.price,
                slug : prod.slug,
                picture : prod.image,
                specificPrice
            };
            
            this.products.push(new Product(product));
       });
    }

    init() {
        this.getFilter();
        this.getCategoriesWithProductsTotal();
        this.getMaxPrice();
        this.getProducts();
        this.priceRange = [this.filter.price.min, this.filter.price.max]
        //this.sliderRangePrice();
    }

    created() {
        this.init();
    }

    mounted() {
        preloader();
    }

    destroyed() {
        document.querySelector(".preloader")?.classList.remove("hidden");
    }

}



