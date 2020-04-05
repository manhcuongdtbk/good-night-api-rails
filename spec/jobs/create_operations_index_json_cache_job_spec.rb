require "rails_helper"

RSpec.describe CreateOperationsIndexJsonCacheJob, type: :job do
  describe "#perform_later" do
    it "creates or updates operations index cache" do
      ActiveJob::Base.queue_adapter = :test
      user = create(:user)
      CreateOperationsIndexJsonCacheJob.perform_later(user.id)
      expect(CreateOperationsIndexJsonCacheJob).to have_been_enqueued.at(:no_wait)
    end
  end
end
