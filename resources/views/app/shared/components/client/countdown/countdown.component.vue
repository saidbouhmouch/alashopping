<template>
  <div id="countdown" v-if="isShow"  class="" >
    <ul class="tw-flex tw-mt-2 tw-mr-2">
      <li ><span class="tw-inline-flex tw-min-w-6 tw-py-1 tw-bg-white tw-font-semibold tw-rounded-md tw-justify-center">{{days}}</span>&nbsp;d&nbsp; </li>
      <li ><span class="tw-inline-flex tw-min-w-6 tw-py-1 tw-bg-white tw-font-semibold tw-rounded-md tw-justify-center">{{hours}}</span> &nbsp;:&nbsp; </li>
      <li ><span class="tw-inline-flex tw-min-w-6 tw-py-1 tw-bg-white tw-font-semibold tw-rounded-md tw-justify-center">{{minutes}}</span> &nbsp;:&nbsp; </li>
      <li ><span class="tw-inline-flex tw-min-w-6 tw-py-1 tw-bg-white tw-font-semibold tw-rounded-md tw-justify-center">{{seconds}}</span></li>
    </ul>
  </div>
</template>

<script lang="ts" src='./countdown.component.ts'></script>
