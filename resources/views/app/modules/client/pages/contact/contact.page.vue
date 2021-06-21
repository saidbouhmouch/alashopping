<template>
  <div>
        <breadcrumb-area :title="'Contact'"></breadcrumb-area>

        <div class="contact-area-info section-padding-0-100">
        <div class="container">
            <div class="row align-items-center justify-content-between">
                <!-- Contact Thumbnail -->
                <div class="col-12 col-md-6">
                    <div class="contact--thumbnail">
                        <img src="/img/bg-img/25.jpg" alt="">
                    </div>
                </div>

                <div class="col-12 col-md-5">
                    <!-- Section Heading -->
                    <div class="section-heading">
                        <h2>CONTACT US</h2>
                        <p>We are improving our services to serve you better.</p>
                    </div>
                    <!-- Contact Information -->
                    <div class="contact-information">
                        <p><span>Address:</span> 505 Silk Rd, New York</p>
                        <p><span>Phone:</span> +1 234 122 122</p>
                        <p><span>Email:</span> info.deercreative@gmail.com</p>
                        <p><span>Open hours:</span> Mon - Sun: 8 AM to 9 PM</p>
                        <p><span>Happy hours:</span> Sat: 2 PM to 4 PM</p>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <contact-area></contact-area>

  </div>
</template>

<script lang="ts" src='./contact.page.ts'></script>
