Thincloud::Resque::Engine.routes.draw do

  mount Resque::Server.new, at: "resque"

end
