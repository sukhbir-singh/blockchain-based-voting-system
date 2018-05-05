require 'autoinc'

class Leader
  include Mongoid::Document
  include Mongoid::Autoinc
  include Mongoid::Timestamps::Created
  include ActiveModel::Validations

  field :inc_id,            type: Integer
  increments :inc_id, seed: 0

  index({inc_id: 1})

  field :name, type: String
  field :party, type: String
  field :area, type: String
  field :adhaar, type: String
  field :contact, type: String  
  field :email, type: String  
  field :sex, type: String, default: 'male'

  validates_inclusion_of :sex, :in => ['male','female']

end
