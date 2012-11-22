require "rails"

module Thincloud
  module Generators
    # Public: Rails generator to add additional resque infrastructure
    class ResqueGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Generates additional thincloud resque infrastructure"
      def resque
        # procfile
        if File.exists?("Procfile")
          worker = "worker: bundle exec rake environment resque:work "
          worker << "RAILS_ENV=$RAILS_ENV QUEUE=*"

          append_file "Procfile", worker
        end

        say_status "", ""
        say_status "success", "thincloud-resque has finished."
      end

    end
  end
end
