require 'autoinc'

class User
  include Mongoid::Document
  include Mongoid::Autoinc
  include Mongoid::Timestamps::Created
  include ActiveModel::Validations

  field :inc_id,            type: Integer
  increments :inc_id, seed: 0

  index({inc_id: 1})

  validates_uniqueness_of :adhaar
  validate :validate_password

  field :full_name, type: String
  field :email, type: String
  field :adhaar, type: String
  field :area, type: String
  field :image, type: String
  field :dob, type: Date
  field :contact, type: String
  field :password, type: String

  def validate_password
    unless password.length >= 6
      errors.add(:password,'must be atleast 6 characters long')
      raise "Password must be atleast 6 characters long."
    end
  end

end
