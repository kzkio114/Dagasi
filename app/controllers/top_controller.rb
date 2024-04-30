class TopController < ApplicationController

  def index
  end

  def add_button
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append("buttons", partial: "top/button")
      end
    end
  end

  def remove_buttons
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("buttons", "")
      end
    end
  end

end