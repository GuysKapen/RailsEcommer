# frozen_string_literal: true
module ApplicationHelper
  def product_first_img(product)
    product.images[0].nil? ? 'shoes.jpg' : product.images[0].url
  end

  def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      type = 'success' if type == 'notice'
      type = 'error' if type == 'alert'
      text = "<script>toastr.#{type}('#{message}', '', { closeButton: true, progressBar: true })</script>"
      flash_messages << text.html_safe if message
    end.join("\n").html_safe
  end

  def cart_items
    ProductCart.count
  end
end
