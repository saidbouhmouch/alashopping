<template>
  <div>
    <!-- Preloader -->
    <div class="preloader d-flex align-items-center justify-content-center">
        <div class="preloader-circle"></div>
        <div class="preloader-img">
            <img src="/img/core-img/leaf.png" alt="">
        </div>
    </div>
   <header-component></header-component>
    <router-view/>
    <footer-component></footer-component>
    <alert-component :data='notifyData' v-if="isShowAlert" v-on:closeModal='toggleAlert' ></alert-component>
  </div>
</template>
<script lang="ts" src='./master.component.ts'></script>
