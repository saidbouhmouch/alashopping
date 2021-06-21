import { Component, Vue } from 'vue-property-decorator'
import { TaxeService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"
import { ITaxe, Taxe, notify } from "../../../../../shared/"

@Component
export default class TaxeUpdatePage extends Vue {

     taxeService: any = new TaxeService();
     logger: any = new Logger();
    isLoading: boolean = false;
    taxe: ITaxe = new Taxe();


    init() {
        this.isLoading = false;
        this.getTaxe(this.$route.params.id);
    }

    getTaxe(id) {
        this.taxeService.getTaxe(id).then((response) => {
            this.taxe.id = response.data.taxe.id,
                this.taxe.name = response.data.taxe.name;
            this.taxe.value = response.data.taxe.value;
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    update(event) {
        event.preventDefault();
        this.isLoading = true;
        this.taxeService.updateTaxe(this.taxe, this.taxe.id).then((resp) => {
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


