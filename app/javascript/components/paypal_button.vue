<template>
  <div ref="paypal"></div>
</template>

<script>
export default {
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
    priceCents: {
      type: String,
      required: true
    },
    productDescription: {
      type: String,
      required: true
    },    
  },
  data() {
    return {
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
    const script = document.createElement("script");
    script.src = `https://www.paypal.com/sdk/js?client-id=${this.clientId}`;
    script.addEventListener("load", this.setLoaded);
    document.body.appendChild(script);

    this.order.description          = this.productDescription;
    this.order.amount.currency_code = this.currencyCode;
    this.order.amount.value         = Number(this.priceCents);
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