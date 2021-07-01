<template>
  <!-- This example requires Tailwind CSS v2.0+ -->
  <div class="tw-fixed tw-z-10 tw-inset-0 tw-overflow-y-auto" aria-labelledby="modal-title" role="dialog"
    aria-modal="true">
    <div
      class="tw-flex tw-items-end tw-justify-center tw-min-h-screen tw-pt-4 tw-px-4 tw-pb-20 tw-text-center sm:tw-block sm:p-0">
      <div class="tw-fixed tw-inset-0 tw-bg-gray-500 tw-bg-opacity-75 tw-transition-opacity" aria-tw-hidden="true">
      </div>

      <span class="tw-hidden sm:tw-inline-block sm:tw-align-middle sm:tw-h-screen" aria-tw-hidden="true">&#8203;</span>

      <div
        class="tw-inline-block tw-align-bottom tw-bg-white tw-rounded-lg tw-text-left tw-overflow-hidden tw-shadow-xl tw-transform tw-transition-all sm:tw-my-8 sm:tw-align-middle sm:tw-max-w-4xl sm:tw-w-full">
        <div class="tw-bg-white tw-px-4 tw-pt-5 tw-pb-4 sm:tw-p-6 sm:tw-pb-4">
          <div class="sm:tw-flex sm:tw-items-start">
            <div
              class="tw-mx-auto tw-mt-0 tw-flex-shrink-0 tw-flex tw-items-center tw-justify-center tw-h-12 tw-w-12 tw-rounded-full tw-bg-red-100 sm:tw-mx-0 sm:tw-h-10 sm:tw-w-10">
              <i class="fa fa-truck tw-text-red-600"></i>
            </div>
            <div class="tw-mt-3 tw-text-center sm:tw-mt-0 sm:tw-ml-4 sm:tw-text-left tw-flex-grow">
              <h3 class="tw-text-lg tw-leading-6 tw-font-medium tw-text-gray-900" id="modal-title">
                Ship to
              </h3>
              <div class="tw-my-2 tw-max-w-xs">
                <v-select :value="country" label="name" id="countries" :options="countries" @input="onSelectedCountry">
                </v-select>
              </div>

              <h3 class="tw-text-lg tw-leading-6 tw-font-medium tw-text-gray-900" id="modal-title">
                Shipping Method
              </h3>

              <div class="tw-mt-2">
                <div class="tw-flex tw-flex-col tw-relative">

                  <div v-bind:class="{'hidden' : isLoading}"
                    class="tw-absolute tw-min-h-full tw-top-0 tw-bottom-0 tw-right-0 tw-left-0 tw-flex tw-items-center tw-justify-center tw-bg-white">
                    <loading-component :height="64" :width="64"></loading-component>
                  </div>

                  <div class="tw--my-2 tw-overflow-x-auto sm:tw--mx-6 lg:tw--mx-8">
                    <div class="tw-py-2 tw-align-middle tw-inline-block tw-min-w-full sm:tw-px-6 lg:tw-px-8">
                      <div class="tw-shadow tw-overflow-hidden tw-border-b tw-border-gray-200 sm:tw-rounded-lg">
                        <table class="tw-min-w-full tw-divide-y tw-divide-gray-200">
                          <thead class="tw-bg-gray-50">
                            <tr>
                              <th scope="tw-col"
                                class="tw-px-6 tw-py-3 tw-text-left tw-text-xs tw-font-medium tw-text-gray-500 tw-uppercase tw-tracking-wider">

                              </th>
                              <th scope="tw-col"
                                class="tw-px-6 tw-py-3 tw-text-left tw-text-xs tw-font-medium tw-text-gray-500 tw-uppercase tw-tracking-wider">
                                Estimated Delivery
                              </th>
                              <th scope="tw-col"
                                class="tw-px-6 tw-py-3 tw-text-left tw-text-xs tw-font-medium tw-text-gray-500 tw-uppercase tw-tracking-wider">
                                Price
                              </th>
                              <th scope="tw-col"
                                class="tw-px-6 tw-py-3 tw-text-left tw-text-xs tw-font-medium tw-text-gray-500 tw-uppercase tw-tracking-wider">
                                Carrier
                              </th>
                            </tr>
                          </thead>
                          <tbody class="tw-bg-white tw-divide-y tw-divide-gray-200">
                            <tr v-for="(shipping,index) in shippings" :key='index'>
                              <td class="tw-px-6 tw-py-4 tw-whitespace-nowrap">
                                <input type="radio" name="shipping" id="" @change="onSelectedShipping(shipping)">
                              </td>
                              <td class="tw-px-6 tw-py-4 tw-whitespace-nowrap">
                                <div class="tw-text-sm tw-text-gray-900">
                                  {{shipping.estimatedDeliveryMin}}-{{shipping.estimatedDeliveryMax}} days
                                </div>
                              </td>
                              <td class="tw-px-6 tw-py-4 tw-whitespace-nowrap">
                                <span
                                  class="tw-px-2 tw-inline-flex tw-text-xs tw-leading-5 tw-font-semibold tw-rounded-full tw-bg-green-100 ">
                                  ${{shipping.price}}
                                </span>
                              </td>
                              <td class="tw-px-6 tw-py-4 tw-whitespace-nowrap tw-text-sm tw-text-gray-500">
                                <div class="tw-flex tw-items-center tw-justify-items-center">
                                  <img :src="(shipping.carrier)?(shipping.carrier.picture.url):''"
                                    class="tw-w-8 tw-mx-1">
                                  {{shipping.carrier.name}}
                                </div>
                              </td>
                            </tr>

                            <!-- More people... -->
                          </tbody>
                        </table>
                      </div>
                    </div>
                  </div>
                </div>

              </div>

            </div>
          </div>
        </div>
        <div class="tw-bg-gray-50 tw-px-4 tw-py-3 sm:tw-px-6 sm:tw-flex sm:tw-flex-row-reverse">
          <button type="button" :disabled="!(this.shippingSelected.to.code != '' && this.shippingSelected.id > 0)"
            @click="apply($event)"
            class="tw-w-full tw-inline-flex tw-justify-center tw-rounded-md tw-border tw-border-transparent tw-shadow-sm tw-px-4 tw-py-2 tw-bg-red-600 tw-text-base tw-font-medium tw-text-white hover:tw-bg-red-700 focus:tw-outline-none focus:tw-ring-2 focus:tw-ring-offset-2 focus:tw-ring-red-500 sm:tw-ml-3 sm:tw-w-auto sm:tw-text-sm">
            Apply
          </button>
          <button type="button" @click="closeModal"
            class="tw-mt-3 tw-w-full tw-inline-flex tw-justify-center tw-rounded-md tw-border tw-border-gray-300 tw-shadow-sm tw-px-4 tw-py-2 tw-bg-white tw-text-base tw-font-medium tw-text-gray-700 hover:tw-bg-gray-50 focus:tw-outline-none focus:tw-ring-2 focus:tw-ring-offset-2 focus:tw-ring-indigo-500 sm:tw-mt-0 sm:tw-ml-3 sm:tw-w-auto sm:tw-text-sm">
            Cancel
          </button>
        </div>
      </div>
    </div>
  </div>

</template>

<style lang="css">
  @import "vue-select/dist/vue-select.css";
</style>

<style lang="css">
  .v-select .vs__dropdown-toggle {
    padding: 0.3rem .8rem;
  }
</style>

<script lang='ts' src="./shipping-modal.component.ts"></script>