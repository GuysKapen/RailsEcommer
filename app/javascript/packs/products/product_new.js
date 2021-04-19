import {setupTap} from "../utils/tabs";

document.addEventListener("turbolinks:load", function () {

    setupProductCategory()

    setupProductAttributes();

    setupButtonAddAttr()

    setupProductVariationIcons()

    setupProductType()

    setupProductFileUpload()
})

function setupProductAttributes() {
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
}

function setupProductCategory() {
    let add_category = document.getElementById("add_new_category")
    if (add_category == null) return
    add_category.addEventListener("click", function () {

    })
}

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

function setupProductType() {
    const selectProductType = document.getElementById("select-product-type")
    const buttonChangeProductType = document.getElementById("button-change-product-type")

    $(selectProductType).on("change", function (e, data) {
        console.log("Select product type change", selectProductType.selectedIndex, data)
    })

    buttonChangeProductType.addEventListener("click", function () {
        console.log("Type", selectProductType.value)
        Rails.ajax({
            url: "/products/change_product_form",
            type: "post",
            data: {'type': selectProductType.value},
            success: function () {
                console.log("Setup Tab....")
                setupTap()
                document.setupCustomSelect()
                setupProductVariation()
                setupProductAttributes()
                setupButtonAddAttr()
            },
            beforeSend(xhr, options) {
                xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
                // Workaround: add options.data late to avoid Content-Type header to already being set in stone
                // https://github.com/rails/rails/blob/master/actionview/app/assets/javascripts/rails-ujs/utils/ajax.coffee#L53
                options.data = JSON.stringify({'type': selectProductType.value})
                return true
            },
        })
    })

}

function setupProductVariation() {
    const selectProductType = document.getElementById("select-product-variation-create")
    const buttonAddVariation = document.getElementById("button-add-variation")

    buttonAddVariation?.addEventListener("click", function () {
        console.log("Type Variation", selectProductType.value)
        const type = selectProductType.value.toString().toLowerCase()
        if (type === "add variation") {

        } else {
            Rails.ajax({
                url: "/products/create_variations_from_attrs",
                type: "post",
                data: {'type': selectProductType.value},
                success: function () {
                    setupProductFileUpload()
                    // console.log("Setup Tab....")
                    // setupTap()
                    // document.setupCustomSelect()

                },
            })
        }

    })

}

function setupProductFileUpload() {
    const buttonUploads = document.getElementsByClassName("button-file-upload-data-id")
    for (let i = 0; i < buttonUploads.length; i++) {
        const button = buttonUploads[i]
        button.addEventListener('click', function () {
            const id = button.attributes['data-id'].value
            console.log("Id", id)
            // document.getElementById(`input-file-upload-${index}`)
            $(`#input-file-upload-${id}`).show().focus().click().hide().on('change', function (e) {
                handleFileInputVariationChange(button, e.target.files[0])
            })
        })
    }
}

function handleFileInputVariationChange(container, file) {
    const reader = new FileReader()
    // Closure to capture the file information.
    reader.onload = (function(theFile) {
        return function(e) {
            container.innerHTML = ['<img class="w-24 cursor-pointer" src="', e.target.result,
                '" title="', escape(theFile.name), '"/>'].join('');
        };
    })(file);
    // Read in the image file as a data URL.
    reader.readAsDataURL(file);
}