class ItemsController < ApplicationController
    def index
      @items = Items.index
      respond_to do |format|
        format.json { render :json => @items }
        format.html
      end
    end

  def show

  end
end
