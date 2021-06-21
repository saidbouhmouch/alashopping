<template>
    <div>
        <breadcrumb-area :title="'SHOP DETAILS'"></breadcrumb-area>

        <section class="single_product_details_area mb-50">
            <div class="produts-details--content mb-50">
                <div class="container">
                    <div class="row justify-content-between">

                        <div class="col-12 col-md-6 col-lg-5">
                            <div class="single_product_thumb">
                                <div id="product_details_slider" class="carousel slide" data-ride="carousel">
                                    <div class="carousel-inner">

                                        <div class="carousel-item" v-for="(gallery,index) in product.galleries" :key="index"
                                            :class="{active : index ==0 }">
                                            <!-- <a class="product-img" href="/img/bg-img/49.jpg" title="Product Image"> -->
                                            <img class="lazy d-block w-100" :src="gallery.url" :alt="index">
                                            <!-- </a> -->
                                        </div>
                                    </div>
                                    <ol class="carousel-indicators">
                                        <li class="" v-for="(gallery,index) in product.galleries" :key="index"
                                            :class="{'active': index == 0}" data-target="#product_details_slider"
                                            v-bind:data-slide-to="index"
                                            :style="'background-image: url('+gallery.url+');'">
                                        </li>
                                    </ol>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-md-6">
                            <div class="single_product_desc">
                                <h4 class="title">{{ product.name }}</h4>
                                 <h4 class="tw-flex tw-items-center">
                                    <span class="ml-2" v-bind:class="{'text-barre' : product.specificPrice && product.specificPrice.reduction > 0}"> ${{ product.price}} </span>
                                     <span v-if="product.specificPrice && product.specificPrice.reduction > 0 " class="ml-2 tw-bg-red-1000 tw-px-1 tw-py-1 tw-rounded-md tw-text-white" > -{{ product.specificPrice.percentReduction }}% </span>
                                 </h4>
                                <div class="short_overview" v-html="product.descriptionShort">
                                </div>
                                <div class="tw-inline-flex tw-h-12 tw-relative tw-min-w-40 tw-pb-2  tw-rounded-md" v-if="product && product.specificPrice && product.specificPrice.expirationDate" >
                                     <count-down-component 
                                        :expirationDate="product.specificPrice.expirationDate">
                                    </count-down-component>
                                </div>

                                <div class="cart--area d-flex flex-wrap align-items-center">
                                    <!-- Add to Cart Form -->
                                    <form class="cart clearfix d-flex align-items-center" method="post">
                                        <div class="quantity">
                                            <span class="qty-minus" @click="qtyMinus">
                                                <i class="fa fa-minus" aria-hidden="true"></i>
                                            </span>
                                            <input type="number" class="qty-text" id="qty" step="1" min="1"
                                                name="quantity" v-model="quantity">
                                            <span class="qty-plus" @click="qtyplus">
                                                <i class="fa fa-plus" aria-hidden="true"></i></span>
                                        </div>
                                        <button type="button" 
                                                name="addtocart" 
                                                :disabled="isAddProduct"
                                                @click="addProductToCart()"
                                                :class="{'clicked' : isAddProduct}"
                                                class="btn alazea-btn ml-15 cart-button tw-overflow-hidden
                                                    ">
                                                <span class="add-to-car">Add to cart</span> 
                                                <!-- <span class="added">Item added</span>  -->
                                                <i class="fa fa-shopping-cart"></i>  
                                                <i class="fa fa-square"></i> 
                                        </button>
                                    </form>
                                    <!-- Wishlist & Compare -->
                                    <div class="wishlist-compare d-flex flex-wrap align-items-center">
                                        <a href="#" class="wishlist-btn ml-15"><i class="icon_heart_alt"></i></a>
                                        <a href="#" class="compare-btn ml-15"><i class="arrow_left-right_alt"></i></a>
                                    </div>
                                </div>

                                <div class="products--meta">
                                    <p><span>SKU:</span> <span> {{ product.sku }}</span></p>
                                    <p><span>Category:</span> <span> {{categories}} </span></p>
                                    <p><span>Tags:</span> <span> {{tags}} </span></p>
                                    <p>
                                        <span>Share on:</span>
                                        <span>
                                            <a href="#"><i class="fa fa-facebook"></i></a>
                                            <a href="#"><i class="fa fa-twitter"></i></a>
                                            <a href="#"><i class="fa fa-pinterest"></i></a>
                                            <a href="#"><i class="fa fa-google-plus"></i></a>
                                        </span>
                                    </p>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="product_details_tab clearfix">
                            <!-- Tabs -->
                            <ul class="nav nav-tabs" role="tablist" id="product-details-tab">
                                <li class="nav-item">
                                    <a href="#description" class="nav-link active" data-toggle="tab"
                                        role="tab">Description</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#addi-info" class="nav-link" data-toggle="tab" role="tab">Additional
                                        Information</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#reviews" class="nav-link" data-toggle="tab" role="tab">Reviews <span
                                            class="text-muted">(1)</span></a>
                                </li>
                            </ul>
                            <!-- Tab Content -->
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane fade show active" id="description">
                                    <div class="description_area" v-html="product.descriptionLong">
                                    </div>
                                </div>
                                <div role="tabpanel" class="tab-pane fade" id="addi-info">
                                    <div class="additional_info_area" v-html="product.additionalInformation">
                                    </div>
                                </div>
                                <div role="tabpanel" class="tab-pane fade" id="reviews">
                                    <div class="reviews_area">
                                        <ul>
                                            <li>
                                                <div class="single_user_review mb-15">
                                                    <div class="review-rating">
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <span>for Quality</span>
                                                    </div>
                                                    <div class="review-details">
                                                        <p>by <a href="#">Colorlib</a> on <span>12 Sep 2018</span></p>
                                                    </div>
                                                </div>
                                                <div class="single_user_review mb-15">
                                                    <div class="review-rating">
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <span>for Design</span>
                                                    </div>
                                                    <div class="review-details">
                                                        <p>by <a href="#">Colorlib</a> on <span>12 Sep 2018</span></p>
                                                    </div>
                                                </div>
                                                <div class="single_user_review">
                                                    <div class="review-rating">
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <span>for Value</span>
                                                    </div>
                                                    <div class="review-details">
                                                        <p>by <a href="#">Colorlib</a> on <span>12 Sep 2018</span></p>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>

                                    <div class="submit_a_review_area mt-50">
                                        <h4>Submit A Review</h4>
                                        <form action="#" method="post">
                                            <div class="row">
                                                <div class="col-12">
                                                    <div class="form-group d-flex align-items-center">
                                                        <span class="mr-15">Your Ratings:</span>
                                                        <div class="stars">
                                                            <input type="radio" name="star" class="star-1" id="star-1">
                                                            <label class="star-1" for="star-1">1</label>
                                                            <input type="radio" name="star" class="star-2" id="star-2">
                                                            <label class="star-2" for="star-2">2</label>
                                                            <input type="radio" name="star" class="star-3" id="star-3">
                                                            <label class="star-3" for="star-3">3</label>
                                                            <input type="radio" name="star" class="star-4" id="star-4">
                                                            <label class="star-4" for="star-4">4</label>
                                                            <input type="radio" name="star" class="star-5" id="star-5">
                                                            <label class="star-5" for="star-5">5</label>
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-md-6">
                                                    <div class="form-group">
                                                        <label for="name">Nickname</label>
                                                        <input type="email" class="form-control" id="name"
                                                            placeholder="Nazrul">
                                                    </div>
                                                </div>
                                                <div class="col-12 col-md-6">
                                                    <div class="form-group">
                                                        <label for="options">Reason for your rating</label>
                                                        <select class="form-control" id="options">
                                                            <option>Quality</option>
                                                            <option>Value</option>
                                                            <option>Design</option>
                                                            <option>Price</option>
                                                            <option>Others</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <div class="form-group">
                                                        <label for="comments">Comments</label>
                                                        <textarea class="form-control" id="comments" rows="5"
                                                            data-max-length="150"></textarea>
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <button type="submit" class="btn alazea-btn">Submit Your
                                                        Review</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <related-products-area></related-products-area>

    </div>

</template>
<script lang='ts' src='./shop-details.page.ts'></script>