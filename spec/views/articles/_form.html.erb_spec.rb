require "spec_helper"

describe "articles/_form.html.erb" do
  before do
    @article = Article.create!(:title => "test title", :text => "test text")
    @article.tags.create(:name => "tag1")

  end
  it "displays article fields" do
    assign(:article, @article)
    render

    expect(rendered).to match /test title/m
    expect(rendered).to match /test text/m
    expect(rendered).to match /article-tag/m
    expect(rendered).to match /tag1/m
  end
end
