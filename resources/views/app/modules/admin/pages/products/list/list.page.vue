<template>
   <div class="main-content-inner">
      <div class="row">
         <div class="col-12 mt-5">
            <div class="card">
               <div class="card-body">
                  <h4 class="header-title relative">Products</h4>
                  <router-link :to="{ path: '/admin/products/create' }">
                     <button type="button" class="btn btn-flat btn-outline-secondary px-3 py-2 absolute" style="left: 234px;">Add Product</button>
                  </router-link>
                  <div class="data-tables mt-4 pt-2">
                     <table id="dataTable" class="text-center">
                        <thead class="bg-light text-capitalize">
                           <tr>
                              <th>Picture </th>
                              <th>Name</th>
                              <th>Price</th>
                              <th>Stock</th>
                              <th>Status</th>
                              <th>Action</th>
                           </tr>
                        </thead>
                        <tbody>
                           <tr v-for="product in products" :key="product.id">
                              <td>
                                 <img :src="(product.image.children && product.image.children.length > 0)?product.image.children[0].url : product.image.url" width="32" />
                              </td>
                              <td> {{ product.name }} </td>
                              <td>{{ product.price }}</td>
                              <td>{{ product.stock }}</td>
                              <td>{{ (product.active)?'Active' : "no Active"}}</td>
                              <td>
                                   <router-link :to="{ path: `/admin/products/${product.id}/edit` }">
                                       <button type="button" class="btn btn-outline-secondary btn-xs mb-3">
                                            <i class="ti-pencil-alt"></i>
                                                Edit
                                       </button>
                                    </router-link>
                                    
                                    <button type="button" v-on:click="productDelete($event,product.id)" class="btn btn-outline-danger btn-xs mb-3">
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