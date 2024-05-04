class TopController < ApplicationController

  def index
    @search_form = SearchForm.new(keyword: params[:keyword])
    if @search_form.valid?
      @keyword = @search_form.keyword
      @keyword += "　子ども"
      @items = RakutenService.search_items(@keyword)
    end
    @random_items = random_items
    @buttons = Button.all
    @last_item = Item.last # またはどのようにして最後のアイテムを取得するかに基づきます
    @item_count = Item.count
    
    # Twitterの共有リンク用のテキストを作成
    app_url = "nostalgic-e3f4cba5b01a.herokuapp.com"
    app_name = "懐かしいものを思い出すアプリ"
    last_item_name = @last_item.name.gsub("子ども", "") if @last_item.present? # 最後のアイテム名からも「子ども」を削除
    @tweet_text = "#{app_name}\n最後に登録した懐かしいもの: #{last_item_name}\n懐かしいもの登録数: #{@item_count}\n#{app_url}\n#懐思いアプリ #ミニアプリweek"
  end


  def show
    # 必要な処理をここに記述
  end

  def post
    @item_count = Item.count
    last_item_id = session[:cart].last
    @last_item = Item.find_by(id: last_item_id)

    # 最新のアイテムを取得して設定
    @last_item = Item.order(created_at: :desc).first

    # 投稿処理（外部APIへの同期POSTリクエストなど）
    if @last_item
      # 投稿が成功した場合の処理
      redirect_to root_path, notice: 'アイテムをXに投稿しました。'
    else
      # エラー処理
      redirect_to root_path, alert: '投稿するアイテムが見つかりません。'
    end
  end

  def show_info
    @some_data = "この情報は動的にロードされました。"
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("info_area", partial: "top/info_content", locals: { some_data: @some_data }) }
      format.html { render partial: "top/info_content", locals: { some_data: @some_data } }
    end
  end

  def clear_info
    respond_to do |format|
      format.turbo_stream do
        # 説明の内容を完全にクリアする
        render turbo_stream: turbo_stream.update("info_area", "")
      end
      format.html { redirect_to root_path }  # リダイレクトが必要な場合
    end
  end

  def random_items
    ids = Item.pluck(:id)
    random_ids = ids.sample(5)
    Item.find(random_ids)
  end

  def refresh_items
    @items = random_items
    respond_to do |format|
      format.js
    end
  end


  def add_button
    @button = Button.new
    if @button.save
      @item_names = Item.pluck(:name).map { |name| name.gsub("子ども", "") if name } # アイテム名を取得し、"子ども"を削除
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append("buttons", partial: "top/button", locals: { button: @button })
        end
        format.html { redirect_to root_path }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def remove_specific_button
    @button_id = params[:id]
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@button_id)
      end
    end
  end

  # 特定のボタンのみを削除する
  #　全部削除の為updateを使う
  def remove_buttons
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("buttons", "")
      end
    end
  end

#    # 特定の要素だけを新しい内容で更新の為replaceを使う
#    # 特定のボタンのみを削除し、新しい内容で置き換える
#    def replace_element
#     @element_id = params[:id]
#     respond_to do |format|
#       format.turbo_stream do
#         render turbo_stream: turbo_stream.replace(@element_id, partial: "top/new_element_content")
#       end
#     end
#   end
end