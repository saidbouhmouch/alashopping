<template>
   <div class="main-content-inner">
      <div class="row">
         <div class="col-12 mt-5">
            <div class="card">
               <div class="card-body">
                  <form action="" v-on:submit="save($event)">
                     <h4 class="header-title">Shipping</h4>

                      <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="from" class="col-form-label">From</label>
                           <v-select label="name" id="from" :options="countries" @input="onSelectedFrom">
                           </v-select>
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="to" class="col-form-label">To</label>
                           <v-select label="name" id="to" :options="countries" @input="onSelectedTo">
                           </v-select>
                        </div>
                     </div>
                     
                    <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="carrier" class="col-form-label">Carrier</label>
                           <v-select label="name" id="carrier" :options="carriers" @input="onSelectedCarrier">
                           </v-select>
                        </div>
                     </div>

                      <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="price" class="col-form-label">Price</label>
                           <input class="form-control" required type="number" id="price"  v-model="shipping.price" >
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="currencies" class="col-form-label">Currencies</label>
                           <v-select label="name" id="currencies" :options="currencies" @input="onSelectedCurrency">
                           </v-select>
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="estimatedDeliveryMin" class="col-form-label">Estimated delivery min</label>
                           <input class="form-control" required type="number" id="estimatedDeliveryMin" min="1"  v-model="shipping.estimatedDeliveryMin" >
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="estimatedDeliveryMax" class="col-form-label">Estimated delivery max</label>
                           <input class="form-control" required type="number" id="estimatedDeliveryMax" min="1"  v-model="shipping.estimatedDeliveryMax" >
                        </div>
                     </div>
                    
                     <div class="row">
                        <div class="col-5 col-sm-2">
                           <button class="btn btn-flat btn-success mb-3 w-100" type="submit" >
                               <span class="tw-mr-2"> save </span>
                               <i v-if="isLoading"  class="fa fa-refresh fa-spin"></i>
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