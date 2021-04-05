class RedirectHomeUnlessHaveGame < BaseMiddleware
  def initialize(app)
    super()
    @app = app
  end

  def call(env)
    request_params(env)

    return @app.call(env) unless game_route?
    return @app.call(env) if @game

    redirect(Constants::HOME_PATH)
  end

  def game_route?
    [Constants::LOSE_GAME_PATH, Constants::WIN_GAME_PATH, Constants::GAME_PATH].include?(@path)
  end
end
