<template>

     <div class="breadcrumb-area">
        <!-- Top Breadcrumb Area -->
        <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(/img/bg-img/24.jpg);">
            <h2> {{ title }} </h2>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <router-link  :to="'/'" >
                                        <i class="fa fa-home"></i> Home
                                    </router-link>
                            </li>
                            <li class="breadcrumb-item active uppercase" aria-current="page">{{title}}</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>

</template>

<script lang="ts" src='./breadcrumb-area.component.ts'></script>
