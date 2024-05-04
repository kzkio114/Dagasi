class CartsController < ApplicationController
  def add
    session[:cart] ||= []
    session[:cart] << params[:keyword]
    redirect_to root_path
  end

  def add_to_cart
    @item = Item.find_by(name: params[:id])
    if @item
      session[:cart] ||= []
      if session[:cart].include?(@item.id)
        redirect_to root_path, alert: 'アイテムは既に存在してます。'
      else
        session[:cart] << @item.id
        redirect_to root_path
      end
    else
      redirect_to items_path, alert: 'アイテムが見つかりませんでした。'
    end
  end
end

