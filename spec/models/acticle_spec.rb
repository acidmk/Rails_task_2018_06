require 'rails_helper'

RSpec.describe Article, type: :model do
  context "with 2 or more comments" do
    it "orders them chronologically" do
      post = Article.create!(:title => "test article", :text => "bla bla")
      comment1 = post.comments.create!(:commenter => "commenter1", :body => "first comment")
      comment2 = post.comments.create!(:commenter => "commenter2", :body => "second comment")
      expect(post.reload.comments).to eq([comment1, comment2])
    end
  end
end
