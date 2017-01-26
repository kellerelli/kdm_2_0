class MonstersController < ApplicationController
  def index
    @monsters = Monsters.index
    respond_to do |format|
      format.json { render :json => @monsters }
    end
  end
end
