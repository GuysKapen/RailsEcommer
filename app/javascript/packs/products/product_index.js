require("./add_to_cart")
require("./product_new")
require("./product_show_bottom_dock_view")
require("./view_cart")
document.addEventListener("turbolinks:load", function () {
    const btnFilter = document.getElementById("filter-btn")
    if (btnFilter == null) return
    btnFilter.addEventListener('click', function () {
        const minPrice = document.getElementById("min")
        const maxPrice = document.getElementById("max")

        Rails.ajax({
            url: "/products/filter_by_price",
            type: "post",
            beforeSend(xhr, options) {
                xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
                // Workaround: add options.data late to avoid Content-Type header to already being set in stone
                // https://github.com/rails/rails/blob/master/actionview/app/assets/javascripts/rails-ujs/utils/ajax.coffee#L53
                options.data = JSON.stringify({'min': minPrice.value, 'max': maxPrice.value})
                return true
            },
        })
    })
})