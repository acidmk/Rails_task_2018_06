require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET index" do
    it "assigns @articles" do
      article = Article.create(:title => "test title", :text => "test text")
      get :index
      expect(assigns(:articles)).to eq([article])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "assigns @article" do
      get :new
      expect(assigns(:article)).to be_a_new(Article)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET edit" do
    before do
      @article = Article.create(:title => "test title", :text => "test text")
    end

    it "assigns @article" do
      get :edit, :params => { :id => @article.id }
      expect(assigns(:article)).to eq(@article)
    end

    it "renders the edit template" do
      get :edit, :params => { :id => @article.id }
      expect(response).to render_template("edit")
    end
  end

  describe "POST article" do
    it "creates and redirects to @article" do
      post :create, :params => { :article => { :title => "test title", :text => "test text" } }
      expect(response).to redirect_to assigns(:article)
    end

    it "redirects to new on fail" do
      post :create, :params => { :article => { :title => "test", :text => "test text" } }
      expect(response).to render_template("new")
    end
  end

  describe "PATCH article" do
    before do
      @article = Article.create(:title => "test title", :text => "test text")
    end

    it "updates and redirects to @article" do
      patch :update, :params => { :id => @article.id, :article => { :title => "test title upd", :text => "test text upd" } }
      expect(response).to redirect_to assigns(:article)
    end

    it "redirects to edit on fail" do
      patch :update, :params => { :id => @article.id, :article => { :title => "test", :text => "test text" } }
      expect(response).to render_template("edit")
    end
  end

  describe "DELETE article" do
    it "destroys article and redirects to index" do
      article = Article.create(:title => "test title", :text => "test text")
      delete :destroy, :params => { :id => article.id }
      expect(response).to redirect_to articles_path
    end
  end
end
