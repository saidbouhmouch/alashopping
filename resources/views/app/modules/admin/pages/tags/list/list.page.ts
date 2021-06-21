import { Component, Vue } from 'vue-property-decorator'
import { TagService  } from "../../../../../business-logic/"
import { Logger } from "../../../../../core/"

declare const $: any;

@Component
export default class TagListPage extends Vue {

     tagService: any = new TagService();
     logger: any = new Logger();
    tags: Array<object> = [];

    constructor() {
        super();
    }


    pullTags() {
        this.tagService.getTags().then((response) => {
            this.tags = response.data.tags;
            setTimeout(function () {
                $("#dataTable").DataTable({
                    responsive: true,
                });
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    tagDelete(e, tagId) {
        e.preventDefault();
        $(e.target).closest("tr").addClass("selected");
        this.tagService.deleteTag(tagId).then((response) => {
            setTimeout(function () {
                $('#dataTable').DataTable().row('.selected').remove().draw();
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    created() {
        this.pullTags();
    }

    mounted() {
    }
}
