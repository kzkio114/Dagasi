class TopController < ApplicationController

  def index
    @keyword = params[:keyword]
    if @keyword.present?
      @items = RakutenService.search_items(@keyword).map do |item|
        total_price = PriceCalculator.calculate(item[:name])
        item.merge(total_price: total_price)
      end
    end
    @buttons = Button.all
  end


  def add_button
    @button = Button.new
    if @button.save
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

#   # 特定の要素だけを新しい内容で更新の為replaceを使う
#   # 特定のボタンのみを削除し、新しい内容で置き換える
#   def replace_element
#     @element_id = params[:id]
#     respond_to do |format|
#       format.turbo_stream do
#         render turbo_stream: turbo_stream.replace(@element_id, partial: "top/new_element_content")
#       end
#     end
#   end
end