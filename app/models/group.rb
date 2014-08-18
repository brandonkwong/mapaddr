class Group
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :is_public, type: Boolean, default: true

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :user_id

  validates :description, presence: true
  
  belongs_to :user
  has_many :locations, dependent: :destroy
end
