var CsrfHelper = {
    methods:{

      findCsrfToken() {
        let csrf_token_dom = document.querySelector('meta[name="csrf-token"]');
        let csrf_token = "";

        if (csrf_token_dom) {
          csrf_token = csrf_token_dom.content;
        }

        return csrf_token;
      }

    }
};
export default CsrfHelper;