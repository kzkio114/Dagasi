class CartsController < ApplicationController

    def add
        session[:cart] ||= []
        session[:cart] << params[:keyword]
        redirect_to root_path
    end

    def add_to_cart
  @keyword = params[:id]  # ここでキーワードを取得

  # 新しいItemを作成して保存
  @item = Item.new(name: @keyword)
  if @item.save
    flash[:notice] = 'アイテムを保存しました。'
  else
    flash[:alert] = 'アイテムの保存に失敗しました。'
  end

  respond_to do |format|
    format.turbo_stream do
      render turbo_stream: turbo_stream.replace("cart", partial: "carts/cart_item", locals: { item: @item })
    end
    format.html { redirect_to root_path }
  end
 end
end