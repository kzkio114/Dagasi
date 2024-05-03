class ItemsController < ApplicationController
  def random_search
    # データベースからランダムにアイテムを一つ選ぶ
    item = Item.order("RANDOM()").first
    if item
      redirect_to top_index_path(keyword: item.name)  # TopControllerのindexアクションにリダイレクト
    else
      flash[:alert] = '検索キーワードがデータベースに存在しません。'
      redirect_to root_path   # エラーメッセージと共に別のページにリダイレクト
    end
  end
end
