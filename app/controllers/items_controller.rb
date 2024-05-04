class ItemsController < ApplicationController

  def create_or_find
    @item = Item.find_or_create_by(name: params[:name])
    if @item.persisted?
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.append('items', partial: 'items/item', locals: { item: @item }) }
        format.html { redirect_to items_path }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def random_search
    ids = Item.pluck(:id)  # 全てのアイテムのIDを取得
    random_ids = ids.sample(5)  # IDのリストからランダムに5つ選択
    @items = Item.find(random_ids)  # ランダムなIDに対応するアイテムを取得

    if @items.empty?
      flash[:alert] = '検索キーワードがデータベースに存在しません。'
      redirect_to root_path   # エラーメッセージと共に別のページにリダイレクト
    else
      redirect_to top_index_path(keyword: @items.first.name)  # TopControllerのindexアクションにリダイレクト
    end
  end
end
