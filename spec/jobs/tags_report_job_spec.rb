require 'rails_helper'

RSpec.describe TagsReportJob, type: :job do
  describe "#perform_later" do
    it "sends email" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        TagsReportJob.perform_later()
      }.to have_enqueued_job
    end
  end
end
