class CartsController < ApplicationController

    def add
        session[:cart] ||= []
        session[:cart] << params[:keyword]
        redirect_to root_path
    end

    def add_to_cart
    @keyword = params[:id]  # ここでキーワードを取得

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("element_id", partial: "carts/cart_item", locals: { keyword: @keyword })
      end
    end
  end
end