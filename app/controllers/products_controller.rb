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
    # Set manually params
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
        # self.errors.add(:base, "Could not save category")
        return false
      end
    end

    print("Cart \n", @cart.inspect)
    respond_to do |format|
      format.js { render 'products/show_add_to_cart_success' }
    end

    @product_cart = @cart.product_carts.build(product_cart_params)

    print("Product cart \n", @product_cart.inspect)

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
    print("Cart \n", @wishlist.inspect)
    respond_to do |format|
      format.js { render 'products/show_add_to_cart_success' }
    end

    @product_wishlist = @wishlist.product_carts.build(product_cart_params)

    print("Product Wish list \n", @product_wishlist.inspect)

    # flash[:alert] = "Add to cart successful"

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
