class RedirectHomeUnlessHaveGame < BaseMiddleware
  def proceed
    return call_next if !game_route? || @game

    redirect(Constants::HOME_PATH)
  end
end
