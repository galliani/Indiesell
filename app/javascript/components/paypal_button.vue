<template>
  <div :id="refer"></div>
</template>

<script>
export default {
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
          },
          onError: err => {
            console.log(err);
          }
        }).render(this.selectorContainer);
    }
  }
};
</script>