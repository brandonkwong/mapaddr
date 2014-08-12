class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :name, type: String
  field :email, type: String
  field :password_digest, type: String

  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email

  has_secure_password
  
  has_many :groups, dependent: :destroy
  has_many :locations
end
