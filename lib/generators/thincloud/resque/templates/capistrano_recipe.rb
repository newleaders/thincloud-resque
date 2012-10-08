# Deploy methods
namespace :deploy do

  desc "Link resque assets"
  task :resque, roles: :app do
    resque_release_path = "#{release_path}/public/admin/resque"

    assets_path = "#{shared_path}/bundle/ruby/1.9.1/gems/resque-*/lib/"
    assets_path += "resque/server/public/*"

    # setup resque assets
    run "mkdir -p #{resque_release_path}; " +
        "ln -nfs #{assets_path} #{resque_release_path}"
  end

end

after "deploy:update_code", "deploy:resque"
