<template>
   <div class="main-content-inner">
      <div class="row">
         <div class="col-12 mt-5">
            <div class="card">
               <div class="card-body">
                  <form action="" v-on:submit="save($event)">
                     <h4 class="header-title">Product</h4>
                     <div class="row tw-flex tw-flex-col">
                        <span>Picture size :(270/320)px</span>
                        <div class="col-6 col-sm-4">
                           <upload-image :picture="product.picture.url" @changePicture="onChangePicture($event)">
                           </upload-image>
                        </div>
                     </div>
                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="name" class="col-form-label">Name</label>
                           <input class="form-control" required type="text" id="name" v-model="product.name">
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="price" class="col-form-label">Price</label>
                           <input class="form-control" required type="number" id="price" min="1"
                              v-model="product.price">
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="description-short" class="col-form-label">Description Short</label>
                           <textarea v-model="product.descriptionShort" class="form-control summernote" rows="3"
                              id="description-short"></textarea>
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="description-long" class="col-form-label">Description Long</label>
                           <textarea v-model="product.descriptionLong" class="form-control summernote" rows="3"
                              id="description-long"></textarea>
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="sku" class="col-form-label">Sku</label>
                           <input class="form-control" required type="text" id="sku" v-model="product.sku">
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="stock" class="col-form-label">Stock</label>
                           <input class="form-control" required type="number" id="stock" min="0"
                              v-model="product.stock">
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="additional-information" class="col-form-label">Additional Information</label>
                           <textarea v-model="product.additionalInformation" class="form-control summernote" rows="3"
                              id="additional-information"></textarea>
                        </div>
                     </div>



                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="currencies" class="col-form-label">Currencies</label>
                           <v-select label="name" id="currencies" :value="product.currency" :options="currencies"
                              @input="onSelectedCurrency">
                           </v-select>
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="taxes" class="col-form-label">Taxes</label>
                           <v-select label="name" id="taxes" :value="product.taxe" :options="taxes"
                              @input="onSelectedTaxe"></v-select>
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="tags" class="col-form-label">Tags</label>
                           <v-select multiple label="name" id="tags" :value="product.tags" :options="tags"
                              @input="onSelectedTag"></v-select>
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="categories" class="col-form-label">Categories</label>
                           <v-select multiple label="name" id="categories" 
                           :value="product.categories"
                           :options="categories"
                              @input="onSelectedCategory"></v-select>
                        </div>
                     </div>


                     <div class="row mb-4 rmber-area">
                        <div class="col-6">
                           <div class="custom-control custom-checkbox mr-sm-2">
                              <input type="checkbox" v-model="product.active" id="customControlShow"
                                 class="custom-control-input"> <label for="customControlShow"
                                 class="custom-control-label">show
                              </label>
                           </div>
                        </div>
                     </div>



                     <div class="row">
                        <div class="col-12">
                           <label class="col-form-label">Galleries (500px/500px)</label>
                        </div>
                        <div class="col-sm-3" v-for="(gallery, index) in galleries" :key="index">
                           <upload-image :picture="gallery.url" :id="gallery.id"
                              @changePicture="onChangeGallery($event)"></upload-image>
                        </div>

                        <div class="col-sm-3">
                           <upload-image :picture="''" @changePicture="onAddGallery($event)"></upload-image>
                        </div>

                     </div>


                     <div class="row tw-mt-10">
                        <div class="col-5 col-sm-2">
                           <button class="btn btn-flat btn-success mb-3 w-100" type="submit">
                              <span class="tw-mr-2"> save </span>
                              <i v-if="isLoading" class="fa fa-refresh fa-spin"></i>
                           </button>
                        </div>
                     </div>
                  </form>
               </div>
            </div>
         </div>
      </div>
   </div>
</template>

<style lang="css">
   @import "vue-select/dist/vue-select.css";
</style>

<style lang="css">
   .v-select .vs__dropdown-toggle {
      padding: 0.3rem .8rem;
   }
</style>
<script lang="ts" src="./update.page.ts"></script>