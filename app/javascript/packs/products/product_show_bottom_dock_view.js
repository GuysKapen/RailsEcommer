function isInViewport(element) {
    const rect = element.getBoundingClientRect();
    console.log("Rect bottom", rect.bottom)
    console.log("Height", window.innerHeight)
    return (
        rect.top >= 0 &&
        rect.left >= 0 &&
        rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
        rect.right <= (window.innerWidth || document.documentElement.clientWidth)
    );
}

function isAboveViewport(element) {
    const rect = element.getBoundingClientRect();
    return rect.bottom > 0
}

document.addEventListener("turbolinks:load", function () {
    const formAddToCart = document.querySelector("#form-add-to-cart")
    const dockAddToCart = document.querySelector("#dock-add-to-cart")
    if (formAddToCart == null || dockAddToCart == null) return
    const initHeight = dockAddToCart.clientHeight;
    const initWidth = dockAddToCart.clientWidth;
    window.addEventListener('scroll', function () {
        if (isAboveViewport(formAddToCart)) {
            dockAddToCart.style.left = "-100%";
            // dockAddToCart.style.cssText = 'opacity: 1';
            // dockAddToCart.style.cssText = 'display:flex !important';

        } else {
           dockAddToCart.style.left = "0"
            // dockAddToCart.style.cssText = 'opacity: 0';
            // dockAddToCart.style.cssText = 'display:none !important';

        }
    })
})

