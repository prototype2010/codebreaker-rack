class RedirectHomeUnlessHaveGame < BaseMiddleware
  def initialize(app)
    super()
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    game = request.session[:game]
    path = request.path

    return @app.call(env) unless game_route?(path)
    return @app.call(env) if game

    redirect(Constants::HOME_PATH)
  end

  def game_route?(path)
    [Constants::LOSE_GAME_PATH, Constants::WIN_GAME_PATH, Constants::GAME_PATH].include?(path)
  end
end
