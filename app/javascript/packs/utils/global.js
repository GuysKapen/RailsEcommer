require('./chart')
require('./suggestags')
require('./setup')
require("./custom_select")
require("./products")
require("./image_preview")
require("./tabs")
require("./checkbox_section")
require("./min_max_slider")
require("./rating")

document.addEventListener("turbolinks:load", function () {

  const notification = document.querySelector(".global-notification");

  if (notification) {
    window.setTimeout(function () {
      notification.style.display = "none";
    }, 4000);
  }

});

