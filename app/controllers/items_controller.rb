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

    def create
      @item = Item.new(item_params)
      if @item.save
        flash[:notice] = 'アイテムを保存しました。'
        redirect_to items_path
      else
        flash[:alert] = 'アイテムの保存に失敗しました。'
        render :new
      end
    end

    private

    def item_params
      params.require(:item).permit(:name, :category)
    end
  end
end