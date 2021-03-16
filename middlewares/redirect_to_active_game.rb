class RedirectToActiveGame < BaseMiddleware
  def initialize(app)
    super()
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    game = request.session[:game]
    path = request.path

    return @app.call(env) if game.nil?
    return @app.call(env) if game.lose? || game.win?
    return @app.call(env) if path == Constants::GAME_PATH

    redirect(Constants::GAME_PATH)
  end
end
