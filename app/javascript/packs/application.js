// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_tree .
//= require toastr

// require("jquery3")
// require("popper")
// require("bootstrap-sprockets")
// require("@rails/ujs").start()z
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("./utils/global")
require("./products/product_index")

require("toastr")

import toastr from 'toastr';
import Rails from "@rails/ujs";

Rails.start()
window.Rails = Rails;
global.toastr = toastr;

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
