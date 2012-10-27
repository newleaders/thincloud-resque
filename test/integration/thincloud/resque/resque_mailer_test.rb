require "minitest_helper"

module Thincloud
  module Resque

    describe "Resque Mailer" do
      let(:mailer) { TestMailer }

      it { mailer.must_respond_to :resque }
      it { mailer.ancestors.must_include ::Resque::Mailer }

      describe "inheritance" do
        let(:ancestors) { mailer.ancestors }
        let(:action_mailer) { ancestors.index ::ActionMailer::Base }
        let(:resque_mailer) { ancestors.index ::Resque::Mailer }

        it "must be after ActionMailer" do
          action_mailer.must_be :>, resque_mailer
        end
      end
    end

  end
end
