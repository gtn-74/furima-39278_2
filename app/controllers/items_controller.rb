class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :contributor_confirmation, only: [:edit]

  def index
    @items = Item.order('id DESC')
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

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end
  
  def destroy
    if @item.user_id == current_user.id
     @item.destroy
    end
      redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :content, :category_id, :sale_id, :shopping_id, :prefecture_id, :shopping_day_id,
                                 :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def contributor_confirmation
    if @item.user_id == current_user.id && @item.order.blank? 
    render :edit
    else
      redirect_to root_path
    end
  end
end
