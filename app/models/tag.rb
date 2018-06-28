class Tag
  include Mongoid::Document
  field :name, type: String
  has_and_belongs_to_many :articles
  accepts_nested_attributes_for :articles
  validates_uniqueness_of :name
  validates :name, presence: true
  index({ name: 1 }, { unique: true, name: "name_index" })
end
