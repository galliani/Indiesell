const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

// We need this append Provide
const webpack = require('webpack')
// Add an ProvidePlugin
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}))

environment.loaders.prepend('vue', vue)
// https://stackoverflow.com/questions/50473630/rails-webpacker-vue-you-are-using-the-runtime-only-build-of-vue-where-the/52140906
// This line below here is for solving the problem of "using the runtime-only build of Vue where the template compiler is not available"
// So that we can do ```import Vue from "vue";``` on packs/application.js
environment.config.resolve.alias = { 'vue$': 'vue/dist/vue.esm.js' }; // <- add alias

module.exports = environment