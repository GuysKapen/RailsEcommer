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
    @categories = Category.all
  end

  # GET /products/1/edit
  def edit
    @categories = Category.all
  end

  # POST /products
  # POST /products.json
  def create
    # @category = Category.new
    # @category.name =
    # @category.user = current_user
    @category = current_user.categories.build(name: product_params['category'])
    # current_user.categories.build()
    # Save category to get id
    unless @category.save
      # self.errors.add(:base, "Could not save category")
      return false
    end

    params[:product][:category_id] = @category.id
    params[:product][:category] = @category
    @product = current_user.products.build(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
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
      false
    end

    @cart_item = @cart.product_carts.count
    print("Cart \n", @cart.inspect)
    print("WTF #{@cart_item}\n")
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
    params.require(:product).permit(:name, :description, :price, :ratings, :regular_price, :sale_price, :category,
                                    :category_id, :sku, :stock_status,
                                    :manage_stock, :sold_individual, :weight, :up_sale, :cross_sale, images: [])
  end

  def product_cart_params
    params.permit(:style, :quality, :color, :size, :product_id, :quantity)
  end
end
