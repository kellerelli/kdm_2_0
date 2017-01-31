class MonstersController < ApplicationController
  def index
    @monsters = Monsters.index
    respond_to do |format|
      format.json { render :json => @monsters }
      format.html
    end
  end

  def show
    search_hash = {
        :Id => params[:id].to_i
    }
    @monster = Monsters.show(search_hash)
    respond_to do |format|
      format.json { render :json => @monster }
      format.html
    end
  end
end
