import { Component, Vue  } from 'vue-property-decorator'
import { CategoryService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"
import { Category, ICategory, notify } from "../../../../../shared/"

declare const $: any;

@Component
export default class CategoryAddPage extends Vue {

     categoryService: any = new CategoryService();
     logger: any = new Logger();

    isLoading: boolean = false;
    category: ICategory = new Category();

    constructor() {
        super();
    }

    init() {
        this.isLoading = false;
    }

    save(event) {
        event.preventDefault();
        this.isLoading = true;
        this.categoryService.addCategory()(this.category).then((resp) => {
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


