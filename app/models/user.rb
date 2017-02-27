class User
  require 'bcrypt'
  # BCrypt hash function can handle maximum 72 characters, and if we pass
  # password of length more than 72 characters it ignores extra characters.
  # Hence need to put a restriction on password length.
  MAX_PASSWORD_LENGTH_ALLOWED = 72


  include Dynamoid::Document
  field :username
  field :password_digest
  field :auth_token
  field :key_id
  attr_reader :password
  attr_reader :password_confirmation
  # :has_secure_password
  before_create :generate_authentication_token!
  before_create :check_user_exists
  before_create :validate_confirmation_password

  def generate_authentication_token!
    begin
      self.key_id = SecureRandom.uuid
    end until User.where(:auth_token => self.key_id).all.empty?

    begin
      self.auth_token = SecureRandom.hex
    end until User.where(:auth_token => self.auth_token).all.empty?
  end

  #check user exists
  def check_user_exists
    user_found = User.where(:username => self.username).all
    unless user_found.empty?
      self.errors.add(:username, 'already exists') unless user_found.empty?
      raise Dynamoid::Errors::RecordNotUnique.new(Dynamoid::Errors::RecordNotUnique, self.username)
    end
  end

  # This is so when :password is passed to be saved, it instead
  # Saves a hashed version of it to the object
  def password=(unencrypted_password)
    if unencrypted_password.nil?
      self.password_digest = nil
    elsif !unencrypted_password.empty?
      @password = unencrypted_password
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      self.password_digest = BCrypt::Password.create(unencrypted_password, cost: cost)
    end
  end

  def password_confirmation=(unencrypted_password)
    @password_confirmation = unencrypted_password
  end

  def authenticate(unencrypted_password)
    BCrypt::Password.new(password_digest).is_password?(unencrypted_password) && self
  end

  def validate_confirmation_password
    unless authenticate(@password_confirmation)
      self.errors.add(:username, 'Password does not match Password confirmation')
      raise StandardError.new('Password does not match Password confirmation')
    end
  end

end

#AWS::Record::Base for simple db
#AWS::Record::HashModel for dynodb

#default field values considerations
=begin
:string_attr
:integer_attr
:sortable_integer_attr
:float_attr
:sortable_float_attr
:boolean_attr
:datetime_attr
:date_attr
:timestamps
:find_by_id
:[]
:find
:shard
:domain
:all
:each
:count
:size
:first
:where
:order
:limit
:create_domain
:sdb_domain
:sdb_domain_name
:sdb
:model_name
:validate
:validates_acceptance_of
:validates_confirmation_of
:validates_count_of
:validates_each
:validates_exclusion_of
:validates_format_of
:validates_inclusion_of
:validates_length_of
:validates_numericality_of
:validates_presence_of
:set_shard_name
:set_domain_name
:shard_name
:shard_name
:domain_name
:scope
:create
:create
:new_scope
:optimistic_locking
:optimistic_locking
:optimistic_locking_attr
:attributes
:attribute_for
:add_attribute
:remove_attribute
:yaml_tag
:allocate
:new
:superclass
:json_creatable
:class_attribute
:superclass_delegating_accessor
:superclass_delegating_accessor_with_deprecation
:superclass_delegating_accessor_without_deprecation
:descendants
:subclasses
:freeze
=end
