window.setupInputQty = function () {
    document.getElementById("add_new_category")?.addEventListener("click", function () {
        document.getElementById("input_new_category").style.display = "inherit"
    })

    // let qtyInput = document.getElementsByClassName('qty-input')[0]
    let btnsQty = document.getElementsByClassName("qty-up")
    for (let i = 0; i < btnsQty.length; i++) {
        btnsQty[i].addEventListener('click', function () {
            const dataId = btnsQty[i].getAttribute('data-id')
            let qtyInput = document.getElementById(`quantity-input-${dataId}`)
            qtyInput.value = Math.min(Number(qtyInput.value) + 1, 10)
        })
    }

    let btnsQtyDown = document.getElementsByClassName('qty-down')
    for (let i = 0; i < btnsQtyDown.length; i++) {
        btnsQtyDown[i].addEventListener('click', function () {
            const dataId = btnsQty[i].getAttribute('data-id')
            let qtyInput = document.getElementById(`quantity-input-${dataId}`)
            console.log("Data-id", dataId)
            qtyInput.value = Math.max(Number(qtyInput.value) - 1, 1)
        })
    }
}

// Set up form add to cart
window.setupInputVariation = function setupInputVariation() {

    setupFormAddToCart(window.location.pathname.split('/').pop())
    // // Get inputs hidden options for variations
    // const inputsHidden = document.getElementsByClassName("input-add-to-cart-hidden")
    //
    // for (let i = 0; i < inputsHidden.length; i++) {
    //     const name = inputsHidden[i].attributes['name'].value
    //     // Get all options for attrs have name
    //     const inputs = document.getElementsByClassName("input-add-to-cart-" + name + "-select")
    //
    //     for (let j = 0; j < inputs.length; j++) {
    //         inputs[j].addEventListener("click", function () {
    //             // Remove active from all other
    //             for (let k = 0; k < inputs.length; k++) {
    //                 if (inputs[j] !== inputs[k]) {
    //                     inputs[k].classList.remove("custom-select-active")
    //                 } else {
    //                     inputs[k].classList.toggle("custom-select-active")
    //                 }
    //             }
    //
    //             inputsHidden[i].value = inputs[j].attributes['data-value'].value
    //
    //             const values = []
    //             for (let k = 0; k < inputsHidden.length; k++) {
    //                 values.push(inputsHidden[k].value)
    //             }
    //             Rails.ajax({
    //                 url: `/products/${}/update_form_add_to_cart`,
    //                 type: "post",
    //                 beforeSend(xhr, options) {
    //                     xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
    //                     // Workaround: add options.data late to avoid Content-Type header to already being set in stone
    //                     // https://github.com/rails/rails/blob/master/actionview/app/assets/javascripts/rails-ujs/utils/ajax.coffee#L53
    //                     options.data = JSON.stringify({"values": values})
    //                     return true
    //                 },
    //                 success: function () {
    //
    //                 },
    //                 error: function () {
    //
    //                 }
    //             })
    //         })
    //     }
    // }

}
window.setupFormAddToCart = function setupFormAddToCart(productId) {
    // Get inputs hidden options for variations
    const inputsHidden = document.getElementsByClassName("input-add-to-cart-hidden")

    for (let i = 0; i < inputsHidden.length; i++) {
        const name = inputsHidden[i].attributes['name'].value
        // Get all options for attrs have name
        const inputs = document.getElementsByClassName("input-add-to-cart-" + name + "-select")

        for (let j = 0; j < inputs.length; j++) {
            inputs[j].addEventListener("click", function () {
                // Remove active from all other
                for (let k = 0; k < inputs.length; k++) {
                    if (inputs[j] !== inputs[k]) {
                        inputs[k].classList.remove("custom-select-active")
                    } else {
                        inputs[k].classList.toggle("custom-select-active")
                    }
                }

                inputsHidden[i].value = inputs[j].attributes['data-value'].value

                const values = []
                for (let k = 0; k < inputsHidden.length; k++) {
                    values.push(inputsHidden[k].value)
                }
                Rails.ajax({
                    url: `/products/${productId}/update_form_add_to_cart`,
                    type: "post",
                    beforeSend(xhr, options) {
                        xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
                        // Workaround: add options.data late to avoid Content-Type header to already being set in stone
                        // https://github.com/rails/rails/blob/master/actionview/app/assets/javascripts/rails-ujs/utils/ajax.coffee#L53
                        options.data = JSON.stringify({"values": values})
                        return true
                    },
                    success: function () {

                    },
                    error: function () {

                    }
                })
            })
        }
    }

}