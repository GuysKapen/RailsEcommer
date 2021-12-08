# frozen_string_literal: true
module ApplicationHelper
  def product_first_img(product)
    if product.product_meta.images.blank?
      first_image = product.product_variations.map { |it| it.product_meta.images }.flatten[0]
      return first_image.nil? ? 'shoes.jpg' : first_image.url
    end
    product.product_meta.images[0].nil? ? 'shoes.jpg' : product.product_meta.images[0].url
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
    if current_user
      current_user.cart&.product_carts&.size || 0
    else
      0
    end
  end

  def cart_info
    new(CartView())
  end
end
