// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// Bootstrap 5で、ProvidePluginを使う設定
import jquery from "jquery"
window.$ = window.jQuery = jquery
import * as bootstrap from "bootstrap"
window.bootstrap = bootstrap

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import './jquery.jscroll.min.js'
import './comment/edit_comment'
import '@fortawesome/fontawesome-free/js/all'
import '../stylesheets/application'

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.

// Webpackerに画像ファイルをインポート
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)