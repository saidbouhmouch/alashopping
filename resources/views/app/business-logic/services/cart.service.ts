import { HttpService } from '../../core'
import { CredentialsService, JwtService } from '../../core';
import {LocalStorageService } from '../../core/storage/localstorage.service';
import { StateService } from '../../core/state/state.service';
import { Cart , ICart } from '../../shared/models/cart.model'
import { ICartItem , CartItem } from '../../shared/models/cart-item.model'

declare const _ : any ;

export class CartService {

   private httpService: any = new HttpService();
   private storage: any = new LocalStorageService();


   constructor() {
      this.httpService.resourceName = 'cart';
   }

   public addItem(product: any, quantity: number): void {
      const cart = this.retrieve();
      let item = _.find(cart.cartItems,(cartItem)=>{return cartItem.productId === product.id });
      if (item === undefined) {
         item = new CartItem();
         item.productId = product.id;
         item.quantity = quantity;
         cart.cartItems.push(item);
      }else{
         item.quantity += quantity;
      }
     
      //this.calculateCart(cart);
      this.save(cart);
      this.dispatch(cart);
   }

   public empty(): void {
      const newCart = new Cart();
      this.save(newCart);
      this.dispatch(newCart);
   }

   // public setDeliveryOption(deliveryOption: DeliveryOption): void {
   //    const cart = this.retrieve();
   //    cart.deliveryOptionId = deliveryOption.id;
   //    this.calculateCart(cart);
   //    this.save(cart);
   //    this.dispatch(cart);
   // }

   // private calculateCart(cart: ShoppingCart): void {
   //    cart.itemsTotal = cart.items
   //       .map((item) => item.quantity * this.products.find((p) => p.id === item.productId).price)
   //       .reduce((previous, current) => previous + current, 0);
   //    cart.deliveryTotal = cart.deliveryOptionId ?
   //       this.deliveryOptions.find((x) => x.id === cart.deliveryOptionId).price :
   //       0;
   //    cart.grossTotal = cart.itemsTotal + cart.deliveryTotal;
   // }

   private retrieve(){
      const cart = new Cart();
      const storedCart = this.storage.getItem('cart');
      if (storedCart) {
         cart.update(JSON.parse(storedCart));
      }
      return cart;
   }

   private save(cart): void {
      this.storage.setItem('cart',cart);
   }

   private dispatch(cart): void {
      StateService.$emit('cart', cart);
      StateService.$emit('notify', {
         title : 'The product is added to your cart',
         text : '',
         type:"success"
      });
   }

}