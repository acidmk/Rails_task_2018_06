require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "validates name" do
    expect{Tag.create!}.to raise_error(Mongoid::Errors::Validations)
  end

  it "generates csv" do
    article = Article.create!(:title => "test title", :text => "test text")
    article1 = Article.create!(:title => "test title1", :text => "test text1")
    tag = Tag.create!(:name => "tag")
    tag1 = Tag.create!(:name => "tag1")
    article.tags << tag
    article.tags << tag1
    article1.tags << tag

    csv_string = Tag.all.to_csv
    expect(csv_string).to eq "Tag,Articles count\ntag,2\ntag1,1\n"
  end
end
