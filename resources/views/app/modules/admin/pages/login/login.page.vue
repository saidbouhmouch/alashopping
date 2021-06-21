<template>
    <div class="login-area relative">
        <loader-component :isVisible="isVisibleLoader"></loader-component>
        <div class="container">
            <div class="login-box ptb--100">
                <form v-on:submit="login($event)">
                    <div class="login-form-head">
                        <h4>Sign In</h4>
                    </div>
                    <div class="login-form-body">
                        <div class="form-gp focused">
                            <label for="exampleInputEmail1">Email address</label>
                            <input type="email" id="exampleInputEmail1" v-model="user.username" minlength="4">
                            <i class="ti-email"></i>
                            <div class="text-danger"></div>
                        </div>
                        <div class="form-gp focused">
                            <label for="exampleInputPassword1">Password</label>
                            <input type="password" id="exampleInputPassword1" v-model="user.password" minlength="8">
                            <i class="ti-lock"></i>
                            <div class="text-danger"></div>
                        </div>
                        <div class="row mb-4 rmber-area">
                            <div class="col-6">
                                <div class="custom-control custom-checkbox mr-sm-2">
                                    <input type="checkbox" class="custom-control-input" id="customControlAutosizing"
                                        v-model="user.remember">
                                    <label class="custom-control-label" for="customControlAutosizing">Remember
                                        Me</label>
                                </div>
                            </div>
                            <div class="col-6 text-right">
                                <a href="javascript:void(0)">Forgot Password?</a>
                            </div>
                        </div>
                        <div class="submit-btn-area">

                            <button id="form_submit" type="submit">
                                <span class="tw-mr-2"> Submit <i v-if="!isLoading" class="ti-arrow-right"></i> </span>
                                <i v-if="isLoading" class="fa fa-refresh fa-spin"></i>
                            </button>

                            <div class="login-other row mt-4">
                                <div class="col-6">
                                    <a class="fb-login" href="javascript:void(0)">Log in with <i
                                            class="fa fa-facebook"></i></a>
                                </div>
                                <div class="col-6">
                                    <a class="google-login" href="javascript:void(0)">Log in with <i
                                            class="fa fa-google"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="form-footer text-center mt-5">
                            <p class="text-muted">Don't have an account? <a href="javascript:void(0)">Sign up</a></p>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>

<style lang="scss">
 @import "./login.page.scss";
</style>

<script lang="ts" src="./login.page.ts"></script>