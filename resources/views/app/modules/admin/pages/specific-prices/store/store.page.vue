<template>
   <div class="main-content-inner">
      <div class="row">
         <div class="col-12 mt-5">
            <div class="card">
               <div class="card-body">
                  <form action="" v-on:submit="save($event)">
                     <h4 class="header-title">Specific Price</h4>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="products" class="col-form-label">Products</label>
                           <v-select multiple label="name" id="products" :options="optionsProducts" @input="onSelectedProduct"></v-select>
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="discount-type" class="col-form-label">Discount type</label>
                           <v-select id="discount-type" :options="discountType" @input="onSelectedDiscountType">
                           </v-select>
                        </div>
                     </div>


                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="reduction" class="col-form-label">Reduction</label>
                           <input class="form-control" required type="number" id="reduction" min="0"
                              v-model="specificPrice.reduction">
                        </div>
                     </div>

                      <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="start-date" class="col-form-label">Start date</label>
                           <input class="form-control" required type="datetime-local" id="start-date"
                           :min="minDate()"
                           v-model="specificPrice.startDate">
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="expiration-date" class="col-form-label">Expiration date</label>
                           <input class="form-control" required
                           :min="minDate(specificPrice.startDate)"
                           type="datetime-local" id="expiration-date"
                                 v-model="specificPrice.expirationDate">
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
<script lang="ts" src="./store.page.ts"></script>
