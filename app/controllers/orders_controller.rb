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

  def checkout
    @cart = Cart.find_by(user_id: current_user.id)
    @order_view = OrderNewView.new(@cart, view_context)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @cart = Cart.find_by(user_id: current_user.id)
    @order = Order.find_by(id: params[:id])
    @order_view = OrderNewView.new(@cart, view_context)
  end

  # GET /orders/new
  def new
    @order = Order.new
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

    success = true
    # success = @order.save
    unless @order.save
      success = false
      print("Save................................................................................\n", @order.errors.full_messages)
    end
    @cart = Cart.find_by(user_id: current_user.id)
    @cart.product_carts.each do |item|
      item.order_id = @order.id
      print("WTF.........................................\n", item.inspect)
      unless item.save
        success = false
        print("Save Product--------------------------------------------------------------------\n", item.errors.full_messages)
      end
      # success = false unless item.save
    end

    print("Success: ", success)
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
    params.require(:order).permit(:first_name, :last_name, :company, :country, :address, :city, :zip_code,
                                  :phone, :email, :card_number, :expiry_date, :card_code, :total, :note)
  end
end
