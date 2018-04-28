require 'autoinc'

class Dummy
  include Mongoid::Document
  include Mongoid::Autoinc
  include Mongoid::Timestamps::Created
  include ActiveModel::Validations

  field :inc_id,            type: Integer
  increments :inc_id, seed: 0

  index({inc_id: 1})

  field :name, type: String
  

  attr_accessor :name  
end
