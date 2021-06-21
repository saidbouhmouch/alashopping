<template>
   <div class="sidebar-menu">
      <div class="sidebar-header">
         <div class="logo">
            <a href="index.html">
            <img src="/img/icon/logo.png" alt="logo" />
            </a>
         </div>
      </div>
      <div class="main-menu">
         <div class="menu-inner">
            <nav>
               <ul class="metismenu" id="menu">
                  <li v-for="item in sidebar" :key="item.id" v-bind:class="{ active: item.active }">
                     <a href="javascript:void(0)" aria-expanded="true" v-on:click="onParentClick(item)" v-if="item.children">
                     <i :class="item.icon"></i>
                     <span>{{ item.text }}</span>
                     </a>

                     <router-link :to="item.url" v-on:click="onParentClick(item)" v-if="!item.children">
                           <i :class="item.icon"></i>
                           <span>{{ item.text }}</span>
                     </router-link>
                     
                     <ul v-bind:class="{ collapse: !item.expanded }" v-if="item.children">
                        <li
                           v-for="child in item.children"
                           :key="child.id"
                           v-bind:class="{ active: child.active }"
                           >
                           <router-link :to="child.url">
                              <i :class="child.icon"></i>
                              {{child.text}}</router-link>
                        </li>
                     </ul>
                  </li>
               </ul>
            </nav>
         </div>
      </div>
   </div>
</template>
<script lang="ts" src="./sidebar.component.ts" ></script>
