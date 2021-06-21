<template>
<div class="avatarWrapper">
    <div class="avatar cursor-pointer" v-bind:class="{ empty: picture == '' }">
        <div class="uploadOverlay" v-on:click="onClickUploadOverlay($event)">
            <i class="fa fa-cloud-upload"></i>
        </div>
        <input type="file" name="pictureToUpload" ref="inputFile"  class="d-none" v-on:change="uploadImage($event)" accept="image/*" />
        <img :src="picture" />
    </div>
</div>
</template>

<style lang="scss">
@import "./upload-image.component.scss";
</style>

<script src="./upload-image.component.ts"></script>
