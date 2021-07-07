<template>
    <div>
        <breadcrumb-area :title="'checkout'"></breadcrumb-area>

        <div class="checkout_area mb-100">
            <div class="container tw-relative">

                <div v-bind:class="{'hidden' : isLoading}"
                    class="tw-absolute tw-min-h-full tw-top-0 tw-bottom-0 tw-right-0 tw-left-0 tw-bg-white tw-z-10">
                    <loading-component :height="96" :width="96"></loading-component>
                </div>

                <div v-bind:class="{'hidden' : isLoadingPlaceOrder}"
                    class="tw-absolute tw-min-h-full tw-top-0 tw-bottom-0 tw-right-0 tw-left-0 tw-bg-black tw-opacity-25 tw-z-10 tw-flex tw-items-center tw-justify-center">
                    <loading-component :height="96" :width="96"></loading-component>
                </div>

                <div class="flex tw-justify-center tw-items-center" v-if="isLoading && !isCart">
                    <p class="tw-text-center">Votre panier a été vidé</p>
                </div>

                <div class="row justify-content-between" v-if="isCart">
                    <div class="col-12 col-lg-7">
                        <div class="checkout_details_area clearfix">
                            <h5>Billing Details</h5>
                            <form  v-on:submit.prevent="placeOrder($event)" id="place-order">

                                <div class="row">
                                    <div class="col-12">
                                        <div class="d-flex align-items-center">
                                            <!-- Single Checkbox -->
                                            <div class="custom-control custom-checkbox d-flex align-items-center mr-30">
                                                <input type="checkbox" class="custom-control-input" id="customCheck1">
                                                <label class="custom-control-label" for="customCheck1">Ship to a
                                                    different address?</label>
                                            </div>
                                            <!-- Single Checkbox -->
                                            <div class="custom-control custom-checkbox d-flex align-items-center">
                                                <input type="checkbox" class="custom-control-input" id="customCheck2">
                                                <label class="custom-control-label" for="customCheck2">Create an
                                                    account?</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <label for="first_name">First Name *</label>
                                        <input type="text" class="form-control" id="first_name" v-model="user.firstName"
                                            required :readonly='isConnected'>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <label for="last_name">Last Name *</label>
                                        <input type="text" class="form-control" id="last_name" v-model="user.lastName"
                                            required :readonly='isConnected'>
                                    </div>
                                    <div class="col-12 mb-4">
                                        <label for="email_address">Email Address *</label>
                                        <input type="email" class="form-control" id="email_address"      v-model="user.email"
                                            :readonly='isConnected' required>
                                    </div>
                                    <div class="col-12 mb-4">
                                        <label for="phone_number">Phone Number *</label>
                                        <input type="number" class="form-control" id="phone_number" min="0"
                                            v-model="user.phone" :readonly='isConnected' required>
                                    </div>
                                    <!-- <div class="col-12 mb-4">
                                    <label for="company">Company Name</label>
                                    <input type="text" class="form-control" id="company" :value="user">
                                </div> -->
                                    <div class="col-12 mb-4">
                                        <label for="company">Address *</label>
                                        <input type="text" class="form-control" id="address"
                                            v-model="user.addresse.addresse" :readonly='isConnected' required>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <label for="city">Town/City *</label>
                                        <input type="text" class="form-control" id="city" v-model="user.addresse.city"
                                            :readonly='isConnected' required>
                                    </div>
                                    <!-- <div class="col-md-6 mb-4">
                                    <label for="state">State/Province *</label>
                                    <input type="text" class="form-control" id="state" value="">
                                </div> -->
                                    <div class="col-md-6 mb-4">
                                        <label for="country">Country</label>
                                        <v-select :value="country" label="name" id="countries" :options="countries"
                                            @input="onSelectedCountry">
                                        </v-select>
                                    </div>

                                    <div class="col-md-6 mb-4">
                                        <label for="postcode">Postcode/Zip</label>
                                        <input type="text" class="form-control" id="postcode"
                                            v-model="user.addresse.zipcode" :readonly='isConnected' required>
                                    </div>
                                    <div class="col-md-12 mb-4">
                                        <label for="order-notes">Order Notes</label>
                                        <textarea v-model="comment" class="form-control" id="order-notes" cols="30" rows="10"
                                            placeholder="Notes about your order, e.g. special notes for delivery." ></textarea>
                                    </div>

                                </div>
                                <button type="submit" class="hidden" ref="placeOrder" ></button>
                            </form>
                        </div>
                    </div>

                    <div class="col-12 col-lg-4">
                        <div class="checkout-content tw-relative">
                            <div v-bind:class="{'hidden' : isLoadingShipping}"
                                class="tw-absolute tw-min-h-full tw-top-0 tw-bottom-0 tw-right-0 tw-left-0 tw-bg-white tw-z-10">
                                <loading-component :height="96" :width="96"></loading-component>
                            </div>
                            <h5 class="title--">Your Order</h5>
                            <div class="products">
                                <div class="products-data">
                                    <h5>Products:</h5>
                                    <div v-for="(product,index) in products" :key="index"
                                        class="tw-border-t tw-py-1 single-products d-flex justify-content-between align-items-center">
                                        <p>{{product.name}} ( X {{product.quantity}})</p>
                                        <h5>${{ (product.price * product.quantity ) - (product.quantity *
                                            product.specificPrice.reducedPrice ) }}</h5>
                                    </div>
                                </div>
                            </div>
                            <div class="subtotal d-flex justify-content-between align-items-center">
                                <h5>Subtotal</h5>
                                <h5>${{subTotal}}</h5>
                            </div>
                            <div class="shipping d-flex justify-content-between align-items-center">
                                <h5>Shipping</h5>
                                <h5>${{shipping.price}}</h5>
                            </div>
                            <div class="order-total d-flex justify-content-between align-items-center">
                                <h5>Order Total</h5>
                                <h5>${{total}}</h5>
                            </div>
                            <div class="checkout-btn mt-30">
                                <a href="javascript:void(0)" @click="handleSubmitForm($event)" class="btn alazea-btn w-100">Checkout with paypal</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</template>
<script lang="ts" src='./checkout.page.ts'></script>
<style scoped>
    @import "vue-select/dist/vue-select.css";

    .v-select .vs__dropdown-toggle {
        padding: 0.3rem .8rem;
    }
</style>