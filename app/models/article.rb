class Article
  include Mongoid::Document
  field :title, type: String
  field :text, type: String
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags
  validates :title, presence: true, length: { minimum: 5 }

  def tags_attributes=(hash)
    tags.clear
    hash.each do |sequence,tag_values|
      tags << Tag.where(name: tag_values[:name].strip).first_or_create!
    end
  end
end
