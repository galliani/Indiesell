<template>
  <div ref="paypal"></div>
</template>

<script>
export default {
  props: {
    clientId: {
      type: String,
      required: false,
      default() {
        return ''
      }
    }         
  },
  data() {
    return {
      order: {
        description: "Buy thing",
        amount: {
          currency_code: "USD",
          value: 1000
        }
      }
    };
  },
  mounted: function() {
    const script = document.createElement("script");
    script.src = `https://www.paypal.com/sdk/js?client-id=${this.clientId}`;
    script.addEventListener("load", this.setLoaded);
    document.body.appendChild(script);
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
            // ajax request
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