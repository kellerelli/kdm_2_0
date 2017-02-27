class WeaponsController < ApplicationController
  before_action :set_weapon, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_with_token!

  # GET /weapons
  # GET /weapons.json
  def index
    respond_to do |format|
      format.json { render json: Weapon.all, status: :created }
    end
  end

  # GET /weapons/1
  # GET /weapons/1.json
  def show
    respond_to do |format|
      format.json { render json: Weapon.all, status: :created }
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_weapon
    sleep 2
    @weapon = Weapon.find(params[:id])
  end

  def check_weapon_exists
    @weapon = Weapon.new(params[:weapon])
    weapon_found = Weapon.where(:name => @weapon.weaponname).all
    raise weapon_found.inspect unless weapon_found.empty?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def weapon_params
    params.require(:weapon).permit(:name, :speed, :success, :strength)
  end
end


