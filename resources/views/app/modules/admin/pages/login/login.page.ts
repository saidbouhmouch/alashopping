import { Component, Vue } from 'vue-property-decorator'
import { AuthenticationService, Logger, CredentialsService, LocalStorageService } from '../../../../core/'
import { ILoginContext, LoginContext, notify } from '../../../../shared/'
import LoaderComponent from '../../../../shared/components/admin/loader/loader.component.vue'

declare const $: any;

@Component({
    components: {
        LoaderComponent
    }
})
export default class LoginPage extends Vue {

    authService = new AuthenticationService();
    logger: any = new Logger();
    credentialsService = new CredentialsService();
    localStorageService = new LocalStorageService();
    user: ILoginContext = new LoginContext();
    isVisibleLoader: boolean = false;
    isLoading: boolean = false;

    constructor() {
        super();
        this.user.username = "said.dev.info@gmail.com";
        this.user.password = "12345678";
    }

    login(event) {
        event.preventDefault();
        this.isLoading = true;
        this.authService.login(this.user).then((resp: any) => {
            if (resp.data.success) {
                this.authService.setCredentials(resp.data.token);
                this.$router.replace({ name: 'dashboard' });
            } else if (!resp.data.success) {
                notify.topEnd("error", "Error", resp.data.message, true, 5000);
            }
            this.isLoading = false;

        }).catch((error) => {
            this.isLoading = false;
            notify.topEnd("error", "Error", "'Ops!! server connection error. Try Again'", true, 5000);
        });

    }


    beforeCreate() {
        this.isVisibleLoader = true;
    }

    created() {
        this.localStorageService.clear();
    }

    mounted() {
        this.isVisibleLoader = false;
    }

}

