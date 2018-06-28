require "rails_helper"

RSpec.describe TagsMailer, type: :mailer do
  describe "tags_email" do
    article = Article.create!(:title => "test title", :text => "test text")
    article1 = Article.create!(:title => "test title1", :text => "test text1")
    tag = Tag.create!(:name => "tag")
    tag1 = Tag.create!(:name => "tag1")
    article.tags << tag
    article.tags << tag1
    article1.tags << tag

    let(:mail) { TagsMailer.tags_email(Rails.configuration.mails["tags_mail"], Tag.all.to_csv ) }

    it "renders the headers" do
      expect(mail.subject).to eq("Recent tags statistics")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("have a great day!")
    end

    it "has an csv attachment" do
      expect(mail.attachments.length).to eq(1)
      attachment = mail.attachments[0]
      expect(attachment).to be_a_kind_of(Mail::Part)
      expect(attachment.filename).to include("tags_reports", ".csv")
    end
  end
end
