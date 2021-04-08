class RedirectToActiveGame < BaseMiddleware
  def call(env)
    request_params(env)

    return @app.call(env) unless @game
    return @app.call(env) if @game.lose? || @game.win?
    return @app.call(env) if @path == Constants::GAME_PATH

    redirect(Constants::GAME_PATH)
  end
end
