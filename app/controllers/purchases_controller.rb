class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create, :pay_item]
  before_action :authenticate_user!

  def index
    if @item[:user_id] == current_user.id || @item.purchase.present?
      redirect_to root_path
    else
      @purchase = PurchaseAddress.new
    end
  end

  def create
    @purchase = PurchaseAddress.new(purchase_params)
    if @purchase.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item[:price],  # 商品の値段
        card: params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
      @purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :municipality, :building_name, :address, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  
end