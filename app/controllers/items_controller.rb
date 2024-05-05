class ItemsController < ApplicationController

  # def create_or_find
  #   @item = Item.find_or_create_by(name: params[:name])
  #   if @item.persisted?
  #     respond_to do |format|
  #       format.html { redirect_back(fallback_location: root_path, notice: "Item successfully saved.") }
  #       format.turbo_stream do
  #         # Turbo Streamを使用して、ページの特定の部分のみを更新する場合
  #         render turbo_stream: turbo_stream.replace('items', partial: 'items/item', locals: { item: @item })
  #       end
  #     end
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def create_or_find
    @item = Item.find_or_create_by(name: params[:name])
    if @item.persisted?
      # アイテムが保存されたら、前のページにリダイレクトする
      redirect_back(fallback_location: root_path, notice: "懐かしいものを保存しました。")
    else
      # 保存が失敗した場合、エラーメッセージと共に新規作成ページに戻る
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
