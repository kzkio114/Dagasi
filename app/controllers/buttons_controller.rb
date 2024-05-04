class ButtonsController < ApplicationController
    def index
      @buttons = Button.all
    end
  
    def new
  @button = Button.new
  @button.name = "My New Button"

  respond_to do |format|
    format.turbo_stream do
      render turbo_stream: turbo_stream.update('new_button', partial: 'buttons/button', locals: { button: @button })
    end
    format.html { render :new } # ここを変更
  end
end
  
    def create
      @button = Button.new(button_params)
  
      if @button.save
        redirect_to @button, notice: 'Button was successfully created.'
      else
        render :new
      end
    end
  
    private
  
    def button_params
      params.require(:button).permit(:name)
    end
end