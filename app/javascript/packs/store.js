import Vue from 'vue/dist/vue.esm'
import { unpackSDKMeta } from '@paypal/sdk-client';
import vuePaypalSmartPaymentButtons from "vue-paypal-smart-payment-buttons";

// MIXINS
// For grabbing the CSRF token to be used to submit to internal API endpoint
// import CsrfHelper from '../mixins/csrf_helper.js';

document.addEventListener('DOMContentLoaded', () => {
  var storeList = new Vue({
    el: '#store-list',
    components: {
      vuePaypalSmartPaymentButtons
    },
    data: {
    },
    mounted: function() {
    },
    methods: {
      processing(paypalOrderId) {
        console.log('processing!!!');
      },

      finishing: async(order) => {
        let csrf_token_dom  = document.querySelector('meta[name="csrf-token"]');
        let csrf_token      = csrf_token_dom ? csrf_token_dom.content : '';

        const response = await fetch('/api/v1/store/paypal_purchases', {
          method:   'POST',
          headers:  { "Content-Type": "application/json", "X-CSRF-Token": csrf_token },
          body: JSON.stringify(order)
        });
        const responseData = await response.json();

        if (response.status == 200) {
          window.location.href = '/store/purchases/' + responseData.purchase_code + '/success';
        } else {
          window.location.href = '/store/purchases/failure?purchase_code=' + responseData.purchase_code;
        }
      },      

      failing(error) {
        console.log(error);
        alert(error);
      }
    }
  })
})
