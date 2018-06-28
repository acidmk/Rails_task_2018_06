class TagsReportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    email = Rails.configuration.mails.tags_mail
    csv_string = Tags.all.to_csv
    TagsMailer.tags_email(email, csv_string).deliver_later
  end
end
