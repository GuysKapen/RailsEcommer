import {setupTap} from "../utils/tabs";

require("./add_to_cart")
require("./product_new")
require("./product_show_bottom_dock_view")
require("./view_cart")
require('./product_show')

document.addEventListener("turbolinks:load", function () {
    setupFilterPrice()
    setupProductSort()

})

function setupFilterPrice() {
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

}

function setupProductSort() {
    // const map = {'h2l'}
    const selectProductType = document.getElementById("select-product-sort")
    if (selectProductType == null) return

    const $grid = $(".grid-product-items").isotope({
        getSortData: {
            price: function (itemElem) { // function
                const price = $(itemElem).find('.product-price').text();
                return Number(price.split("-")[0].replace(/[^0-9.-]+/g,""))
            }
        },
        itemSelector: '.product-card',
        // layoutMode: 'fitRows',
        percentPosition: true,
        resizesContainer: true,
        resizable: true,
        masonry: {
            columnWidth: '.grid-sizer',
        },
        masonryHorizontal: {
            rowHeight: 800
        }
    });

    $(selectProductType).on("change", function () {
        console.log("Select product type change", selectProductType.selectedIndex, selectProductType.value)
        $grid.isotope({sortBy: 'price', sortAscending: selectProductType.value === 'price-asc'})
    })

}
