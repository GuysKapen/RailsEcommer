class ContactController < ApplicationController
  def index
    @product = Product.all[0]
  end
end
