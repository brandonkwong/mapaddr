class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :name, type: String
  field :email, type: String
  field :password_digest, type: String

  validates :name, presence: true
  validates :email, # presence: true, (unnecessary with below email validation)
            format: { with: /\A[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,10})\z/i },
            uniqueness: { case_sensitive: false }

  has_secure_password
  
  has_many :groups, dependent: :destroy
  has_many :locations
end
