<template>
   <div class="main-content-inner">
      <div class="row">
         <div class="col-12 mt-5">
            <div class="card">
               <div class="card-body">
                  <h4 class="header-title relative">Specific Prices</h4>
                  <router-link :to="{ path: '/admin/specific-prices/create' }">
                     <button type="button" class="btn btn-flat btn-outline-secondary px-3 py-2 absolute" style="left: 234px;">Add Specific Price</button>
                  </router-link>
                  <div class="data-tables mt-4 pt-2">
                     <table id="dataTable" class="text-center">
                        <thead class="bg-light text-capitalize">
                           <tr>
                              <th>Product</th>
                              <th>Start date</th>
                              <th>Expiration date</th>
                              <th>Discount type</th>
                              <th>Reduction</th>
                              <th>Old price</th>
                              <th> Reduced price</th>
                              <th>Action</th>
                           </tr>
                        </thead>
                        <tbody>
                           <tr v-for="specificPrice in specificPrices" :key="specificPrice.id">
                              <td> {{ specificPrice.product.name || ''}} </td>
                              <td> {{ specificPrice.start_date || '' }} </td>
                              <td> {{ specificPrice.expiration_date || '' }} </td>
                              <td> {{ specificPrice.discount_type || '' }} </td>
                              <td> {{  reductionFormat(specificPrice) || '' }} </td>
                              <td>{{ (specificPrice.product.price +' '+specificPrice.product.currency.iso )|| ''  }}</td>
                              <td> {{ caluculeReducedPrice(specificPrice) }} </td>
                              <td>
                                   <router-link :to="{ path: `/admin/specific-prices/${specificPrice.id}/edit` }">
                                       <button type="button" class="btn btn-outline-secondary btn-xs mb-3">
                                            <i class="ti-pencil-alt"></i>
                                                Edit
                                       </button>
                                    </router-link>

                                    <button type="button" v-on:click="specificPriceDelete($event,specificPrice.id)" class="btn btn-outline-danger btn-xs mb-3">
                                    <i class="ti-trash"></i>
                                     Delete
                                    </button>

                              </td>
                           </tr>
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</template>
<script lang="ts" src="./list.page.ts"></script>
