
import { CartItem } from './cart-item.model'
/**
 *   Cart model
 */
export interface ICart {
    cartItems:  CartItem[];
    user?:object;
};

export class Cart {
    cartItems:  CartItem[];
    user?:object;

    constructor();
    constructor(cart: ICart);
    constructor(cart?: any) {
        this.cartItems = cart && cart.cartItem || [];
        this.user =  cart && cart.user || null;
    }
 
    update(cart:ICart){
        this.cartItems = cart.cartItems;
        this.user = cart.user;
    }
}
