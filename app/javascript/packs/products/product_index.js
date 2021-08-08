require("./add_to_cart")
require("./product_new")
require("./product_show_bottom_dock_view")
require("./view_cart")
require('./product_show')
require('./shopping_cart')

document.addEventListener("turbolinks:load", function () {
    setupSearchOptions()
})

function setupSearchOptions() {
    /// SORT
    let sortAsc = false;
    const selectProductType = document.getElementById("select-product-sort")
    if (selectProductType != null) {
        let $grid = $(".grid-product-items").isotope({
            getSortData: {
                price: function (itemElem) { // function
                    const price = $(itemElem).find('.product-price').text();
                    return Number(price.split("-")[0].replace(/[^0-9.-]+/g, ""))
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
            sortAsc = selectProductType.value === 'price-asc'
            $grid.isotope({sortBy: 'price', sortAscending: sortAsc})
        })
    }

    /// FILTER
    const btnFilter = document.getElementById("filter-btn")
    if (btnFilter != null) {
        btnFilter.addEventListener('click', function () {
            const minPrice = document.getElementById("min")
            const maxPrice = document.getElementById("max")

            // noinspection DuplicatedCode
            $grid = $(".grid-product-items").isotope({
                getSortData: {
                    price: function (itemElem) { // function
                        const price = $(itemElem).find('.product-price').text();
                        return Number(price.split("-")[0].replace(/[^0-9.-]+/g, ""))
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

            $grid.isotope({
                filter: function () { // function
                    const priceText = $(this).find('.product-price').text();
                    const price = (Number(priceText.split("-")[0].replace(/[^0-9.-]+/g, "")));
                    return price >= minPrice.value && price <= maxPrice.value
                }, sortAscending: sortAsc
            })

        })
    }

    /// SEARCH
    const btnSearch = document.getElementById("search-product-btn")
    if (btnSearch != null) {
        btnSearch.addEventListener('click', function () {
            const searchName = document.getElementById("input-product-search").value.toLowerCase()

            // noinspection DuplicatedCode
            $grid = $(".grid-product-items").isotope({
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

            $grid.isotope({
                filter: function () { // function
                    const name = $(this).find('.product-name').text().toLowerCase();
                    if (searchName.trim().length === 0) return true
                    return name.includes(searchName) || searchName.includes(name);
                }, sortAscending: sortAsc
            })

        })
    }
}