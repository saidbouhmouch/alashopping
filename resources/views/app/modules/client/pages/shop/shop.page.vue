<template>
   <div>
      <breadcrumb-area :title="'Shop'"></breadcrumb-area>
      <section class="shop-page section-padding-0-100">
         <div class="container">
            <div class="row">
               <!-- Shop Sorting Data -->
               <div class="col-12">
                  <div class="shop-sorting-data d-flex flex-wrap align-items-center justify-content-between">
                     <!-- Shop Page Count -->
                     <div class="shop-page-count">
                        <p>Showing {{filter.from+'-'+filter.to}} of {{filter.totalElements}} results</p>
                     </div>
                     <!-- Search by Terms -->
                     <div class="search_by_terms">
                        <form action="#" method="post" class="form-inline">
                           <select class="custom-select widget-title">
                              <option selected>Short by Popularity</option>
                              <option value="1">Short by Newest</option>
                              <option value="2">Short by Sales</option>
                              <option value="3">Short by Ratings</option>
                           </select>
                           <select class="custom-select widget-title" @change="onChangeSize($event)">
                              <option  v-for="size in sizes" 
                                       :key="size" 
                                       :selected="size == filter.size" 
                                       :value="size"> {{(size==9)?'Show: '+size:size}}
                              </option>
                           </select>
                        </form>
                     </div>
                  </div>
               </div>
            </div>
            <div class="row">
               <!-- Sidebar Area -->
               <div class="col-12 col-md-4 col-lg-3">
                  <div class="shop-sidebar-area">
                     <!-- Shop Widget -->
                     <div class="shop-widget price mb-50">
                        <h4 class="widget-title">Prices</h4>
                        <div class="widget-desc">
                                <div class="slider-range">
                                    <div data-min="8" data-max="30" data-unit="$" class="slider-range-price ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all" data-value-min="8" data-value-max="30" data-label-result="Price:">
                                        <div class="ui-slider-range ui-widget-header ui-corner-all"></div>
                                        <span class="ui-slider-handle ui-state-default ui-corner-all first-handle" tabindex="0"></span>
                                        <span class="ui-slider-handle ui-state-default ui-corner-all" tabindex="0"></span>
                                    </div>
                                    <div class="range-price">Price: ${{ filter && filter.price.min || 0}} - ${{ filter &&
                                 filter.price.max || 0}}</div>
                                </div>
                            </div>
                       
                     </div>
                     <!-- Shop Widget -->
                     <div class="shop-widget catagory mb-50">
                        <h4 class="widget-title">Categories</h4>
                        <div class="widget-desc">
                           <!-- Single Checkbox -->
                           <div class="custom-control custom-checkbox d-flex align-items-center mb-2">
                              <input type="checkbox" class="custom-control-input" id="customCheck1" @change="onSelectAllCategories($event)">
                              <label class="custom-control-label" for="customCheck1">All plants <span
                                    class="text-muted">({{filter.totalElements}})</span></label>
                           </div>
                           <!-- Single Checkbox -->
                           <div v-for="category in categories" :key="category.slug"
                              class="custom-control custom-checkbox d-flex align-items-center mb-2">
                              <input type="checkbox" class="custom-control-input" :id="category.slug" v-model="category.selected" @change="onCategoryChange($event)">
                              <label class="custom-control-label" :for="category.slug"> {{ category.name }} <span
                                    class="text-muted">{{ category.products_count }}</span></label>
                           </div>
                        </div>
                     </div>
                     <!-- Shop Widget -->
                     <div class="shop-widget sort-by mb-50">
                        <h4 class="widget-title">Sort by</h4>
                        <div class="widget-desc">
                           <!-- Single Checkbox -->
                           <div v-for="searchByTerm in searchByTerms" :key="searchByTerm.value" class="custom-control custom-checkbox d-flex align-items-center mb-2">
                              <input type="checkbox" v-model="searchByTerm.selected" class="custom-control-input" :id="searchByTerm.value"
                                 @change="onChangeSort($event,searchByTerm)">
                              <label class="custom-control-label" :for="searchByTerm.value">{{ searchByTerm.label }}</label>
                           </div>
                        </div>
                     </div>
                     <!-- Shop Widget -->
                     <div class="shop-widget best-seller mb-50">
                        <h4 class="widget-title">Best Seller</h4>
                        <div class="widget-desc">
                           <!-- Single Best Seller Products -->
                           <div class="single-best-seller-product d-flex align-items-center">
                              <div class="product-thumbnail">
                                 <router-link :to="{ path: '/shop-details'}"><img class="lazy" src="/img/bg-img/4.jpg" alt="">
                                 </router-link>
                              </div>
                              <div class="product-info">
                                 <router-link :to="{ path: '/shop-details'}">Cactus Flower</router-link>
                                 <p>$10.99</p>
                                 <div class="ratings">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                 </div>
                              </div>
                           </div>
                           <!-- Single Best Seller Products -->
                           <div class="single-best-seller-product d-flex align-items-center">
                              <div class="product-thumbnail">
                                 <router-link :to="{ path: '/shop-details'}"><img class="lazy" src="/img/bg-img/5.jpg" alt="">
                                 </router-link>
                              </div>
                              <div class="product-info">
                                 <router-link :to="{ path: '/shop-details'}">Tulip Flower</router-link>
                                 <p>$11.99</p>
                                 <div class="ratings">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                 </div>
                              </div>
                           </div>
                           <!-- Single Best Seller Products -->
                           <div class="single-best-seller-product d-flex align-items-center">
                              <div class="product-thumbnail">
                                 <router-link :to="{ path: '/shop-details'}"><img class="lazy" src="/img/bg-img/34.jpg" alt="">
                                 </router-link>
                              </div>
                              <div class="product-info">
                                 <router-link :to="{ path: '/shop-details'}">Recuerdos Plant</router-link>
                                 <p>$9.99</p>
                                 <div class="ratings">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
               <!-- All Products Area -->
               <div class="col-12 col-md-8 col-lg-9 tw-relative">
                  <div class="shop-products-area">

                     <div class="flex tw-justify-center tw-items-center" v-if="isLoading && products.length ==0">
                        <p class="tw-text-center">
                              Aucune donnée n'a été trouvée
                        </p>
                     </div>

                      <div v-bind:class="{'hidden' : isLoading}" class="tw-absolute tw-top-0 tw-bottom-0 tw-right-0 tw-left-0">
                              <loading-component :height="96" :width="96" ></loading-component>
                      </div>

                     <div class="row" v-bind:class="{'hidden' : !isLoading}">
                        <!-- Single Product Area -->

                        <div v-for="product in products" :key="product.slug" class="col-12 col-sm-6 col-lg-4">
                           <div class="single-product-area mb-50">
                              <!-- Product Image -->
                              <div class="product-img">
                                 <router-link :to="{ path: '/shop-details/'+product.slug}">
                                    <img class="lazy" :src="product.picture.url" alt="">
                                 </router-link>
                                 <!-- Product Tag -->
                                 <div class="product-tag" v-if="product.status" >
                                    <a href="javascript:void(0)" 
                                       v-bind:class="{
                                          'tw-bg-red-1000' : product.status == 'sale',
                                          'tw-bg-green-600' : product.status == 'new'
                                       }">
                                       {{product.status}}
                                    </a>
                                 </div>
                                 
                                 <div class="tw-flex tw-absolute tw-right-0 tw-top-0 tw-z-1">
                                    <count-down-component v-if="product.specificPrice.expirationDate" :expirationDate="product.specificPrice.expirationDate">
                                    </count-down-component>
                                 </div>

                                 <div class="product-meta d-flex">
                                    <a href="#" class="wishlist-btn"><i class="icon_heart_alt"></i></a>
                                    <a href="javascript:void(0)" @click="addProductToCart(product)" class="add-to-cart-btn">Add to cart</a>
                                    <a href="#" class="compare-btn"><i class="arrow_left-right_alt"></i></a>
                                 </div>
                              </div>
                              <!-- Product Info -->
                              <div class="product-info mt-15 text-center">
                                 <router-link :to="{ path: '/shop-details'}">
                                    <p> {{ product.name }} </p>
                                 </router-link>
                                 <h6 class="tw-flex tw-justify-center tw-items-center">
                                    <span class="ml-2" v-bind:class="{'text-barre' : product.specificPrice.reduction > 0}"> ${{ product.price}} </span>
                                
                                     <span v-if="product.specificPrice.reduction > 0" class="ml-2 tw-bg-red-1000 tw-px-1 tw-py-1 tw-rounded-md tw-text-white" > -{{ product.specificPrice.percentReduction }}% </span>
                                 </h6>
                              </div>
                           </div>
                        </div>

                     </div>
                     <!-- Pagination -->

                     <div class="tw-flex tw-justify-end" v-bind:class="{'hidden' : !isLoading || products.length == 0}">
                        <vue-ads-pagination
                                    :items-per-page="filter.size"
                                    :total-items="filter.totalElements"
                                    :max-visible-pages="5"
                                    :page="filter.page"
                                    :loading="false"
                                    @page-change="pageChange"
                                    @range-change="rangeChange"
                              >
                                    <!-- <template slot-scope="props">
                                       <div class="vue-ads-pr-2 vue-ads-leading-loose">
                                          Items {{ props.start }} tot {{ props.end }} van de {{ props.total }}
                                       </div>
                                    </template> -->
                                    <template
                                       slot="buttons"
                                       slot-scope="props"
                                    >
                                       <vue-ads-page-button
                                          v-for="(button, key) in props.buttons"
                                          :key="key"
                                          v-bind="button"
                                          @page-change="pageChange(button.page)"
                                       />
                                    </template>
                        </vue-ads-pagination>
                     </div>


                  </div>
               </div>
            </div>
         </div>
      </section>

   </div>
</template>
<script lang="ts" src='./shop.page.ts'></script>
<style lang="scss">
    @import "../../../../../../../node_modules/vue-ads-pagination/dist/vue-ads-pagination.css";

   .vue-ads-text-xs {
      font-size: 1.3rem;
      .vue-ads-leading-loose{
         display: none;
      }

      .vue-ads-justify-end{
         button{
            padding: 2px 10px;
            width: auto;
         }
      }
   }

</style>