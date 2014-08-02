class Group
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  belongs_to :user
  has_many :locations
end
