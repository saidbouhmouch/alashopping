<template>
   <div class="main-content-inner">
      <div class="row">
         <div class="col-12 mt-5">
            <div class="card">
               <div class="card-body">
                  <form action="" v-on:submit="update($event)">
                     <h4 class="header-title">Information</h4>
                     <div class="row">
                        <div class="col-6 col-sm-4">
                           <upload-image :picture="user.picture.url" @changePicture="onChangePicture($event)"></upload-image>
                        </div>
                     </div>
                     <div class="row">
                        <div class="form-group col-sm-6">
                           <label for="first_name" class="col-form-label">First name</label>
                           <input class="form-control" required type="text" id="first_name"  v-model="user.firstName" >
                        </div>
                        <div class="form-group col-sm-6">
                           <label for="last_name" class="col-form-label">Last name</label>
                           <input class="form-control" required type="text"  id="last_name" v-model="user.lastName">
                        </div>
                     </div>
                     <div class="row">
                        <div class="form-group col-sm-6">
                           <label for="email" class="col-form-label">Email</label>
                           <input class="form-control" required type="text"  id="email" v-model="user.email">
                        </div>
                        <div class="form-group col-sm-6">
                           <label for="phone" class="col-form-label">Phone</label>
                           <input class="form-control" required type="tel"  id="phone" v-model="user.phone">
                        </div>
                     </div>
                     <div class="row">
                        <div class="form-group col-sm-6">
                           <b class="text-muted mb-3 mt-4 d-block">Gender:</b>
                           <div class="custom-control custom-radio custom-control-inline">
                              <input type="radio" id="customRadio5" name="gender" class="custom-control-input" value="MAN" v-model="user.gender">
                              <label class="custom-control-label" for="customRadio5" >Man</label>
                           </div>
                           <div class="custom-control custom-radio custom-control-inline">
                              <input type="radio" checked="checked"  v-model="user.gender" id="customRadio4" name="gender" value="MALE" class="custom-control-input">
                              <label class="custom-control-label" for="customRadio4">Male</label>
                           </div>
                        </div>
                        <div class="form-group col-sm-6">
                           <label for="roles" class="col-form-label">Roles</label>
                           <v-select label="name" id="roles" :options="roles" @input="onSelectedRole" :value="user.role" ></v-select>
                        </div>
                     </div>
                     <div class="row">
                        <div class="form-group col-sm-6">
                           <label for="addresse" class="col-form-label">Addresse</label>
                           <input class="form-control" required  type="text"  id="addresse" v-model="user.addresse.addresse">
                        </div>
                        <div class="form-group col-sm-6">
                           <label for="city" class="col-form-label">City</label>
                           <input class="form-control" required  type="text"  id="city" v-model="user.addresse.city">
                        </div>
                     </div>
                     <div class="row">
                        <div class="form-group col-sm-6">
                           <label for="zipcode" class="col-form-label">Zipcode</label>
                           <input class="form-control" required  type="text"  id="zipcode" v-model="user.addresse.zipcode">
                        </div>
                        <div class="form-group col-sm-6">
                           <label for="countries" class="col-form-label">Countries</label>
                           <v-select id="countries" label="name" :options="countries" @input="onSelectedCountry" :value="user.addresse.country"  ></v-select>
                        </div>
                     </div>
                     <!-- <div class="row">
                        <div class="form-group col-sm-6">
                           <label for="password" class="">Password</label>
                           <input type="password" class="form-control" required id="password"  placeholder="******" v-model="user.password" minlength="8">
                        </div>
                     </div> -->
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
<script src="./update.page.ts"></script>
<style lang="css" scoped >
      @import "vue-select/dist/vue-select.css";
</style>
<style lang="css">
   .v-select .vs__dropdown-toggle{
   padding: 0.3rem .8rem;
   }
</style>