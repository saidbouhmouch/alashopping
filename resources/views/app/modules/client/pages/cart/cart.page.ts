import { Component, Vue } from 'vue-property-decorator'
import { ProductService } from '../../../../business-logic/services/product.service';
import { CartService } from '../../../../business-logic/services/cart.service'
import { ShippingService } from '../../../../business-logic/services/shipping.service'
import { Logger } from "../../../../core/logger/logger.service"
import { CountryService } from '../../../../business-logic/services/country.service'


import { ICountry } from "../../../../shared/models/country.model";
import { Product, IProduct } from '../../../../shared/models/product.model'
import { Cart, ICart } from '../../../../shared/models/cart.model'
import { CartItem } from '../../../../shared/models/cart-item.model'
import { IShipping, Shipping } from '../../../../shared/models/shipping.model'

import CountDownComponent from '../../../../shared/components/client/countdown/countdown.component.vue'
import breadcrumbArea from '../../../../shared/components/client/breadcrumb-area/breadcrumb-area.component.vue'
import LoadingComponent from '../../../../shared/components/loading/loading.component.vue'
import ShippingModal from './partials/shipping-modal/shipping-modal.component.vue'

declare const preloader: any;
declare const _: any;
declare const $: any;

@Component({
  components: {
    breadcrumbArea,
    CountDownComponent,
    LoadingComponent,
    ShippingModal
  }
})

export default class CartComponent extends Vue {

  isLoading: boolean = false;
  productService: any = new ProductService();
  products: IProduct[] = [];
  countries: ICountry[] = [];

  //localStorageService: any = new LocalStorageService();
  cartService: any = new CartService();
  countryService = new CountryService();
  logger: any = new Logger();
  subTotal: number = 0;
  total: number = 0;


  shippingService: any = new ShippingService();
  shipping: IShipping = new Shipping();

  isShowShoppingModal: boolean = false;


  constructor() {
    super();
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

  deleteProduct(product) {
    this.isLoading = false;
    this.products = _.reject(this.products, (p) => {
      return p.id == product.id;
    });

    const cart: ICart = this.cartService.retrieve();
    cart.cartItems = _.reject(cart.cartItems, (c) => {
      return c.productId == product.id;
    });
    this.cartService.save(cart);
    this.calculeSubTotal();
    setTimeout(() => { this.isLoading = true }, 2000);
  }

  qtyMinus(e, product: IProduct) {
    if (product.quantity && product.quantity > 1) {
      product.quantity--;
      this.updateCart(product);
      this.calculeSubTotal();
    }
  }

  qtyplus(e, product: IProduct) {
    if (product.quantity) {
      product.quantity++;
      this.updateCart(product);
      this.calculeSubTotal();
    }
  }

  updateCart(product) {
    const cart: ICart = this.cartService.retrieve();
    const cartItem = _.find(cart.cartItems, (cartItem: CartItem) => { return cartItem.productId == product.id; })
    if (cartItem) {
      cartItem.quantity = product.quantity
    }
    this.cartService.save(cart);
    this.calculeSubTotal();
  }

  calculeSubTotal() {
    let sum = 0;
    _.forEach(this.products, (product: any) => {
      sum += (product.price * product.quantity) - (product.quantity * product.specificPrice.reducedPrice);
    });

    this.subTotal = sum;
    this.calculeTotal();
  }

  getShipping() {
    this.shippingService.getShippingByZone(this.shipping).then((response) => {
      this.shipping = new Shipping(response.data.shipping);
      this.cartService.setShipping(this.shipping.id);
      this.calculeSubTotal();
    }).catch((error) => {
      this.logger.error(error);
    })
  }

  getShippingById(shippingId) {
    this.shippingService.getShipping(shippingId).then((response) => {
      console.log(response.data.shipping);
      this.shipping = new Shipping(response.data.shipping);
      this.calculeSubTotal();
    }).catch((error) => {
      this.logger.error(error);
    })
  }
  
  calculeTotal() {
    this.total = this.subTotal + this.shipping.price;
  }

  showShippingModal() {
    this.isShowShoppingModal = !this.isShowShoppingModal;
  }

  hiddenShoppingModal() {
    console.log('closeModal');
    this.isShowShoppingModal = !this.isShowShoppingModal;
  }

  getCountries() {
    this.countries = [];
    this.countryService.getCountries().then((response) => {
      this.countries = response.data.countries;
    }).catch((error) => {
      this.logger.error(error);
    })
  }

  shippingSelected(data: any) {
    this.shipping = data;
    this.cartService.setShipping(this.shipping.id);
    this.calculeSubTotal();
  }

  created() {
    this.shipping.from.code = 'MA';
    this.shipping.to.code = 'MA';
    this.getProductsByIds();
    this.getCountries();

    const cart: ICart = this.cartService.retrieve();
    if(cart.shippingId){
      this.getShippingById(cart.shippingId);
    }else{
      this.getShipping();
    }

  }

  mounted() {
    preloader();
  }

  destroyed() {
    document.querySelector(".preloader")?.classList.remove("hidden");
  }

}