class Level
  include Dynamoid::Document
  field :name
  field :level
  field :movement
  field :toughness
  field :speed
  field :damage
  field :luck
  field :accuracy
  field :evasion
end

class Monster
  include Dynamoid::Document

  field :name
  has_many :levels
end