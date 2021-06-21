import { Component, Vue  } from 'vue-property-decorator'
import vSelect from "vue-select";
import uploadImage from '@shared/components/admin/upload-image/upload-image.component.vue'
import { UserService, RoleService, CountryService } from "../../../../../business-logic/";
import { Logger } from "../../../../../core/";
import { User, IUser, IRole,ICountry, notify } from "../../../../../shared/";

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
        this.pullRoles();
        this.pullCountries();

    }

    getUser(id) {

        this.userService.getUser(id).then((response) => {

            this.user.id = response.data.user.id,
                this.user.firstName = response.data.user.first_name;
            this.user.lastName = response.data.user.last_name
            this.user.email = response.data.user.email
            this.user.gender = (response.data.user.gender == 'homme') ? 'MAN' : 'MALE';
            this.user.phone = response.data.user.phone;

            this.user.picture.id = response.data.picture.id;
            this.user.picture.name = response.data.picture.name;
            this.user.picture.url = response.data.picture.url;
            this.user.picture.type = response.data.picture.type;
            this.user.picture.update = false;

            this.user.addresse.id = response.data.addresse.id;
            this.user.addresse.addresse = response.data.addresse.addresse;
            this.user.addresse.city = response.data.addresse.city;
            this.user.addresse.zipcode = response.data.addresse.zipcode;
            this.user.addresse.type = response.data.addresse.type;

            this.user.addresse.country.id = response.data.addresse.country.id;
            this.user.addresse.country.name = response.data.addresse.country.name;
            this.user.addresse.country.code = response.data.addresse.country.code;
            this.user.addresse.userId = response.data.user.id;

            this.user.role.id = response.data.roles[0].id;
            this.user.role.name = response.data.roles[0].name;
            this.user.role.guardName = response.data.roles[0].guard_name;

        }).catch((error) => {
            this.logger.error(error);
        })
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

    onSelectedRole(role: any) {
        this.user.role = role;
    }

    onSelectedCountry(country: any) {
        this.user.addresse.country = country;
    }

    onChangePicture(picture: any) {
        this.user.picture.name = picture.name;
        this.user.picture.url = picture.url;
        this.user.picture.type = picture.type;
        this.user.picture.update = true;
    }

    update(event) {
        event.preventDefault();
        this.isLoading = true;
        this.userService.updateUser(this.user, this.user.id).then((resp) => {
            if (resp.data.success) {
                notify.topEnd("success", "Information", resp.data.message, true, 4000)
            } else if (!resp.data.success) {
                notify.topEnd("error", "Error", resp.data.message, true, 4000)
            }
            setTimeout(() => { this.isLoading = false; }, 1000);
            this.user.picture.update = false;
        }).catch((error) => {
            this.logger.error(error);
            this.isLoading = false;
        });
    }

    created() {
        this.init();
        this.getUser(this.$route.params.id);
    }

    mounted() { }
};


