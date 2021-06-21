import { Component, Vue } from 'vue-property-decorator'
import vSelect from "vue-select";
import uploadImage from '../../../../../shared/components/admin/upload-image/upload-image.component.vue'
import { UserService, RoleService, CountryService } from "../../../../../business-logic/";
import { Logger } from "../../../../../core/";
import { User, IUser, IRole, ICountry, notify } from "../../../../../shared/";


@Component({
    components: {
        vSelect,
        "upload-image": uploadImage
    }
})
export default class UserAddPage extends Vue {
     roleService = new RoleService();
     userService = new UserService();
     countryService = new CountryService();
     logger = new Logger();

    isLoading: boolean = false;
    user: IUser = new User();
    roles: IRole[] = [];
    countries: ICountry[] = [];

    constructor() {
        super();
    }

    init() {
        this.isLoading = false;
        this.user.id = 1;
        this.pullRoles();
        this.pullCountries();
    }

    pullRoles() {
        this.roleService.getRoles().then((response) => {
            this.roles = response.data.roles;
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    pullCountries() {
        this.countryService.getCountries().then((response) => {
            this.countries = response.data.countries;
        }).catch((error) => {
            this.logger.error(error);
        })
    }

    onSelectedRole(role) {
        this.user.role = role;
    }

    onSelectedCountry(country) {
        this.user.addresse.country = country;
    }

    onChangePicture(picture) {
        this.user.picture.name = picture.name;
        this.user.picture.url = picture.url;
        this.user.picture.type = picture.type;
    }

    save(event) {
        event.preventDefault();
        this.isLoading = true;
        this.user.addresse.type = 'shipping';

        this.userService.addUser(this.user).then((resp) => {
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


