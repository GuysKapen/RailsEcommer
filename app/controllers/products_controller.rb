# frozen_string_literal: true

# noinspection ALL
class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new edit update]
  before_action :init_product_form, only: %i[new change_product_form]

  attr_reader :product

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    @product = Product.new
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @user = current_user
    @hash_attrs = helpers.attrs_of_product_variation(@product)
  end

  # GET /products/new
  def new
    # @product = Product.new
    # @product_meta = @product.build_product_meta
    # @product_meta.build_product_advanced
    # @product_meta.build_product_inventory
    # @product_meta.build_product_linked
    # @product_meta.build_product_extra
    # @product_meta.build_product_shipping
    # @product_meta.build_product_sale_price
    # init_product
    @categories = Category.all
    @product_attr = ProductAttributesName.new

    session[:product] = @product
  end

  # GET /products/1/edit
  def edit
    @categories = Category.all
  end

  # POST /products
  # POST /products.json
  def create
    # Build New Category here

    category_attrs = params['category_name']
    @category = current_user.categories.build(name: category_attrs) unless category_attrs.nil? || category_attrs.empty?
    # Save category to get id
    if !@category.nil? && !@category.save
      errors.add(:base, 'Could not save category')
      return false
    end

    params[:product][:category_id] = @category.id unless @category.nil?
    @product = current_user.products.build(product_params)
    @product_meta = @product.build_product_meta(product_meta_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
        session.delete(:product)
      else
        format.html { render :new, notice: 'Error has been occured.' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # @return [FalseClass]
  def add_to_cart
    # Find cart if has any
    @cart = Cart.find_by(id: current_user.id)
    # If not build one
    if @cart.nil?
      @cart = current_user.build_cart
      return false unless @cart.save
    end

    # Find product cart already in cart for update quantity if user add again
    @product_cart = ProductCart.find_by(product_id: product_cart_params['product_id'])

    # If not have then add new one
    # Othewise add it quantity to 1 or quantity if have
    if @product_cart.nil?
      @product_cart = @cart.product_carts.build(product_cart_params)
    else
      @product_cart.quantity += 1
      @product_cart.cart_id = @cart.id
    end

    return false unless @product_cart.save

    # For update cart count view
    @cart_item = @cart.product_carts.count

    # Find all product carts for render cart popup
    @product_carts = ProductCart.where(cart_id: @cart.id)
    @product_carts_subtotal = 0
    @product_carts.each do |product_cart|
      @product_carts_subtotal += product_cart.product.product_meta.regular_price * product_cart.quantity
    end
    respond_to do |format|
      format.js { render 'products/response_add_to_cart_success' }
    end
  end

  def add_to_wishlist
    @wishlist = Wishlist.find_by(id: current_user.id)
    if @wishlist.nil?
      @wishlist = current_user.build_wishlist
      unless @wishlist.save
        print('Saving Wishlist Error', @wishlist.errors.full_messages)
        # self.errors.add(:base, "Could not save category")
        return false
      end
    end

    print("----------------------------------------------------------------------------------------\n")
    print("Wishlist \n", @wishlist.inspect)

    @product_wishlist = ProductCart.find_by(product_id: product_cart_params['product_id'])
    if @product_wishlist.nil?
      @product_wishlist = @cart.product_carts.build(product_cart_params)
    else
      @product_wishlist.quantity += 1
      @product_wishlist.cart_id = @product_wishlist.id
    end

    print("Product Wish list \n", @product_wishlist.inspect)

    unless @product_wishlist.save
      print('Saving Product Cart Error', @product_wishlist.errors.full_messages)
      # self.errors.add(:base, "Could not save category")
      return false
    end

    print('Saving Product Cart Error', @product_wishlist.errors.full_messages)
    respond_to do |format|
      format.js { render 'products/response_add_to_wishlist_success' }
    end
  end

  def quick_view
    print(params)
    product_id = params[:product_id]
    @product = Product.find(product_id)
    respond_to do |format|
      format.js { render 'products/response_quick_view_product' }
    end
  end

  def save_attributes
    @product_attrs = Array(ProductAttributesName.all)
    begin
      product_attr_params.each do |_, attrs|
        attrs.each do |attr|
          attr_obj = JSON.parse(attr)
          attr_name = { name: attr_obj['name'] }
          @product_attrs_name = ProductAttributesName.new(attr_name)
          attr_obj['value'].split('|').each do |value|
            attr_value = { value: value }
            @product_attrs_name.product_attributes_values.build(attr_value)
          end
          @product_attrs_name.save
          @product_attrs.push(@product_attrs_name)
        end
      end
    rescue Errno::ENOENT
      print('Error....')
    end
    respond_to do |format|
      format.js { render 'products/response_save_attr' }
    end
  end

  def create_variations_from_attrs
    @product_attrs = ProductAttributesName.all
    merge = helpers.products_cartesian(@product_attrs)
    @attrs_list_values = merge[:value]
    @attrs_list_values = @attrs_list_values
                         .map do |attrs_values|
      attrs_values.map do |value|
        ProductAttributesValue.where(value: value).first
      end
    end
    @form = params['form']
    @product = Product.new
    @attrs_list_values.length.times do
      variation = @product.product_variations.build
      print('WTF', @attrs_list_values[0].length)
      @attrs_list_values[0].length.times do
        variation.product_attributes_values.build
      end
      variation_meta = variation.build_product_meta
      variation_meta.build_product_inventory
      variation_meta.build_product_sale_price
      variation_meta.build_product_shipping
    end

    respond_to do |format|
      format.js { render 'products/response_create_variation_product' }
    end
  end

  def change_product_form
    init_product_form
    @product_type = params[:type]
    respond_to do |format|
      format.js { render 'products/response_change_product_form' }
    end
  end

  def update_form_add_to_cart
    product = Product.find_by(id: params[:id])
    post_values = params[:values]
    product.product_variations.each_with_index do |variation, index|
      values = helpers.attr_values_nocase_variation(variation)
      next unless values.sort == post_values.sort

      print('Price', variation.product_meta.regular_price)
      respond_to do |format|
        format.js do
          render 'products/response_update_form_add_to_cart',
                 locals: { regular_price: variation.product_meta.regular_price,
                           sale_price: variation.product_meta.product_sale_price&.sale_price,
                           index: index }
        end
      end
      break
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Use for build product with vari form
  def init_product_form
    @product ||= Product.new(session[:product])
    @product_meta = @product.build_product_meta
    @product_meta.build_product_advanced
    @product_meta.build_product_inventory
    @product_meta.build_product_linked
    @product_meta.build_product_extra
    @product_meta.build_product_shipping
    @product_meta.build_product_sale_price
    @categories = Category.all
    @product_attr = ProductAttributesName.new
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(
      :category_id,
      product_meta_attributes: [
        :regular_price,
        :name, :description, :tag,
        { images: [],
          product_inventory_attributes: %i[sku manage_stock stock_status sold_individually],
          product_shipping_attributes: %i[weight length width height shipping_class],
          product_linked_attributes: %i[upsells cross_sells],
          product_sale_price_attributes: %i[sale_price sale_date_start sale_date_end],
          product_advanced_attributes: %i[purchase_note enable_reviews],
          product_extra_attributes: [:product_video] }
      ],
      product_variations_attributes: [
        product_attributes_value_ids: [],
        # product_attributes_values_attributes: [product_attributes_value_ids: []],
        product_meta_attributes: [
          :regular_price,
          :name, :description, :tag,
          { images: [],
            product_inventory_attributes: %i[sku manage_stock stock_status sold_individually],
            product_shipping_attributes: %i[weight length width height shipping_class],
            product_linked_attributes: %i[upsells cross_sells],
            product_sale_price_attributes: %i[sale_price sale_date_start sale_date_end],
            product_advanced_attributes: %i[purchase_note enable_reviews],
            product_extra_attributes: [:product_video] }
        ]
      ],
      category_attributes: [:name]
    )
  end

  def product_meta_params
    params.require(:product).require(:product_meta_attributes).permit(
      :regular_price,
      :name, :description, :tag,
      { images: [],
        product_inventory_attributes: %i[sku manage_stock stock_status sold_individually],
        product_shipping_attributes: %i[weight length width height shipping_class],
        product_linked_attributes: %i[upsells cross_sells],
        product_sale_price_attributes: %i[sale_price sale_date_start sale_date_end],
        product_advanced_attributes: %i[purchase_note enable_reviews],
        product_extra_attributes: [:product_video] }
    )
  end

  def product_inventory_params
    params.require(:product).require(:product_meta_attributes).require(:product_inventory_attributes).permit(
      :sku, :stock_status, :manage_stock, :sold_individually
    )
  end

  def product_sale_price_params
    params.require(:product).require(:product_meta_attributes).require(:product_sale_price_attributes).permit(
      :sale_price, :sale_date_start, :sale_date_end
    )
  end

  def product_shipping_params
    params.require(:product).require(:product_meta_attributes).require(:product_shipping_attributes).permit(
      :weight, :length, :width, :shipping_class
    )
  end

  def product_linked_params
    params.require(:product).require(:product_meta_attributes).require(:product_linked_attributes).permit(
      :upsells, :cross_sells
    )
  end

  def product_extras_params
    params.require(:product).require(:product_meta_attributes).require(:product_extra_attributes).permit(
      :product_video
    )
  end

  def product_cart_params
    params.permit(:style, :quality, :color, :size, :product_id, :quantity)
  end

  def product_attr_params
    params.permit(name: [], value: [], attrs_list_values: [], attrs: [])
  end

  def product_variation_meta_params
    params.require(:product).require(:product_variation_meta).permit(
      :regular_price, { product_shipping_attributes: %i[width height length weight shipping_class],
                        product_sale_price_attributes: %i[sale_price sale_date_start sale_date_end],
                        product_inventory_attributes: %i[sku stock_status manage_stock sold_individually] }
    )
  end

  # def product_variation_meta_shipping_params
  #   params.require(:product).require(:product_variation_meta).require(:variation_meta_shipping).permit(
  #     %i[width height length weight shipping_class]
  #   )
  # end
end
