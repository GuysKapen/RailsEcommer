document.addEventListener("turbolinks:load", function () {
    for (let element of document.getElementsByClassName("checkbox-section")) {
        let name = element.attributes['data-checkbox'].value
        let elementSection = document.getElementById(name);
        console.log("Fuck", elementSection)
        element.addEventListener("change", function (e) {
            console.log("WTf", e.target.checked)

            if (e.target.checked) {
                elementSection.style['display'] = 'inherit'
            } else {
                elementSection.style['display'] = 'none'
            }
        })
    }
})

