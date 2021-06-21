import { Component, Vue } from 'vue-property-decorator'
import { StateService } from "../../../../core"

@Component
export default class DashboardPage extends Vue {

    constructor() {
        super();
    }

    beforeCreate() { }

    created() {
        StateService.$emit('breadcrumbUrl', {
            title: "Dashboard", routes: [
                { name: 'dashboard'}
            ]
        });
    }

    beforeDestroy() {
    }

    mounted() { }


}