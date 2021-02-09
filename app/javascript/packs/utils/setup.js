window.setupInputQty = function () {
    document.getElementById("add_new_category")?.addEventListener("click", function () {
        console.log("Click")
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

window.setupInputStyleProduct = function () {
    let input_style = document.getElementById("input-style-add-to-cart");
    if (input_style == null) return
    let input_style_select = document.getElementsByClassName("input-add-to-cart-style-select");
    for (let i = 0; i < input_style_select.length; i++) {
        input_style_select[i].addEventListener("click", function () {
            for (let j = 0; j < input_style_select.length; j++) {
                if (input_style_select[i] !== input_style_select[j]) {
                    input_style_select[j].classList.remove("custom-select-active")
                } else {
                    input_style_select[j].classList.toggle("custom-select-active")
                }
            }

            input_style.value = input_style_select[i].attributes['data-style'].value
            console.log("Style Input", input_style_select[i].attributes['data-style'].value)
        })
    }
}

window.setupInputQualityProduct = function () {
    let input_quality = document.getElementById("input-quality-add-to-cart");
    if (input_quality == null) return
    let input_style_select = document.getElementsByClassName("input-add-to-cart-quality-select");
    for (let i = 0; i < input_style_select.length; i++) {
        input_style_select[i].addEventListener("click", function () {
            for (let j = 0; j < input_style_select.length; j++) {
                if (input_style_select[i] !== input_style_select[j]) {
                    input_style_select[j].classList.remove("custom-select-active")
                } else {
                    input_style_select[j].classList.toggle("custom-select-active")
                }
            }

            input_quality.value = input_style_select[i].attributes['data-quality'].value
            console.log("Style Input", input_style_select[i].attributes['data-quality'].value)
        })
    }
}

window.setupInputColorProduct = function () {
    let input_color = document.getElementById("input-color-add-to-cart");
    if (input_color == null) return
    let input_style_select = document.getElementsByClassName("input-add-to-cart-color-select");
    for (let i = 0; i < input_style_select.length; i++) {
        input_style_select[i].addEventListener("click", function () {
            for (let j = 0; j < input_style_select.length; j++) {
                if (input_style_select[i] !== input_style_select[j]) {
                    input_style_select[j].classList.remove("custom-select-active")
                } else {
                    input_style_select[j].classList.toggle("custom-select-active")
                }
            }

            input_color.value = input_style_select[i].attributes['data-color'].value
            console.log("Style Input", input_style_select[i].attributes['data-color'].value)
        })
    }
}

window.setupInputSizeProduct = function () {
    let input_size = document.getElementById("input-size-add-to-cart");
    if (input_size == null) return
    let input_style_select = document.getElementsByClassName("input-add-to-cart-size-select");
    for (let i = 0; i < input_style_select.length; i++) {
        input_style_select[i].addEventListener("click", function () {

            for (let j = 0; j < input_style_select.length; j++) {
                if (input_style_select[i] !== input_style_select[j]) {
                    input_style_select[j].classList.remove("custom-select-active")
                } else {
                    input_style_select[j].classList.toggle("custom-select-active")
                }
            }

            input_size.value = input_style_select[i].attributes['data-size'].value
            console.log("Style Input", input_style_select[i].attributes['data-size'].value)
        })
    }
}