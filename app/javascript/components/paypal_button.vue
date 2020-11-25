<template>
  <div ref="paypal"></div>
</template>

<script>
// MIXINS
// For grabbing the CSRF token to be used to submit to internal API endpoint
import CsrfHelper from '../mixins/csrf_helper.js';

export default {
  mixins:[CsrfHelper],
  props: {
    currencyCode: {
      type: String,
      required: false,
      default() {
        return 'USD'
      }
    },    
    clientId: {
      type: String,
      required: false,
      default() {
        return ''
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
      order: {
        description: "",
        amount: {
          currency_code: "USD",
          value: 0
        }
      }
    };
  },
  mounted: function() {
    const script = document.createElement("script");
    script.src = `https://www.paypal.com/sdk/js?client-id=${this.clientId}`;
    script.addEventListener("load", this.setLoaded);
    document.body.appendChild(script);

    this.order.description          = this.productDescription;
    this.order.amount.currency_code = this.currencyCode;
    this.order.amount.value         = Number(this.priceStr);
  },
  methods: {
    setLoaded: function() {
      window.paypal
        .Buttons({
          createOrder: (data, actions) => {
            return actions.order.create({
              purchase_units: [this.order]
            });
          },
          onApprove: async (data, actions) => {
            const order = await actions.order.capture();
            // for complete reference of order object: https://developer.paypal.com/docs/api/orders/v2

            const response = await fetch('/api/v1/store/paypal_purchases', {
              method:   'POST',
              headers:  {
                "Content-Type": "application/json",
                "X-CSRF-Token": this.findCsrfToken() // taken from the packs/store.js
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
        })
        .render(this.$refs.paypal);
    }
  }
};
</script>