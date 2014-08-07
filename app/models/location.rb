class Location
  include Mongoid::Document
  field :name, type: String
  field :address, type: String
  field :description, type: String

  belongs_to :group
  has_and_belongs_to_many :users
end
