class RedirectHomeUnlessHaveGame < BaseMiddleware
  def initialize(app)
    super()
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    game = request.session[:game]
    path = request.path

    return @app.call(env) unless [Constants::LOSE_GAME_PATH, Constants::WIN_GAME_PATH,
                                  Constants::GAME_PATH].include?(path)
    return @app.call(env) unless game.nil?

    redirect(Constants::HOME_PATH)
  end
end
