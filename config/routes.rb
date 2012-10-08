Rails.application.routes.draw do

  # resque-web admin
  namespace :admin do
    mount Resque::Server.new, at: "resque"
  end

end
