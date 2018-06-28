require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @article = Article.create!(:title => "test article", :text => "bla bla")
  end

  it "validates title" do
    expect{Article.create!(:title => "test", :text => "bla bla")}.to raise_error(Mongoid::Errors::Validations)
  end
  context "with comments" do
    it "orders them chronologically" do
      comment1 = @article.comments.create!(:commenter => "commenter1", :body => "first comment")
      comment2 = @article.comments.create!(:commenter => "commenter2", :body => "second comment")
      expect(@article.reload.comments).to eq([comment1, comment2])
    end
  end
  context "with tags" do
    it "orders them chronologically" do
      tag1 = @article.tags.create!(:name => "tag1")
      tag2 = @article.tags.create!(:name => "tag2")
      expect(@article.reload.tags).to eq([tag1, tag2])
    end
    it "checks for uniqueness" do
      tag1 = @article.tags.create!(:name => "tag1")
      expect{@article.tags.create!(:name => "tag1")}.to raise_error(Mongoid::Errors::Validations)
    end
    it "can't have blank name" do
      expect{@article.tags.create!(:name => "")}.to raise_error(Mongoid::Errors::Validations)
    end
    it "adds and removes article_id in tag" do
      tag1 = @article.tags.create!(:name => "tag1")
      expect(tag1.articles.length).to eq(1)
      expect(tag1.articles[0].id).to eq(@article.id)

      @article.destroy
      expect(tag1.articles.length).to eq(0)
    end
  end
end
