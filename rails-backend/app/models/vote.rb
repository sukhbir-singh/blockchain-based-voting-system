require 'autoinc'

class Vote
  include Mongoid::Document
  include Mongoid::Autoinc
  include Mongoid::Timestamps::Created
  include ActiveModel::Validations

  field :inc_id,            type: Integer
  increments :inc_id, seed: 0

  index({inc_id: 1})

  validates_uniqueness_of :created_at

  field :leader_id, type: String
  field :generated_id, type: String
  field :is_valid, type: Boolean, default: false

  def calculate_hash
    str = self.leader_id.to_s + self.created_at.to_s + self.generated_id.to_s
    Digest::MD5.hexdigest(str)
  end

end
