class TagsMailer < ApplicationMailer
  def tags_email(send_to, csv_content)
    dt = Time.now.strftime("%FT%H:%M")
    attachments["tags_reports_#{ dt }.csv"] = {mime_type: 'text/csv', content: csv_content}
    mail(to: send_to, subject: 'Recent tags statistics')
  end
end
