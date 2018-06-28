class Tag
  include Mongoid::Document
  field :name, type: String
  has_and_belongs_to_many :articles
  accepts_nested_attributes_for :articles
  validates_uniqueness_of :name
  validates :name, presence: true
  index({ name: 1 }, { unique: true, name: "name_index" })

  def self.to_csv
    CSV.generate do |csv|
      csv << ["Tag", "Articles count"]

      all.each do |tag|
        csv << [tag.name, tag.articles.length]
      end
    end
  end
end
