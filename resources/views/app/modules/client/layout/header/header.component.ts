import { Component, Vue } from 'vue-property-decorator'
import { StateService } from '../../../../core/state/state.service';
import { CartService } from '../../../../business-logic/services/cart.service'
import { Cart , ICart } from '../../../../shared/models/cart.model'

declare const _ : any;
@Component
export default class HeaderComponent extends Vue {

    cartService: any = new CartService();
    quantity : number = 0;
    constructor() {
        super();
    }

    created() {
        StateService.$on('cart', () => {
            this.getCart();
        });
    }

    getCart(){
        const cart : ICart = this.cartService.retrieve();
        this.quantity = _.sumBy(cart.cartItems, 'quantity');
    }

    mounted() {
        this.getCart();
     }

    destroyed() { }
}
