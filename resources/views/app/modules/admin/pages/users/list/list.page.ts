import { Component, Vue  } from 'vue-property-decorator'
import { UserService } from '../../../../../business-logic/'
import { Logger } from '../../../../../core/'
import LoaderComponent from '../../../../../shared/components/admin/loader/loader.component.vue'

declare const $: any;

@Component({
    components: {
        LoaderComponent
    }
})
export default class UserListPage extends Vue {
     userService = new UserService();
     logger: any = new Logger();

    users: Array<object> = [];
    isVisibleLoader : boolean = true;
    
    constructor() {
        super();
    }

    pullUsers() {
        this.userService.getUsers().then((response : any) => {
            this.users = response.data.users;
            setTimeout(function () {
                $("#dataTable").DataTable({
                    responsive: true,
                });
            }, 50);
            this.isVisibleLoader = false;
        }).catch((error) => {
            this.logger.error(error);
            this.isVisibleLoader = false;
        })
    }

    userDelete(e, userId) {
        e.preventDefault();
        $(e.target).closest("tr").addClass("selected");
        this.userService.deleteUser(userId).then((response) => {
            setTimeout(function () {
                $('#dataTable').DataTable().row('.selected').remove().draw();
            }, 50);
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    beforeCreate() {
        this.isVisibleLoader = true;
    }

    created() {
        this.pullUsers();
    }

    mounted() { }

}

