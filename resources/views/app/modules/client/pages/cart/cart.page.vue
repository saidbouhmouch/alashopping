<template>
    <div>
        <breadcrumb-area :title="'CART'"></breadcrumb-area>

        <div class="cart-area section-padding-0-100 clearfix tw-relative" :class="{'tw-z-10':isShowShoppingModal}">
            <div v-bind:class="{'hidden' : isLoading}"
                class="tw-absolute tw-min-h-full tw-top-0 tw-bottom-0 tw-right-0 tw-left-0">
                <loading-component :height="96" :width="96"></loading-component>
            </div>
            <div class="flex tw-justify-center tw-items-center" v-if="isLoading && products.length == 0">
                <p class="tw-text-center">Votre panier a été vidé</p>
            </div>
            <div class="container" v-if="isLoading && products.length > 0">
                <div class="row">
                    <div class="col-12">
                        <div class="cart-table clearfix">
                            <table class="table table-responsive">
                                <thead>
                                    <tr>
                                        <th>Products</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                        <th>TOTAL</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="(product,index) in products" :key="index">
                                        <td class="cart_product_img">
                                            <a href="javascript:void(0)">
                                                <img :src="product.picture.url" alt="Product" /></a>
                                            <h5 class="tw-flex tw-flex-col">
                                                <div class="flex"
                                                    v-if="product && product.specificPrice && product.specificPrice.expirationDate">
                                                    <count-down-component
                                                        :expirationDate="product.specificPrice.expirationDate">
                                                    </count-down-component>
                                                </div>
                                                <span> {{product.name}} </span>
                                            </h5>
                                        </td>
                                        <td class="qty">
                                            <div class="quantity">
                                                <span class="qty-minus" @click="qtyMinus($event,product)">
                                                    <i class="fa fa-minus" aria-hidden="true"></i>
                                                </span>
                                                <input type="number" class="qty-text" id="qty" step="1" min="1"
                                                    name="quantity" v-model="product.quantity">
                                                <span class="qty-plus" @click="qtyplus($event,product)">
                                                    <i class="fa fa-plus" aria-hidden="true"></i></span>
                                            </div>
                                        </td>
                                        <td class="price">
                                            <p class="tw-flex tw-w-full tw-items-center">
                                                <span
                                                    v-bind:class="{'text-barre' : product.specificPrice && product.specificPrice.reduction > 0}">${{
                                                    product.price }}</span>
                                                <span
                                                    v-if="product.specificPrice && product.specificPrice.reduction > 0 "
                                                    class="ml-2 tw-bg-red-1000 tw-px-1 tw-py-1 tw-rounded-md tw-text-white">
                                                    -{{ product.specificPrice.percentReduction }}% </span>

                                            </p>
                                        </td>
                                        <td class="total_price">
                                            <span>$ {{ (product.price * product.quantity ) - (product.quantity *
                                                product.specificPrice.reducedPrice ) }} </span>
                                        </td>
                                        <td class="action">
                                            <a href="javascript:void(0)" @click="deleteProduct(product)"><i
                                                    class="icon_close"></i></a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Coupon Discount -->
                    <div class="col-12 col-lg-6">
                        <!-- <div class="coupon-discount mt-70">
                            <h5>COUPON DISCOUNT</h5>
                            <p>
                                Coupons can be applied in the cart prior to checkout. Add an
                                eligible item from the booth of the seller that created the
                                coupon code to your cart. Click the green "Apply code" button to
                                add the coupon to your order. The order total will update to
                                indicate the savings specific to the coupon code entered.
                            </p>
                            <form action="#" method="post">
                                <input type="text" name="coupon-code" placeholder="Enter your coupon code" />
                                <button type="submit">APPLY COUPON</button>
                            </form>
                        </div> -->
                    </div>

                    <!-- Cart Totals -->
                    <div class="col-12 col-lg-6">
                        <div class="cart-totals-area mt-70">
                            <h5 class="title--">Cart Total</h5>
                            <div class="subtotal d-flex justify-content-between">
                                <h5>Subtotal</h5>
                                <h5>${{subTotal}}</h5>
                            </div>
                            <div class="shipping d-flex tw-flex-col">
                                <h5>Shipping : ${{shipping.price}} </h5>
                                <a class="tw-flex tw-items-center" href="javascript:void(0)" @click='showShippingModal'>
                                    to {{shipping.from.name}} via <img
                                        :src="(shipping.carrier)?(shipping.carrier.picture.url):''"
                                        class="tw-w-8 tw-mx-1"> {{shipping.carrier.name}}
                                    <i class=" tw-ml-1 fa fa-angle-down"></i>
                                </a>
                                <h6>Estimated Delivery:
                                    {{shipping.estimatedDeliveryMin}}-{{shipping.estimatedDeliveryMax}} days <i
                                        class="fa fa-question-circle-o"></i> </h6>

                                <shipping-modal v-if="isShowShoppingModal" :shipping='shipping' :countries='countries'
                                    v-on:shippingSelected='shippingSelected' v-on:closeModal="hiddenShoppingModal">
                                </shipping-modal>

                            </div>
                            <div class="total d-flex justify-content-between">
                                <h5>Total</h5>
                                <h5>${{total}}</h5>
                            </div>
                            <div class="checkout-btn">
                                <router-link  :to="{ path: '/checkout'}"
                                    class="btn alazea-btn w-100">
                                    PROCEED TO CHECKOUT
                                </router-link>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</template>
<script lang="ts" src='./cart.page.ts'></script>