class Location
  include Mongoid::Document
  field :name, type: String
  field :address, type: String
  field :description, type: String
  
  field :latitude, type: String
  field :longitude, type: String

  belongs_to :group
  belongs_to :user
end
