document.addEventListener("turbolinks:load", function() {

  let productImages = document.querySelector('.product-image-uploader');
  let list_image_carousel = []
  let flagVisible = false

  function handleFileSelect(evt) {
    let files = evt.target.files; // FileList object
    if (files == null) return

    console.log("Handle File..................")
    // Loop through the FileList and render image files as thumbnails.
    for (let i = 0, f; f = files[i]; i++) {

      // Only process image files.
      if (!f.type.match('image.*')) {
        continue;
      }

      let reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function(theFile) {
        return function(e) {
          // Remove active form previous added images
          list_image_carousel.forEach(element => {
            element.classList.remove('active')
            console.log("remove list name")
          })
          // Render thumbnail.
          let div = document.createElement('div');
          div.classList.add('carousel-item', 'active', 'position-relative', 'h-100')
          div.innerHTML = ['<img class="instrument-preview-thumb image-products center-inner d-block img-fluid" src="', e.target.result,
            '" title="', escape(theFile.name), '"/>'].join('');
          document.getElementById('list').insertBefore(div, null)
          list_image_carousel.push(div)
          console.log("Insert")
          if (flagVisible) return
          document.getElementById('carouselExampleControls').style.display = 'block';
        };
      })(f);
      // Read in the image file as a data URL.
      reader.readAsDataURL(f);
    }
  }

  if (productImages) {
    this.addEventListener('change', handleFileSelect, false);
  }

});


