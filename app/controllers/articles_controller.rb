class ArticlesController < ApplicationController
  def index
    @articles = Article.all.to_a
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
 
    if @article.save
      TagsReportJob.perform_later
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
   
    if @article.update(article_params)
      TagsReportJob.perform_later
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
   
    redirect_to articles_path
  end

  private
  def article_params
    if not params[:article][:tags_attributes]
      params[:article][:tags_attributes] = []
    end
    params.require(:article).permit(:title, :text, :tags_attributes => [ :name ])
  end
end
