class ItemsController < ApplicationController
  def random_search
    # データベースからランダムにキーワードを一つ選ぶ
    item = Item.order("RANDOM()").first
    if item
      redirect_to top_index_path(keyword: item.keyword)  # TopControllerのindexアクションにリダイレクト
    else
      flash[:alert] = '検索キーワードがデータベースに存在しません。'
      redirect_to root_path   # エラーメッセージと共に別のページにリダイレクト
    end
  end
end
