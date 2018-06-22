Amber::Server.configure do |app|
  pipeline :web do
    plug Amber::Pipe::PoweredByAmber.new
    plug Citrine::I18n::Handler.new
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
    plug Amber::Pipe::Session.new
    plug Amber::Pipe::Flash.new
    plug Amber::Pipe::CSRF.new
    plug Amber::Pipe::Reload.new if Amber.env.development?
  end

  # All static content will run these transformations
  pipeline :static do
    plug Amber::Pipe::PoweredByAmber.new
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Static.new("./public")
  end

  routes :web do
      resources "/pets", PetController
    get "/", PetController, :index
  end

  routes :static do
    get "/*", Amber::Controller::Static, :index
  end
end
