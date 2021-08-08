# frozen_string_literal: true

# noinspection ALL
class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new edit update]
  before_action :init_product_form, only: %i[new change_product_form]
  # before_action :fix_params, only: %i[create update]

  attr_reader :product

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    @product = Product.new
    @products_view_sale = Product
                          .joins(product_meta: [:product_sale_price])
                          .where('sale_date_start < ?', 0.day.ago)
                          .map { |product| ProductView.new(product) }
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @user = current_user
    @comment = Comment.new
    @reply = Reply.new
    @comments = @product.comments
    @product_upsells = @product.product_upsells
    @hash_attrs = helpers.attrs_of_product_variation(@product)
  end

  # GET /products/new
  def new
    @products = Product.all
    init_product_form
    @categories = Category.all
    @product_attr = ProductAttributesName.new
    gon.product_names = @products.map(&:name)
    gon.product_ids = @products.map(&:id)

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

    # Modify params before build product to have affect
    upsell_ids_string = params[:product][:product_meta_attributes][:product_linked_attributes][:product_upsell_ids_string]
    cross_sell_ids_string = params[:product][:product_meta_attributes][:product_linked_attributes][:product_cross_sell_ids_string]

    upsell_ids = []
    upsell_ids_string.split(',').each do |upsell_id|
      upsell_ids << upsell_id.to_i
    end
    params[:product][:product_meta_attributes][:product_linked_attributes][:product_upsell_ids] = upsell_ids

    cross_sell_ids = []
    cross_sell_ids_string.split(',').each do |cross_sell_id|
      cross_sell_ids << cross_sell_id.to_i
    end
    params[:product][:product_meta_attributes][:product_linked_attributes][:product_cross_sell_ids] = cross_sell_ids

    @product = current_user.products.build(product_params)
    # merge time and date into timestamp
    sale_price = @product.product_meta.product_sale_price
    unless sale_price.nil? && sale_price.sale_date_start.nil? && sale_price.sale_date_start.nil?
      time_start = Time.zone.parse(sale_price.sale_date_start_time)
      sale_price.sale_date_start = Time.zone.parse("#{sale_price.sale_date_start.strftime('%F')} #{time_start.strftime('%T')}")

      time_end = Time.zone.parse(sale_price.sale_date_end_time)
      sale_price.sale_date_end = Time.zone.parse("#{sale_price.sale_date_start.strftime('%F')} #{time_end.strftime('%T')}")
    end

    unless @product.product_variations.blank?
      @product.product_variations.each do |variation|
        sale_price = variation.product_meta.product_sale_price
        next if sale_price.nil?

        time_start = Time.zone.parse(sale_price.sale_date_start_time)
        sale_price.sale_date_start = Time.zone.parse("#{sale_price.sale_date_start.strftime('%F')} #{time_start.strftime('%T')}")

        time_end = Time.zone.parse(sale_price.sale_date_end_time)
        sale_price.sale_date_end = Time.zone.parse("#{sale_price.sale_date_end.strftime('%F')} #{time_end.strftime('%T')}")
      end
    end

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
    @cart = Cart.find_by(user_id: current_user.id)
    # If not build one
    if @cart.nil?
      @cart = current_user.build_cart
      return false unless @cart.save
    end

    # Find product cart already in cart for update quantity if user add again
    product_for_cart = Product.find_by(id: product_cart_params['product_id']) || ProductVariation.find_by(id: product_cart_params['product_id'])
    # product_cart = ProductCart.find_by(product_id: product_cart_params['product_id'])
    product_cart = @cart.product_carts.where(product_id: product_cart_params['product_id']).first
    # If not have then add new one
    # Othewise add it quantity to 1 or quantity if have
    if product_cart.nil?
      product_cart = @cart.product_carts.build(product_cart_params)
      product_cart = product_for_cart.product_carts.build(product_cart.as_json)
    else
      product_cart.quantity += 1
      # product_cart.cart_id = @cart.id
    end

    print('Product cart', product_cart.inspect)

    unless product_cart.save
      respond_to do |format|
        format.js do
          render 'products/response_show_message',
                 locals: { message: 'Could not save product cart in cart', success: false }
        end
      end
      return false
    end

    @cart = current_user.cart
    # For update cart count view
    @cart_item = @cart.product_carts.count

    # Find all product carts for render cart popup
    @product_carts = @cart.product_carts
    @product_carts_subtotal = 0
    @product_carts.each do |product_cart_in_cart|
      @product_carts_subtotal += (product_cart_in_cart.product.product_meta.product_detail.regular_price || 0) * product_cart_in_cart.quantity
    end
    respond_to do |format|
      format.js { render 'products/response_add_to_cart_success' }
    end
  end

  def add_to_wishlist
    @wishlist = Wishlist.find_by(user_id: current_user.id)
    if @wishlist.nil?
      @wishlist = current_user.build_wishlist
      return false unless @wishlist.save
    end

    product_for_wishlist = Product.find_by(id: product_cart_params['product_id'])
    product_wishlist = @wishlist.product_carts.filter { |it| it.id = product_cart_params['product_id'] }.first
    if product_wishlist.nil?
      product_wishlist = @wishlist.product_carts.build(product_cart_params)
      product_wishlist = product_for_wishlist.product_carts.build(product_wishlist.as_json)

    else
      product_wishlist.quantity += 1
      product_wishlist.product_cart_container_id = product_wishlist.id
    end

    return false unless product_wishlist.save

    respond_to do |format|
      format.js { render 'products/response_add_to_wishlist_success' }
    end
  end

  def quick_view
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
      variation_meta = variation.build_product_meta
      variation_meta.build_product_inventory
      variation_meta.build_product_sale_price
      variation_meta.build_product_shipping
      variation_meta.build_product_detail
      @attrs_list_values[0].length.times do
        variation.product_attributes_values.build
      end
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

      respond_to do |format|
        format.js do
          render 'products/response_update_form_add_to_cart',
                 locals: {
                   regular_price: variation.product_meta.product_detail.regular_price,
                   sale_price: variation.product_meta.product_sale_price&.sale_price,
                   index: index,
                   product_id: variation.id
                 }
        end
      end
      break
    end
  end

  def add_attributes_input
    respond_to do |format|
      format.js { render 'products/response_add_attributes_input' }
    end
  end

  def filter_by_price
    min_price = params[:min].to_f
    max_price = params[:max].to_f
    @products_filtered = Product.all.filter do |it|
      !it.price_include_variation_min.nil? && it.price_include_variation_min >= min_price && it.price_include_variation_max <= max_price
    end

    respond_to do |format|
      format.js { render 'products/response_filter_products' }
    end
  end

  def add_comment
    @comment = current_user.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js { render 'products/response_add_comment', locals: { success: true } }
      else
        format.js { render 'products/response_add_comment', locals: { success: false } }
      end
    end
  end

  def add_reply
    @reply = current_user.replies.build(reply_params)
    respond_to do |format|
      if @reply.save
        format.js { render 'products/response_add_reply', locals: { success: true } }
      else
        format.js { render 'products/response_add_reply', locals: { success: false } }
      end
    end
  end

  def show_replies
    @comment = Comment.find(params['comment_id'])
    @replies = @comment.replies

    respond_to do |format|
      format.js { render 'products/response_show_replies' } unless @replies.load.blank?
    end
  end

  def add_reply_form
    unless current_user
      respond_to do |format|
        format.js do
          render 'products/response_show_message', locals: { success: false, message: 'You need to login to reply' }
        end
      end
      return
    end
    @reply = current_user.replies.build
    @comment = Comment.find(params['comment_id'])
    respond_to do |format|
      format.js { render 'products/response_add_reply_form', locals: { success: false } }
    end
  end

  def toggle_like
    record_type = params['record_type']
    record_id = params['record_id']
    unless current_user
      respond_to do |format|
        format.js do
          render 'products/response_show_message', locals: { success: false, message: 'You need to login to reply' }
        end
      end
      return
    end
    # Remove
    like = Like.find_by(record_id: record_id, record_type: record_type)
    unless like.nil?
      respond_to do |format|
        like.destroy!
        format.js do
          render 'products/response_toggle_like', locals: { success: true, like: like, message: 'Sucess remove like!' }
        end
      rescue ActiveRecord::RecordNotDestroyed => e
        format.js do
          render 'products/response_toggle_like',
                 locals: { success: false, like: like, message: 'Fail to remove like!' }
        end
        puts "errors that prevented destruction: #{e.record.errors}"
      end
      return
    end

    # Check valid
    record = record_type.classify.safe_constantize.find_by(id: record_id)
    if record.nil?
      respond_to do |format|
        format.js do
          render 'products/response_toggle_like',
                 locals: { success: false, like: like, message: 'Something wrong has happened!' }
        end
      end
      return
    end
    # Add record
    like = current_user.likes.build
    like = record.likes.build(like.as_json)
    respond_to do |format|
      if like.save
        format.js do
          render 'products/response_toggle_like', locals: { success: true, like: like, message: 'Sucess add like!' }
        end
      else
        format.js { render 'products/response_toggle_like', locals: { success: false, message: 'Failed to add like' } }
      end
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
    @product_meta.build_product_detail
    @product_meta.build_product_advanced
    @product_meta.build_product_inventory
    @product_meta.build_product_linked.product_upsells.build
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
        :tag,
        { product_detail_attributes: %i[name description regular_price],
          images: [],
          product_inventory_attributes: %i[sku manage_stock stock_status sold_individually],
          product_shipping_attributes: %i[weight length width height shipping_class],
          product_linked_attributes: [:product_upsell_ids_string, :product_cross_sell_ids_string,
                                      { product_upsell_ids: [], product_cross_sell_ids: [] }],
          product_sale_price_attributes: %i[sale_price sale_date_start sale_date_start_time sale_date_end
                                            sale_date_end_time],
          product_advanced_attributes: %i[purchase_note enable_reviews],
          product_extra_attributes: [:product_video] }
      ],
      product_variations_attributes: [
        product_attributes_value_ids: [],
        product_meta_attributes: [
          :tag,
          { images: [],
            product_detail_attributes: %i[name description regular_price],
            product_inventory_attributes: %i[sku manage_stock stock_status sold_individually],
            product_shipping_attributes: %i[weight length width height shipping_class],
            product_linked_attributes: %i[upsells cross_sells],
            product_sale_price_attributes: %i[sale_price sale_date_start sale_date_start_time sale_date_end
                                              sale_date_end_time],
            product_advanced_attributes: %i[purchase_note enable_reviews],
            product_extra_attributes: [:product_video] }
        ]
      ],
      category_attributes: [:name]
    )
  end

  def product_meta_params
    params.require(:product).require(:product_meta_attributes).permit(
      :tag,
      { images: [],
        product_detail_attributes: %i[name description regular_price],
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
    params.permit(:product_id, :quantity)
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

  def comment_params
    params.require(:comment).permit(:message, :product_id)
  end

  def reply_params
    params.require(:reply).permit(:message, :comment_id)
  end
end
