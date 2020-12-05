import Vue from 'vue/dist/vue.esm'
import { unpackSDKMeta } from '@paypal/sdk-client';
import vuePaypalSmartPaymentButtons from "vue-paypal-smart-payment-buttons";

document.addEventListener('DOMContentLoaded', () => {
  var storeList = new Vue({
    el: '#store-list',
    components: {
      vuePaypalSmartPaymentButtons
    },
    props: {
    },
    data: {
    },
    mounted: function() {
    },
    methods: {
    }    
  })
})
