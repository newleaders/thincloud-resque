require "minitest_helper"

module Thincloud
  module Resque

    describe "Resque Mailer" do
      let(:mailer) { TestMailer }

      it { mailer.must_respond_to :resque }
    end

  end
end
