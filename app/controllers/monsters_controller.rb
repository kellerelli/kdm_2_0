class MonstersController < ApplicationController
  before_action :set_monster, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_with_token!

  # GET /monsters
  # GET /monsters.json
  def index
    monsters = {}
    Monster.all.each do |monster|
      all_levels = []
      monster.levels.each do |level|
        all_levels << level
      end
      monsters[monster.name] = all_levels
      monsters[:id] = monster.id
    end
    respond_to do |format|
      format.json { render json: monsters, status: :created }
    end
  end

  # GET /monsters/1
  # GET /monsters/1.json
  def show
    monster = {}
    monster[@monster.name] = @monster.levels
    monster[:id] = @monster.id
    respond_to do |format|
      format.json { render json: monster, status: :created }
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_monster
    sleep 2
    @monster = Monster.find(params[:id])
  end

  def check_monster_exists
    @monster = Monster.new(params[:monster])
    monster_found = Monster.where(:name => @monster.monstername).all
    raise monster_found.inspect unless monster_found.empty?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def monster_params
    params.require(:monster).permit(:name, :speed, :success, :strength)
  end
end


