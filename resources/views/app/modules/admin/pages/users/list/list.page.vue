<template>
   <div class="main-content-inner">
      <div class="row">
         <!-- data table start -->
         <div class="col-12 mt-5 relative">

          <loader-component :isVisible="isVisibleLoader"></loader-component>

            
            <div class="card">
               <div class="card-body">
                  <h4 class="header-title relative">Users</h4>
                  <router-link :to="{ path: '/admin/users/create' }">
                     <button type="button" class="btn btn-flat btn-outline-secondary px-3 py-2 absolute" style="left: 234px; z-index:10">add user</button>
                  </router-link>
                  <div class="data-tables mt-4 pt-2">
                     <table id="dataTable" class="text-center">
                        <thead class="bg-light text-capitalize">
                           <tr>
                              <th>Avatar</th>
                              <th>Name</th>
                              <th>Role</th>
                              <th>Action</th>
                           </tr>
                        </thead>
                        <tbody>
                           <tr v-for="user in users" :key="user.id">
                              <td>
                                 <img :src="user.image.url" width="32" />
                              </td>
                              <td> {{ user.first_name }} {{ user.last_name }} </td>
                              <td>{{ user.roles[0].name }}</td>
                              <td>
                                   <router-link :to="{ path: `/admin/users/${user.id}/edit` }">
                                       <button type="button" class="btn btn-outline-secondary btn-xs mb-3">
                                            <i class="ti-pencil-alt"></i>
                                                Edit
                                       </button>
                                    </router-link>
                                    
                                    <button type="button" v-on:click="userDelete($event,user.id)" class="btn btn-outline-danger btn-xs mb-3">
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