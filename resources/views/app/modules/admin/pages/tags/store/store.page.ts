import { Component, Vue } from 'vue-property-decorator'
import { TagService } from "../../../../../business-logic/"
import { Logger  } from "../../../../../core/"
import { Tag, ITag, notify } from "../../../../../shared/"

declare const $: any;

@Component
export default class TagAddPage extends Vue {


     tagService: any = new TagService();
     logger: any = new Logger();
    isLoading: boolean = false;
    tag: ITag = new Tag();
    

    constructor() {
        super();
    }

    init() {
        this.isLoading = false;
    }

    save(event) {
        event.preventDefault();
        this.isLoading = true;
        this.tagService.addTag(this.tag).then((resp) => {
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
}


