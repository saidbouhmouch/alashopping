<template>
   <div class="main-content-inner">
      <div class="row">
         <!-- data table start -->
         <div class="col-12 mt-5">
            <div class="card">
               <div class="card-body">
                  <h4 class="header-title relative">Shipping</h4>
                  <router-link :to="{ path: '/admin/shipping/create' }" class="relative">
                     <button type="button" class="btn btn-flat btn-outline-secondary px-3 py-2 absolute" style="left: 234px;">add shipping</button>
                  </router-link>
                  <div class="data-tables mt-4 pt-2">
                     <table id="dataTable" class="text-center">
                        <thead class="bg-light text-capitalize">
                           <tr>
                              <th>Name</th>
                              <th>From</th>
                              <th>To</th>
                              <th>Price</th>
                              <th>Action</th>
                           </tr>
                        </thead>
                        <tbody>
                           <tr v-for="shipping in shippings" :key="shipping.id">
                              <td> 
                                 <div class="tw-flex tw-items-center">
                                <span class="tw-mr-2">{{ shipping.carrier.name }}</span>  <img :src="(shipping.carrier.picture)?shipping.carrier.picture.url:''" width="32" />

                                 </div>
                              </td>
                              <td> {{ shipping.from.name }} </td>
                              <td> {{ shipping.to.name }} </td>
                              <td> {{ shipping.price }} </td>
                              
                              <td>
                                 <router-link :to="{ path: `/admin/shipping/${shipping.id}/edit` }">
                                    <button type="button" class="btn btn-outline-secondary btn-xs mb-3">
                                    <i class="ti-pencil-alt"></i>
                                    Edit
                                    </button>
                                 </router-link>
                                 <button type="button" v-on:click="deleteShipping($event,shipping.id)" class="btn btn-outline-danger btn-xs mb-3">
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