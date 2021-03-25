// noinspection JSAssignmentUsedAsCondition
document.addEventListener("turbolinks:load", function() {

  let productImages = document.querySelector('.product-image-uploader');
  let imagesCarousel = []
  let flagVisible = false
  let selectedFiles = []
  let listsIndicators = []

  function handleFileSelect(evt) {
    let files = evt.target.files;// FileList object
    selectedFiles.push(...files)
    console.log("Files Selected", selectedFiles)
    if (files == null) return

    const carouselIndicators = document.getElementById("product-image-upload-preview-carousel-indicators")
    // Loop through the FileList and render image files as thumbnails.
    // noinspection JSAssignmentUsedAsCondition
    for (let i = 0, f; f = files[i]; i++) {

      // Only process image files.
      if (!f.type.match('image.*')) {
        continue;
      }

      if (i === 0) {
        listsIndicators.push(`<li data-target="#carouselExampleIndicators" class="active" data-slide-to=${i}></li>`)
      } else {
        listsIndicators.push(`<li data-target="#carouselExampleIndicators" data-slide-to=${i}></li>`)
      }

      let reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function(theFile) {
        return function(e) {
          // Remove active form previous added images
          imagesCarousel.forEach((element) => {
            element.classList.remove('active')
            console.log("remove list name")
          })
          // Render thumbnail.
          let div = document.createElement('div');
          div.classList.add('carousel-item', 'active', 'position-relative', 'h-100')
          div.innerHTML = ['<img class="instrument-preview-thumb image-products center-inner d-block img-fluid" src="', e.target.result,
            '" title="', escape(theFile.name), '"/>'].join('');
          document.getElementById('list').insertBefore(div, null)
          imagesCarousel.push(div)
          console.log("Insert")
          if (flagVisible) return
          document.getElementById('carouselExampleControls').style.display = 'block';
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

  // $("#new_product").on("submit", function (e) {
  //   e.preventDefault()
  //   const formData = new FormData(this)
  //   formData.delete("product[product_meta_attributes][images][]")
  //   // formData.set("images[]", selectedFiles)
  //   for (let i = 0; i < selectedFiles.length; i++) {
  //     formData.append("product[product_meta_attributes][images][]", selectedFiles[i])
  //   }
  //
  //   Rails.ajax({
  //     url: "/products/",
  //     type: "post",
  //     data: formData,
  //     success: function(data) {},
  //     error: function(data) {}
  //   })
  //   // console.log("Form values", formData.values())
  //   // this.from = formData
  // })

});


