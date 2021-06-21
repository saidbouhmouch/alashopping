import { Component, Vue } from 'vue-property-decorator'
import { ProductService } from '../../../../business-logic/services/product.service';
import { LocalStorageService } from '../../../../core/storage/localstorage.service';
import { Logger } from "../../../../core/logger/logger.service"
import { Product, IProduct } from '../../../../shared/models/product.model'
// import LoadingComponent from '../../../../shared/components/loading/loading.component.vue'
// import VueAdsPagination, { VueAdsPageButton } from 'vue-ads-pagination';
import { CartService } from '../../../../business-logic/services/cart.service'
import { Cart, ICart } from '../../../../shared/models/cart.model'
import { CartItem } from '../../../../shared/models/cart-item.model'

import CountDownComponent from '../../../../shared/components/client/countdown/countdown.component.vue'
import breadcrumbArea from '../../../../shared/components/client/breadcrumb-area/breadcrumb-area.component.vue'
import LoadingComponent from '../../../../shared/components/loading/loading.component.vue'


declare const preloader: any;
declare const _: any;
declare const $: any;

@Component({
  components: {
    breadcrumbArea,
    CountDownComponent,
    LoadingComponent
  }
})

export default class CartComponent extends Vue {

  isLoading: boolean = false;
  productService: any = new ProductService();
  //localStorageService: any = new LocalStorageService();
  cartService: any = new CartService();
  logger: any = new Logger();
  subTotal: number = 0;
  total: number = 0;
  products: IProduct[] = [];

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
    }
  }

  deleteProduct(product) {
    this.isLoading = false;
    this.products = _.reject(this.products, (p) => {
      return p.id == product.id;
    });

    const cart: ICart = this.cartService.retrieve();
    cart.cartItems =_.reject(cart.cartItems, (c) => {
      return c.productId == product.id;
    });
    this.cartService.save(cart);
    setTimeout(() => { this.isLoading = true}, 2000);
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
    this.total = this.subTotal;
  }

  created() {
    this.getProductsByIds();
  }

  mounted() {
    preloader();
  }

  destroyed() {
    document.querySelector(".preloader")?.classList.remove("hidden");
  }

}







