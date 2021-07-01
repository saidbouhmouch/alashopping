import { Component, Vue } from 'vue-property-decorator'
import breadcrumbArea from '../../../../shared/components/client/breadcrumb-area/breadcrumb-area.component.vue'
import { UserService } from '../../../../business-logic/services/user.service'
import { IUser, User } from '../../../../shared/models/user.model'
import { ProductService } from '../../../../business-logic/services/product.service';
import { CartService } from '../../../../business-logic/services/cart.service'
import { ShippingService } from '../../../../business-logic/services/shipping.service'
import { CountryService } from '../../../../business-logic/services/country.service'
import { Logger } from "../../../../core/logger/logger.service"
import { ICountry } from "../../../../shared/models/country.model";
import { Product, IProduct } from '../../../../shared/models/product.model'
import { Cart, ICart } from '../../../../shared/models/cart.model'
import { CartItem } from '../../../../shared/models/cart-item.model'
import { IShipping, Shipping } from '../../../../shared/models/shipping.model'

declare const preloader: any;

@Component({
  components: {
    breadcrumbArea
  }
})

export default class CheckoutComponent extends Vue {

  cartService: any = new CartService();
  logger: any = new Logger();

  userService: any = new UserService();
  user: IUser = new User();

  shippingService: any = new ShippingService();
  shipping: IShipping = new Shipping();

  countryService = new CountryService();
  countries: ICountry[] = [];

  productService: any = new ProductService();
  products: IProduct[] = [];

  isloadingCurrentUser: boolean = false;

  constructor() {
    super();
  }

  getcurrentUser() {
    this.isloadingCurrentUser = false;
    this.user = new User();
    this.userService.getCurrentUser().then((resp: any) => {
      this.isloadingCurrentUser = true;
      if (resp.data.isConnected) {
        this.user = new User(resp.data.user);
      }
    }).catch(error=>{
      this.isloadingCurrentUser = true;
      this.logger.error(error);
    });
  }

  created() {
  }

  mounted() {
    preloader();
  }

  destroyed() {
    document.querySelector(".preloader")?.classList.remove("hidden");
  }

}
