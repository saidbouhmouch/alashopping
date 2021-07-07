import { Component, Vue } from 'vue-property-decorator'
import breadcrumbArea from '../../../../shared/components/client/breadcrumb-area/breadcrumb-area.component.vue'
import { UserService } from '../../../../business-logic/services/user.service'
import { IUser, User } from '../../../../shared/models/user.model'
import { ProductService } from '../../../../business-logic/services/product.service';
import { CartService } from '../../../../business-logic/services/cart.service'
import { CheckoutService } from '../../../../business-logic/services/checkout.service'
import { ShippingService } from '../../../../business-logic/services/shipping.service'
import { CountryService } from '../../../../business-logic/services/country.service'
import { Logger } from "../../../../core/logger/logger.service"
import { ICountry, Country } from "../../../../shared/models/country.model";
import { Product, IProduct } from '../../../../shared/models/product.model'
import { Cart, ICart } from '../../../../shared/models/cart.model'
import { CartItem } from '../../../../shared/models/cart-item.model'
import { IShipping, Shipping } from '../../../../shared/models/shipping.model'
import { NotifyEnum} from '../../../../core/enum/notify.enum'; 
import { StateService } from '../../../../core/state/state.service';
import vSelect from "vue-select";
import LoadingComponent from '../../../../shared/components/loading/loading.component.vue'

declare const preloader: any;
declare const _: any;

@Component({
  components: {
    breadcrumbArea,
    LoadingComponent,
    vSelect
  }
})

export default class CheckoutComponent extends Vue {

  checkoutService: any = new CheckoutService();
  cartService: any = new CartService();
  logger: any = new Logger();

  userService: any = new UserService();
  user: IUser = new User();

  shippingService: any = new ShippingService();
  shipping: IShipping = new Shipping();

  countryService = new CountryService();
  countries: ICountry[] = [];
  country: ICountry = new Country();

  productService: any = new ProductService();
  products: IProduct[] = [];

  isConnected: boolean = false;
  isLoading: boolean = false;
  isLoadingShipping: boolean = false;
  isCart: boolean = false;
  subTotal: number = 0;
  total: number = 0;
  comment: string = '';
  isLoadingPlaceOrder: boolean = true;

  constructor() {
    super();
  }

  getcurrentUser() {
    this.isConnected = false;
    this.user = new User();
    this.userService.getCurrentUser().then((resp: any) => {
      if (resp.data.isConnected) {
        this.user = new User(resp.data.user);
      }
      this.isConnected = true;
      this.isLoading = true;
    }).catch(error => {
      this.isConnected = true;
      this.isLoading = true;
      this.logger.error(error);
    });
  }

  getCountries() {
    this.countries = [];
    this.countryService.getCountries().then((response) => {
      this.countries = response.data.countries;
      setTimeout(() => {
        this.country = _.find(this.countries, (c: ICountry) => { return c.code == this.user.addresse.country.code });
      }, 1000);
    }).catch((error) => {
      this.logger.error(error);
    })
  }

  onSelectedCountry(country) {
    this.country = _.find(this.countries, (c: ICountry) => { return c.code == country.code });
    this.user.addresse.country = country;
  }

  getProductsByIds() {
    this.isLoading = false;
    const cart: ICart = this.cartService.retrieve();
    const productsIds: number[] = _.map(cart.cartItems, (cartItem: CartItem) => {
      return cartItem.productId;
    });
    this.products = [];
    this.calculeSubTotal();
    if (productsIds.length > 0) {
      this.productService.getProductsByIds(productsIds).then((response) => {

        _.forEach(response.data.products, (product: IProduct) => {
          if (product.specificPrice) {
            product.specificPrice = { ...product.specificPrice, price: product.price };
          }
          const cartItem = _.find(cart.cartItems, (cartItem: CartItem) => { return cartItem.productId == product.id; })
          product.quantity = (cartItem) ? cartItem.quantity : 0;
          this.products.push(new Product(product));
        });

        setTimeout(() => { this.isLoading = true; preloader(); }, 2000);
        this.calculeSubTotal();
      }).catch((error) => {
        this.logger.error(error);
        setTimeout(() => { this.isLoading = true; preloader(); }, 2000);
      })
    } else {
      setTimeout(() => { this.isLoading = true; preloader(); }, 2000);
    }
  }

  calculeSubTotal() {
    let sum = 0;
    _.forEach(this.products, (product: any) => {
      sum += (product.price * product.quantity) - (product.quantity * product.specificPrice.reducedPrice);
    });

    this.subTotal = sum;
    this.calculeTotal();
  }

  calculeTotal() {
    this.total = this.subTotal + this.shipping.price;
  }

  getShippingById(shippingId) {
    this.isLoadingShipping = false;
    this.shippingService.getShipping(shippingId).then((response) => {
      this.isLoadingShipping = true;
      this.shipping = new Shipping(response.data.shipping);
      this.calculeSubTotal();
    }).catch((error) => {
      this.isLoadingShipping = true;
      this.logger.error(error);
    })
  }

  created() {
    this.isLoading = false;
    const cart: ICart = this.cartService.retrieve();
    if (cart && cart.shippingId) {
      this.isCart = true;
      this.country = _.find(this.countries, (c: ICountry) => { return c.code == 'MA' });
      this.getcurrentUser();
      this.getCountries();
      this.getProductsByIds();
      this.getShippingById(cart.shippingId);
    } else {
      this.isLoading = true;
      this.isCart = false;
    }
  }

  handleSubmitForm(event) {
    event.preventDefault();
    const element: any = this.$refs.placeOrder;
    element.click();
  }

  placeOrder(event) {

    event.stopPropagation();
    this.isLoadingPlaceOrder = false;
    const cart: ICart = this.cartService.retrieve();
    const order: any = {
      products: cart.cartItems,
      shippingId: cart.shippingId,
      user: this.user,
      typePayment: 'paypal',
      comment : this.comment
    };

    this.checkoutService.placeOrder(order).then((resp) => {
      console.log(resp.data);
      setTimeout(()=>{this.isLoadingPlaceOrder = true;},3000);
    }).catch((error) => {
      this.isLoadingPlaceOrder = true;
      this.logger.error(error);
    })

    
  }

  mounted() {
    preloader();
  }

  destroyed() {
    document.querySelector(".preloader")?.classList.remove("hidden");
  }

}
