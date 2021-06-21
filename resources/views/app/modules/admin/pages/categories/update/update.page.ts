import { Component, Vue  } from 'vue-property-decorator'
import { CategoryService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"
import { Category, ICategory, notify } from "../../../../../shared/"

declare const $: any;

@Component
export default class CategoryUpdatePage extends Vue {
    isLoading: boolean = false;
    category: ICategory = new Category();
     categoryService: any = new CategoryService();
     logger: any = new Logger();


    init() {
        this.isLoading = false;
        this.getCategory(this.$route.params.id);
    }

    getCategory(id) {
        this.categoryService.getCategory(id).then((response) => {
            this.category.id = response.data.category.id,
                this.category.name = response.data.category.name;
            this.category.description = response.data.category.description
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    update(event) {
        event.preventDefault();
        this.isLoading = true;
        this.categoryService.updateCategory(this.category, this.category.id).then((resp) => {
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
    }

    created() {
        this.init();
    }

    mounted() { }
};


