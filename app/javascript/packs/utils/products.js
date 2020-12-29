document.addEventListener("turbolinks:load", function () {
    document.getElementById("add_new_category")?.addEventListener("click", function () {
        document.getElementById("input_new_category").style.display = "initial"
    })

    let qtyInput = document.getElementsByClassName('qty-input')[0]
    let btnsQty = document.getElementsByClassName("qty-up")
    for (let i = 0; i < btnsQty.length; i++) {
        btnsQty[i].addEventListener('click', function () {
            qtyInput.value = Math.min(Number(qtyInput.value) + 1, 10)
        })
    }

    let btnsQtyDown = document.getElementsByClassName('qty-down')
    for (let i = 0; i < btnsQtyDown.length; i++) {
        btnsQtyDown[i].addEventListener('click', function () {
            qtyInput.value = Math.max(Number(qtyInput.value) - 1, 1)
        })
    }
})