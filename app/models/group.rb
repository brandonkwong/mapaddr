class Group
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :is_public, type: Mongoid::Boolean, default: true

  validates :name, presence: true
  validates :description, presence: true
  
  belongs_to :user
  has_many :locations, dependent: :destroy
end
