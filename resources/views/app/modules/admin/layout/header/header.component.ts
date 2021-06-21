import { Component, Vue } from 'vue-property-decorator'
import { UserService } from "../../../../business-logic"
import { AuthenticationService, StateService } from "../../../../core"
import { IUser, User, notify } from "../../../../shared"

@Component
export default class HeaderComponent extends Vue {

    user: IUser = new User();
    UserService: any = new UserService();
    authService: any = new AuthenticationService();
    breadcrumbUrl: any[] = [];

    constructor() {
        super();
    }

    getUser() {
        const _user = this.UserService.getUser();
        if (_user) {
            this.user.email = _user.email
            this.user.firstName = _user.firstName
            this.user.lastName = _user.lastName
            this.user.picture.url = _user.image
        }
    }

    logOut(e) {
        e.preventDefault();
        this.authService.logout().then(() => {
            this.authService.destroyToken();
            this.$router.replace({ name: 'login' })
        }).catch(() => {
            notify.topEnd("error", "Error", "Error, please try again another time", true, 4000);
        });
    }


    beforeCreate() { }

    created() {
        this.getUser();
        StateService.$on('breadcrumbUrl', (data) => {
            this.breadcrumbUrl = data;
        });
    }

    beforeDestroy() { }

    mounted() { }

}