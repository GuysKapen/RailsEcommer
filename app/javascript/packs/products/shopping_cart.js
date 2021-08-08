document.addEventListener("turbolinks:load", function () {
    let btnsQty = document.getElementsByClassName("product-cart-qty-up")

    for (let i = 0; i < btnsQty.length; i++) {
        btnsQty[i].addEventListener('click', function () {
            const dataId = btnsQty[i].getAttribute('data-id')
            let qtyInput = document.getElementById(`product-cart-quantity-input-${dataId}`)
            const qty = Math.min(Number(qtyInput.value) + 1, 10)
            qtyInput && (qtyInput.value = qty)

            Rails.ajax({
                url: "/cart/modify_qty",
                type: "post",
                data: {'product-cart-id': dataId, 'qty': qty},
                success: function (data) {
                },
                error: function (data) {
                },
                beforeSend(xhr, options) {
                    xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
                    // Workaround: add options.data late to avoid Content-Type header to already being set in stone
                    // https://github.com/rails/rails/blob/master/actionview/app/assets/javascripts/rails-ujs/utils/ajax.coffee#L53
                    options.data = JSON.stringify({'product-cart-id': dataId, 'qty': qty})
                    return true
                }
            })

        })
    }

    let btnsQtyDown = document.getElementsByClassName('product-cart-qty-down')
    for (let i = 0; i < btnsQtyDown.length; i++) {
        btnsQtyDown[i].addEventListener('click', function () {
            const dataId = btnsQty[i].getAttribute('data-id')
            let qtyInput = document.getElementById(`product-cart-quantity-input-${dataId}`)
            const qty = Math.max(Number(qtyInput.value) - 1, 1)
            qtyInput && (qtyInput.value = qty)

            Rails.ajax({
                url: "/cart/modify_qty",
                type: "post",
                data: {'product-cart-id': dataId, 'qty': qty},
                success: function (data) {
                },
                error: function (data) {
                },
                beforeSend(xhr, options) {
                    xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
                    // Workaround: add options.data late to avoid Content-Type header to already being set in stone
                    // https://github.com/rails/rails/blob/master/actionview/app/assets/javascripts/rails-ujs/utils/ajax.coffee#L53
                    options.data = JSON.stringify({'product-cart-id': dataId, 'qty': qty})
                    return true
                }
            })
        })
    }

})
