require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before do
    @article = Article.create(:title => "test title", :text => "test text")
    @comment = @article.comments.create(:commenter => "commenter", :body => "first comment")
  end

  describe "POST comment" do
    it "creates and redirects to @article" do
      post :create, :params => { :article_id => @article.id, :comment => { :commenter => "test commenter", :body => "test text" } }
      expect(response).to redirect_to article_path(@article)
    end
  end

  describe "DELETE comment" do
    it "destroys comment and redirects to article" do
      delete :destroy, :params => { :article_id => @article.id, :id => @comment.id }
      expect(assigns(:comment).destroyed?).to be true
      expect(response).to redirect_to article_path(@article)
    end
  end
end
