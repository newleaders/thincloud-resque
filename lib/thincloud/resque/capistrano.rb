module Capistrano
  # We only want to hook onto Capistrano when the Configuration module is
  # present. Hat tip to the rvm-capistrano gem.
  if const_defined? :Configuration
    Configuration.instance(true).load do
      namespace :thincloud do
        namespace :resque do

          desc "Link resque-web assets to release path"
          task :link_assets, roles: :app do
            resque_release_path = "#{release_path}/public/admin/resque"

            assets_path = "#{shared_path}/bundle/ruby/1.9.1/gems/resque-*/lib/"
            assets_path += "resque/server/public/*"

            # setup resque assets
            run "mkdir -p #{resque_release_path}; " +
                "ln -nfs #{assets_path} #{resque_release_path}"
          end

        end
      end

      after "deploy:update_code", "thincloud:resque:link_assets"
    end
  end
end
