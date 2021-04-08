class RedirectToActiveGame < BaseMiddleware
  def proceed
    return call_next if !@game ||
      @game.lose? ||
      @game.win? ||
      @path == Constants::GAME_PATH

    redirect(Constants::GAME_PATH)
  end
end
