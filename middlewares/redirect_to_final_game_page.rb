class RedirectToFinalGamePage < BaseMiddleware
  def proceed
    return call_next if !@game || !game_route?

    return redirect(Constants::WIN_GAME_PATH) if @game.win? && @path != Constants::WIN_GAME_PATH
    redirect(Constants::LOSE_GAME_PATH) if @game.lose? && @path != Constants::LOSE_GAME_PATH
  end
end
