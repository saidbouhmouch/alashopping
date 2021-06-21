<template>
   <div class="main-content-inner">
      <div class="row">
         <div class="col-12 mt-5">
            <div class="card">
               <div class="card-body">
                  <form action="" v-on:submit="update($event)">
                     <h4 class="header-title">Carriers</h4>
                     <div class="row">
                        <div class="col-6 col-sm-4">
                           <upload-image :picture="carrier.picture.url" @changePicture="onChangePicture($event)"></upload-image>
                        </div>
                     </div>
                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="name" class="col-form-label">Name</label>
                           <input class="form-control" required type="text" id="name"  v-model="carrier.name" >
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="price" class="col-form-label">Price</label>
                           <input class="form-control" required type="number" id="price"  v-model="carrier.price" >
                        </div>
                     </div>

                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="delivery-text" class="col-form-label">Delivery text</label>
                           <input class="form-control" required type="text" id="delivery-text"  v-model="carrier.deliveryText" >
                        </div>
                     </div>
                    
                     <div class="row">
                        <div class="col-5 col-sm-2">
                           <button class="btn btn-flat btn-success mb-3 w-100" type="submit" >
                               <span class="tw-mr-2"> update </span>
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
<script lang="ts" src="./update.page.ts"></script>