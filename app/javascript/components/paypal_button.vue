<template>
  <div :id="refer"></div>
</template>

<script>
export default {
  props: {
    cart: {
      type: Object,
      // Object or array defaults must be returned from
      // a factory function
      default: function () {
        return {
          intent: '',
          payer:  null,
          items:  []
        }
      }
    },
    refer: {
      type: String,
      required: true
    }
  },
  data() {
    const defaultPurchaseUnit = {
      reference_id: null,
      description: "lorem",
      amount: {
        currency_code: "USD",
        value: 100
      }
    };

    return {
      order: {
        intent:             'CAPTURE',
        payer:              {},
        purchase_units:     [{ ...defaultPurchaseUnit }]
      }
    }
  },
  mounted: function() {
    this.order.intent         = this.cart.intent;
    this.order.purchase_units = this.cart.items;

    if (this.cart.payer) {
      this.order.payer        = this.cart.payer;
    }

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
          createOrder: async (data, actions) => {
            const paypalOrderId = await actions.order.create(this.order);

            this.$emit('paypal-order-created', paypalOrderId);

            return paypalOrderId;
          },
          onApprove: async (data, actions) => {
            const order = await actions.order.capture();
            // for complete reference of order object: https://developer.paypal.com/docs/api/orders/v2
            this.$emit('paypal-order-approved', order);

            console.log(order);
            return order;
          },
          onError: err => {
            this.$emit('paypal-order-failed', err)
          }
        }).render(this.selectorContainer);
    }
  }
};
</script>