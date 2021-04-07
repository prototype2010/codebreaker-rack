class RedirectToFinalGamePage < BaseMiddleware
  def call(env)
    request_params(env)

    return @app.call(env) unless @game
    return @app.call(env) unless [Constants::GAME_PATH, Constants::LOSE_GAME_PATH,
                                  Constants::WIN_GAME_PATH].include?(@path)

    return redirect(Constants::WIN_GAME_PATH) if @game.win? && @path != Constants::WIN_GAME_PATH
    return redirect(Constants::LOSE_GAME_PATH) if @game.lose? && @path != Constants::LOSE_GAME_PATH

    @app.call(env)
  end
end
