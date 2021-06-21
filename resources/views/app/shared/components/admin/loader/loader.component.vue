<template>
<div class="preloader" v-if="isVisible">
    <div class="loader"></div>
</div>
</template>
<style lang="css" scoped>
  .preloader{
    position: absolute;
    width: 100%;
    height: 100%;
    display: flex;
    z-index: 11;
    background: #f8f9fa;
  }
</style>
<script lang="ts" src="./loader.component.ts"></script>