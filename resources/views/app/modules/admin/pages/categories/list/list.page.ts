import { Component, Vue  } from 'vue-property-decorator'
import { CategoryService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"

declare const $: any;

@Component
export default class CategoryListPage extends Vue {

     categoryService: any = new CategoryService();
     logger: any = new Logger();
    categories: Array<object> = [];


    constructor() {
        super();
    }

    pullCategories() {
        this.categoryService.getCategories().then((response) => {
            this.categories = response.data.categories;
            setTimeout(function () {
                $("#dataTable").DataTable({
                    responsive: true,
                });
            }, 50);
        }).catch((error) => {
           this.logger.error(error);
        })
    }

    categoryDelete(e, categoryId) {
        e.preventDefault();
        $(e.target).closest("tr").addClass("selected");
        this.categoryService.deleteCategory(categoryId).then((response) => {
            setTimeout(function () {
                $('#dataTable').DataTable().row('.selected').remove().draw();
            }, 50);
        }).catch((error) => {
           this.logger.error(error);
        })
    }

    created() {
        this.pullCategories();
    }

    mounted() {
    }
}
