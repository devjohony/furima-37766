class ItemsController < ApplicationController
  before_action :require_login, only: :new, alert: 'You need to sign in or sign up before continuing.'
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  # def update
  #   if @item.update(item_params)
  #     redirect_to item_path(@item.id)
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   if @item.destroy
  #     redirect_to root_path
  #   else
  #     redirect :show
  #   end
  # end

  private

  def require_login
    redirect_to user_session_path, alert: 'You need to sign in or sign up before continuing.' unless user_signed_in?
  end

  def item_params
    params.require(:item).permit(:image, :name, :explanation, :category_id, :derively_fee_id, :status_id, :prefecture_id, :scheduled_day_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = item.find(params[:id])
  end
end
