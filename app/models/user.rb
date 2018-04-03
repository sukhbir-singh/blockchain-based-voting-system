require 'autoinc'

class User
  include Mongoid::Document
  include Mongoid::Autoinc
  include Mongoid::Timestamps::Created
  include ActiveModel::Validations

  field :inc_id,            type: Integer
  increments :inc_id, seed: 0

  index({inc_id: 1})

  validates_uniqueness_of :username
  # validate :validate_contact

  field :username, type: String
  field :full_name, type: String
  field :adhaar, type: String
  field :dob, type: Date
  field :contact, type: String
  field :password, type: String

end
