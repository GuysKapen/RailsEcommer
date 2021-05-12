# frozen_string_literal: true

# require 'app/view_models/order_new_view.rb'
# noinspection ALL
class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  def shopping_cart
    @cart = Cart.find_by(user_id: current_user.id)
    @order_view = OrderNewView.new(@cart, view_context)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find_by(id: params[:id])
    @order_view = OrderView.new(@order, view_context)
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order_user_info = @order.build_order_user_info
    @order_card_info = @order_user_info.build_order_card_info
    @cart = Cart.find_by(user_id: current_user.id)
    @order_view = OrderNewView.new(@cart, view_context)
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders
  # POST /orders.json
  def create
    params[:order][:total] = params[:total]
    @order = Order.new(order_params)
    @order = current_user.orders.build(order_params)

    success = true
    # success = @order.save
    unless @order.save
      success = false
      print("Save................................................................................\n",
            @order.errors.full_messages)
    end
    @cart = Cart.find_by(user_id: current_user.id)
    @cart.product_carts.each do |item|
      item.product_cart_container = @order
      print("WTF.........................................\n", item.inspect)
      next if item.save

      success = false
      print("Save Product--------------------------------------------------------------------\n",
            item.errors.full_messages)
      # success = false unless item.save
    end

    print('Success: ', success)
    respond_to do |format|
      if success
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(
      :total, :note,
      order_user_info_attributes: [:first_name, :last_name, :company, :country, :address, :city, :zip_code,
                                   :phone, :email, :total, :note, { order_card_info_attributes: %i[card_code card_number expired_date] }]
    )
  end
end
