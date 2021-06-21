<template>
   <div class="main-content-inner">
      <div class="row">
         <div class="col-12 mt-5">
            <div class="card">
               <div class="card-body">
                  <form action="" v-on:submit="update($event)">
                     <h4 class="header-title">Information</h4>
                     <div class="row">
                        <div class="form-group col-sm-12">
                           <label for="name" class="col-form-label">Name</label>
                           <input class="form-control" required type="text" id="name"  v-model="currency.name" >
                        </div>

                        <div class="form-group col-sm-12">
                           <label for="name" class="col-form-label">Iso</label>
                           <input class="form-control" required type="text" id="iso"  v-model="currency.iso" >
                        </div>

                        <div class="form-group col-sm-12">
                           <label for="name" class="col-form-label">Value</label>
                           <input class="form-control" required type="number" id="value"  v-model="currency.value" >
                        </div>

                         <div class="form-group col-sm-12">
                             <div class="custom-control custom-checkbox">
                                 <input type="checkbox" checked="" class="custom-control-input" id="default" v-model="currency.default">
                                 <label class="custom-control-label" for="default" >Default</label>
                              </div>
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