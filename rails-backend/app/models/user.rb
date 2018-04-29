require 'autoinc'

class User
  include Mongoid::Document
  include Mongoid::Autoinc
  include Mongoid::Timestamps::Created
  include ActiveModel::Validations

  before_save :encrypt_fields, if: :password_changed?

  field :inc_id,            type: Integer
  increments :inc_id, seed: 0

  index({inc_id: 1})

  validates_uniqueness_of :adhaar

  field :full_name, type: String
  field :email, type: String
  field :adhaar, type: String
  field :area, type: String
  field :image, type: String
  field :dob, type: Date
  field :contact, type: String
  field :password, type: String
  field :encryption_key, type: String, default: nil

  field :is_active, type: Boolean, default: false

  def encrypt_fields    
    self.password = AES.encrypt(self.password, AES_KEY) unless self.password.blank?
  end

end
