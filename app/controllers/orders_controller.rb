class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :item_set, only: [:index, :create]
  before_action :order_address_set, only: [:index ]
  before_action :contributor, only: [:index, :new, :create]
  
  def index
  end

  def create
    @order_address = OrderAddress.new(order_params)

    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
      else
        render :index
      end
  end

  private
  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id,item_id: params[:item_id],token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
    end

  def item_set
    @item = Item.find(params[:item_id])
  end

  def order_address_set
    @order_address = OrderAddress.new
  end

  def contributor
    return unless  @item.user == current_user || @item.order.present? 
    redirect_to root_path
  end
end



