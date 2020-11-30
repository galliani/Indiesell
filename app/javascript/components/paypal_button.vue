<template>
  <div :id="refer"></div>
</template>

<script>
// MIXINS
// For grabbing the CSRF token to be used to submit to internal API endpoint
import CsrfHelper from '../mixins/csrf_helper.js';
export default {
  mixins:[CsrfHelper],
  props: {
    refer: {
      type: String,
      required: true
    },
    // Pass the product attributes to be used here
    currencyCode: {
      type: String,
      required: false,
      default() {
        return 'USD'
      }
    },
    priceStr: {
      type: String, // should be like "100.00"
      required: true
    },
    productDescription: {
      type: String,
      required: true
    },
    productId: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      // Defaults for the order that will be sent to Paypal
      order: {
        description: "",
        amount: {
          currency_code: "",
          value: 0
        }
      }
    };
  },
  mounted: function() {
    // These 3 lines are what we add here
    this.order.description          = this.productDescription;
    this.order.amount.currency_code = this.currencyCode;
    this.order.amount.value         = Number(this.priceStr);

    // IMPORTANT: to cause the paypal button be loeaded and rendered
    this.setLoaded();
  },
  computed: {
    selectorContainer() {
      return '#' + this.refer;
    }
  },
  methods: {
    setLoaded: function() {
      paypal
        .Buttons({
          createOrder: (data, actions) => {
            return actions.order.create({
              purchase_units: [
                this.order
              ]
            });
          },
          onApprove: async (data, actions) => {
            const order = await actions.order.capture();
            // for complete reference of order object: https://developer.paypal.com/docs/api/orders/v2
            const response = await fetch('/api/v1/store/paypal_purchases', {
              method:   'POST',
              headers:  {
                "Content-Type": "application/json",
                "X-CSRF-Token": this.findCsrfToken() // taken from the mixins/csrf_helper.js
              },
              body:     JSON.stringify(
                {
                  price_cents:    this.priceStr,
                  price_currency: this.currencyCode,
                  product_id:     this.productId,
                  token:          order.orderID,
                  customer_id:    order.payer.payer_id,
                  customer_email: order.payer.email_address,
                  is_successful:  order.status === 'COMPLETED'
                }
              )
            });
            const responseData = await response.json();
            if (response.status == 200) {
              window.location.href = '/store/purchases/' + responseData.purchase_code + '/success';
            } else {
              window.location.href = '/store/purchases/failure?purchase_code=' + responseData.purchase_code;
            }
          },
          onError: err => {
            console.log(err);
          }
        }).render(this.selectorContainer);
    }
  }
};
</script>