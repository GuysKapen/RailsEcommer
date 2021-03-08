document.addEventListener("turbolinks:load", function () {
    document.getElementById("cart-items")?.addEventListener("click", function () {
        Rails.ajax({
            url: "/cart/view_cart",
            type: "post",
            data: "",
            success: function(data) {},
            error: function(data) {}
        })
    })

    document.getElementById("add-variation")?.addEventListener("click", function () {
        Rails.ajax({
            url: "/products/create_variations_from_attrs",
            type: "post"
        })
    })
})