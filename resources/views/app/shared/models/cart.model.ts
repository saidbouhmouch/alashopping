
import { CartItem } from './cart-item.model'
/**
 *   Cart model
 */
export interface ICart {
    cartItems:  CartItem[];
    user?:object;
    shippingId?: number;
};

export class Cart {
    cartItems:  CartItem[];
    user?:object;
    shippingId?: number;

    constructor();
    constructor(cart: ICart);
    constructor(cart?: any) {
        this.cartItems = cart && cart.cartItem || [];
        this.user =  cart && cart.user || null;
        this.shippingId = cart && cart.shippingId || 0;
    }
 
    update(cart:ICart){
        this.cartItems = cart.cartItems;
        this.user = cart.user;
        this.shippingId = cart.shippingId || 0 ;
    }
}
