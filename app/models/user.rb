class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :hased_password, type: String
  
  has_many :groups
end
