import { Component, Vue } from 'vue-property-decorator'
import { TagService } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"
import { Tag, ITag, notify } from "../../../../../shared/"

declare const $: any;

@Component
export default class TagUpdatePage extends Vue {

    isLoading: boolean = false;
    tag: ITag = new Tag();
     tagService: any = new TagService();
     logger: any = new Logger();

    constructor() {
        super();
    }
    init() {
        this.isLoading = false;
        this.getTag(this.$route.params.id);
    }

    getTag(id) {
        this.tagService.getTag(id).then((response) => {
            this.tag.id = response.data.tag.id,
                this.tag.name = response.data.tag.name;
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    update(event) {
        event.preventDefault();
        this.isLoading = true;
        this.tagService.updateTag(this.tag, this.tag.id).then((resp) => {
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


