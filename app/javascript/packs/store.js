import Vue from 'vue/dist/vue.esm'
import { unpackSDKMeta } from '@paypal/sdk-client';
import PaypalButton from '../components/paypal_button.vue';

document.addEventListener('DOMContentLoaded', () => {
  var storeList = new Vue({
    el: '#store-list', // Add the css identifier for the div that will load the paypal button
    components: {
      // Add paypal button here
      PaypalButton
    }
  })
})
