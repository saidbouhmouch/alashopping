<template>
  <div>
    <!-- Preloader -->
    <div class="preloader d-flex align-items-center justify-content-center">
        <div class="preloader-circle"></div>
        <div class="preloader-img">
            <img src="/img/core-img/leaf.png" alt="">
        </div>
    </div>
    <notifications group="alashopping" />
   <header-component></header-component>
    <router-view/>
    <footer-component></footer-component>
  </div>
</template>
<script lang="ts" src='./master.component.ts'></script>
