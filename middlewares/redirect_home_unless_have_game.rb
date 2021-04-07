class RedirectHomeUnlessHaveGame < BaseMiddleware
  def call(env)
    request_params(env)
    return @app.call(env) if !game_route? || @game

    redirect(Constants::HOME_PATH)
  end

  def game_route?
    [Constants::LOSE_GAME_PATH, Constants::WIN_GAME_PATH, Constants::GAME_PATH].include?(@path)
  end
end
