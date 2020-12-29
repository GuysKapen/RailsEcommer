document.addEventListener("turbolinks:load", function () {
    setupInputStyleProduct();
    setupInputQualityProduct();
    setupInputColorProduct();
    setupInputSizeProduct();
});

function setupInputStyleProduct() {
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

function setupInputQualityProduct() {
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

function setupInputColorProduct() {
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

function setupInputSizeProduct() {
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