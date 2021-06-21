import { Component, Vue  } from 'vue-property-decorator'
import { TaxeService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"
import { ITaxe, Taxe, notify } from "../../../../../shared/"

@Component
export default class TaxeAddPage extends Vue {

     taxeService: any = new TaxeService();
     logger: any = new Logger();
    taxe: ITaxe = new Taxe();
    isLoading: boolean = false;

    init() {
        this.isLoading = false;
    }

    save(event) {
        event.preventDefault();
        this.isLoading = true;
        this.taxeService.addTaxe(this.taxe).then((resp) => {
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


