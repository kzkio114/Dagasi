class ItemsController < ApplicationController

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
