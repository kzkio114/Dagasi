class TopController < ApplicationController

  def index
    @search_form = SearchForm.new(keyword: params[:keyword])
    if @search_form.valid?
      @keyword = @search_form.keyword
      @keyword += "　子ども" # 検索キーワードに "全てに 子ども" を追加
      @items = RakutenService.search_items(@keyword)
    end
    @random_items = random_items
    @buttons = Button.all
  end

  def show_info
    @some_data = "この情報は動的にロードされました。"
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("info_area", partial: "top/info_content", locals: { some_data: @some_data }) }
      format.html { render partial: "top/info_content", locals: { some_data: @some_data } }
    end
  end

  def post
    @item_count = Item.count
    # その他の投稿処理
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