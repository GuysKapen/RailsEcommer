// noinspection JSAssignmentUsedAsCondition
document.addEventListener("turbolinks:load", function () {

    let productImages = document.querySelector('.product-image-uploader');
    let listsIndicators = []

    function handleFileSelect(evt) {
        let files = evt.target.files;// FileList object
        if (files == null) return

        const carouselIndicators = document.getElementById("product-image-upload-preview-carousel-indicators")
        const carouselContainer = document.getElementById("product-image-upload-preview-carousel")
        // Loop through the FileList and render image files as thumbnails.
        // noinspection JSAssignmentUsedAsCondition
        for (let i = 0, f; f = files[i]; i++) {

            // Only process image files.
            if (!f.type.match('image.*')) {
                continue;
            }

            listsIndicators.push(`
                    <li class="inline-block mr-3">
                        <label for="carousel-${i + 1}"
                           class="carousel-bullet cursor-pointer block text-4xl text-white hover:text-blue-700">•</label>
                    </li>`)

            let reader = new FileReader();

            // Closure to capture the file information.
            reader.onload = (function (theFile) {
                return function (e) {

                    const img = ['<img class="img-fluid center-inner w-full h-100 max-h-100 object-contain mix-blend-darken" src="', e.target.result, '" title="', escape(theFile.name), '"/>'].join('');
                    const previous = i + 1 - 1 < 1 ? files.length : i + 1 - 1
                    const next = i + 1 + 1 > files.length ? 1 : i + 1 + 1
                    const enumerator = i + 1
                    $(carouselContainer).append(`
                    <div>
                        <input class="carousel-open" type="radio" id="carousel-${enumerator}" name="carousel" aria-hidden="true" hidden="" ${enumerator === 1 ? 'checked=checked' : ''}>
                        <div class="carousel-item absolute opacity-0 bg-product-img" style="height: 500px;">${img}</div>
                        <label for="carousel-${previous}"
                               class="control-${enumerator} w-10 h-10 ml-2 md:ml-10 absolute cursor-pointer hidden font-bold text-black hover:text-white rounded-full bg-white hover:bg-blue-700 leading-tight text-center z-10 inset-y-0 left-0 my-auto"><i
                          class="fas fa-angle-left mt-3"></i></label>
                        <label for="carousel-${next}"
                               class="next control-${enumerator} w-10 h-10 mr-2 md:mr-10 absolute cursor-pointer hidden font-bold text-black hover:text-white rounded-full bg-white hover:bg-blue-700 leading-tight text-center z-10 inset-y-0 right-0 my-auto"><i
                          class="fas fa-angle-right mt-3"></i></label>
                    </div>`)

                };
            })(f);
            // Read in the image file as a data URL.
            reader.readAsDataURL(f);
        }
        console.log(listsIndicators)
        carouselIndicators.innerHTML = listsIndicators.join('');
    }

    if (productImages) {
        // this.addEventListener('change', handleFileSelect, false);
        productImages.addEventListener('change', handleFileSelect, false)
    }

});


