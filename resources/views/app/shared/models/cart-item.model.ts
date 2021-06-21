/**
 *   CartItem model
 */
export interface ICartItem {
    productId: number;
    quantity: number;
};

export class CartItem {
    productId: number;
    quantity: number;

    constructor();
    constructor(cartItem: ICartItem);
    constructor(cartItem?: any) {
        this.productId = cartItem && cartItem.productId || null;
        this.quantity = cartItem && cartItem.quantity || 0;
    }
}
