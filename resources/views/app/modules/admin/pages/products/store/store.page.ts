import { Component, Vue } from 'vue-property-decorator'
import { CategoryService, ProductService, TagService, TaxeService, CurrencyService } from "../../../../../business-logic/"
import {
    Product, IProduct,
    notify, ITaxe,
    ICurrency,
    ICategory,
    ITag,
    IPicture
} from "../../../../../shared/"
import { Logger } from "../../../../../core/"
import vSelect from "vue-select";

import UploadImage from '../../../../../shared/components/admin/upload-image/upload-image.component.vue'

declare const _: any;
declare const $: any;

@Component({
    components: {
        UploadImage,
        vSelect
    }
})
export default class ProductAddPage extends Vue {

    logger: any = new Logger();
    isLoading: boolean = false;

    productService: any = new ProductService();
    product: IProduct = new Product();

    currencies: ICurrency[] = [];
    currencyService: any = new CurrencyService();

    taxes: ITaxe[] = []
    taxeService: any = new TaxeService();

    categories: ICategory[] = [];
    categoryService: any = new CategoryService();

    tags: ITag[] = [];
    tagService: any = new TagService();

    galleries: IPicture[] = [];

    init() {
        this.isLoading = false;
        this.product.picture.url = '';

        this.getCategories();
        this.getTags();
        this.getTaxes();
        this.getCurrencies();
    }

    getCategories() {
        this.categoryService.getCategories().then((response) => {
            this.categories = response.data.categories;
        }).catch((error) => {
            this.logger.error(error);
        });
    }

    getTags() {
        this.tagService.getTags().then((response) => {
            this.tags = response.data.tags;
        }).catch((error) => {
            this.logger.error(error);
        });
    }

    getTaxes() {
        this.taxeService.getTaxes().then((response) => {
            this.taxes = response.data.taxes;
        }).catch((error) => {
            this.logger.error(error);
        });
    }

    getCurrencies() {
        this.currencyService.getCurrencies().then((response) => {
            this.currencies = response.data.currencies;
        }).catch((error) => {
            this.logger.error(error);
        });
    }

    onChangePicture(picture) {
        this.product.picture.name = picture.name;
        this.product.picture.url = picture.url;
        this.product.picture.type = picture.type;
    }

    onSelectedCurrency(currency) {
        this.product.currency = currency;
    }

    onSelectedTaxe(taxe) {
        this.product.taxe = taxe;
    }

    onSelectedTag(tags) {
        this.product.tags = tags;
    }

    onSelectedCategory(categories) {
        this.product.categories = categories;
    }

    onAddGallery(_gallery: any) {
        _gallery.id = new Date().getUTCMilliseconds();
        this.galleries.push(_gallery);
    }

    onChangeGallery(_gallery) {
        let gallery = _.find(this.galleries, (g) => {
            return g.id == _gallery.id
        });
        gallery.name = _gallery.name;
        gallery.url = _gallery.url;
        gallery.type = _gallery.type;
    }

    save(event) {
        event.preventDefault();
        this.isLoading = true;
        if (this.product.picture.url != '') {
            this.product.galleries = this.galleries;
            
            this.product.descriptionLong = $('#description-long').summernote('code');
            this.product.descriptionShort = $('#description-short').summernote('code');
            this.product.additionalInformation = $('#additional-information').summernote('code');

            this.productService.addProduct(this.product).then((resp) => {
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
        } else {
            this.isLoading = false;
            notify.topEnd("warning", "Information", 'Ops!! Please select an image', true, 4000)
        }
    }


    created() {
        this.init();
    }

    mounted() {
        $('.summernote').summernote({
            tabsize: 2,
            height: 120,
        });
    }
};


