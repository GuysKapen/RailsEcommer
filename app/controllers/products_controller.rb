# frozen_string_literal: true
class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new edit update]
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @user = current_user
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.build_product_meta
    @categories = Category.all
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
    print("FUck ------------------------------------------\n", category_attrs)
    # Save category to get id
    unless @category.nil?
      unless @category.save
        errors.add(:base, 'Could not save category')
        return false
      end
    end

    # params[:product][:category_id] = @category.id
    # params[:product][:category] = @category

    params[:product][:category_id] = @category.id unless @category.nil?
    @product = current_user.products.build(product_params)
    @product.build_product_meta(product_params[:product_meta_attributes])
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        print("Fuck------------------------------", @product.errors.full_messages)
        format.html { render :new }
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

  def add_to_cart
    @cart = Cart.find_by(id: current_user.id)
    if @cart.nil?
      @cart = current_user.build_cart
      unless @cart.save
        print('Saving Cart Error', @cart.errors.full_messages)
        return false
      end
    end

    @product_cart = ProductCart.find_by(product_id: product_cart_params['product_id'])

    print("Product cart Found \n", @product_cart.inspect, "\n")
    if @product_cart.nil?
      @product_cart = @cart.product_carts.build(product_cart_params)
    else
      print("Fuck ----------------------------------------------------------------------\n")
      @product_cart.quantity += 1
      @product_cart.cart_id = @cart.id
    end

    print("Product cart \n", @product_cart.inspect)

    unless @product_cart.save
      print('Saving Product Cart Error', @product_cart.errors.full_messages)
      # self.errors.add(:base, "Could not save category")
      return false
    end

    @cart_item = @cart.product_carts.count
    print("Cart \n", @cart.inspect)
    print("WTF #{@cart_item}\n")

    @product_carts = ProductCart.where(cart_id: @cart.id)
    respond_to do |format|
      format.js { render 'products/show_add_to_cart_success' }
    end
    # flash[:alert] = "Add to cart successful"

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
      format.js { render 'products/show_add_to_wishlist_success' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, images: [], product_meta_attributes: %i[
        ratings regular_price sale_price
        sku stock_status width height length shipping_class product_video
        manage_stock sold_individual weight up_sell cross_sell
    ], category_attributes: [:name])
  end

  def product_cart_params
    params.permit(:style, :quality, :color, :size, :product_id, :quantity)
  end
end
