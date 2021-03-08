document.addEventListener("turbolinks:load", function () {
    let add_category = document.getElementById("add_new_category")
    if (add_category == null) return
    add_category.addEventListener("click", function () {

    })

    const names = document.getElementsByClassName("product-attributes-name")
    const values = document.getElementsByClassName("product-attributes-value")
    const buttonSaveAttr = document.getElementById("button-save-attributes")

    buttonSaveAttr.addEventListener("click", function () {
        const form = new FormData()
        const numAttrs = Math.min(names.length, values.length)
        for (let i = 0; i < numAttrs; i++) {
            form.append("attrs[]", JSON.stringify({"name": names[i].value.trim(), "value": values[i].value.trim()}))
            console.log("Name: " + names[i].value + "- Value: " + values[i].value)
        }
        Rails.ajax({
            url: "/products/save_attributes",
            type: "post",
            data: form,
            success: function (data) {
                toastr.success("Success save attributes!")
            },
            error: function (data) {
                console.log("Save Attr Failed", data)
                toastr.warning("Something went wrong")
            }
        })
    })

    setupButtonAddAttr()

    setupProductVariationIcons()
})

function setupButtonAddAttr() {
    document.getElementById("button-add-attribute").addEventListener("click", function () {
        $("#group-container-form-add-attributes").append("                          <div class=\"flex flex-grow-1 w-full my-8 form-add-attributes\">\n" +
            "\n" +
            "                            <div class=\"control w-4/12 mt-2\">\n" +
            "                              <div>\n" +
            "                                <label class=\"text optional label text-left p-0 d-flex\" for=\"product_attribute_name\">Name</label>\n" +
            "                                <textarea class=\"product-attributes-name text optional input d-flex flex-grow-1 w-full py-2 rounded-lg font-medium bg placeholder-gray-500 text-sm focus:outline-none focus:border-gray-400 focus:bg-white placeholder-gray-800\" name=\"product_attribute[name]\"></textarea>\n" +
            "                                <!-- Attrs Visible -->\n" +
            "                                <div class=\"d-flex justify-content-start align-items-center mt-3\">\n" +
            "                                  <label class=\"d-flex justify-content-center align-items-center m-0\">\n" +
            "                                    <input type=\"checkbox\" name=\"use_paypal\">\n" +
            "                                    <span class=\"d-inline-block rounded-circle icon-size checkbox-size border-color-default border-1 checkbox-span mr-2\"></span>\n" +
            "                                  </label>\n" +
            "                                  <span class=\"f7\">Visible on product page</span>\n" +
            "                                </div>\n" +
            "                                <!-- !Attrs Visible -->\n" +
            "                                <!-- Used for variations products -->\n" +
            "                                <div class=\"d-flex justify-content-start align-items-center mt-3\">\n" +
            "                                  <label class=\"d-flex justify-content-center align-items-center m-0\">\n" +
            "                                    <input type=\"checkbox\" name=\"use_paypal\">\n" +
            "                                    <span class=\"d-inline-block rounded-circle icon-size checkbox-size border-color-default border-1 checkbox-span mr-2\"></span>\n" +
            "                                  </label>\n" +
            "                                  <span class=\"f7\">Used for variations</span>\n" +
            "                                </div>\n" +
            "                                <!-- !Used for variations products -->\n" +
            "                              </div>\n" +
            "                            </div>\n" +
            "                            <div class=\"control flex-grow-1 ml-1 mt-2 d-flex flex-column justify-content-start\">\n" +
            "                              <label class=\"text optional label text-left p-0 d-flex\" for=\"product_attribute_value\">Value\n" +
            "                                (separate by |)</label>\n" +
            "                              <textarea class=\"product-attributes-value text optional input d-flex flex-grow-1 w-full py-2 rounded-lg font-medium bg placeholder-gray-500 text-sm focus:outline-none focus:border-gray-400 focus:bg-white placeholder-gray-800\" name=\"product_attribute[value]\"></textarea>\n" +
            "                            </div>\n" +
            "                          </div>\n")
    })

}

function setupProductVariationIcons() {
    const variations = document.getElementsByClassName("container-product-variation")
    console.log("Variations", variations)
    for (let i = 0; i < variations.length; i++) {
        const variation = variations[i]
        if (!(variation instanceof HTMLElement)) return
        variation.addEventListener("click", function () {
            // variation.classList.toggle("collapse-height")
            variation.getElementsByClassName("container-product-variation-body")[0].classList.toggle("collapse-height")
        })
    }
    // $("#variation-100").on("click", function () {
    //     $("#container-product-variation-body").toggleClass('collapse-height')
    // })
}