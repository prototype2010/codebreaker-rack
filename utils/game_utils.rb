module GameUtils
  def secret_code
    game.secret_code
  end

  def game
    @request.session[:game]
  end

  def hints
    attempts_info[:hints]
  end

  def hints_shown
    game.hints_shown
  end

  def game_hash
    game.to_h
  end

  def player_name
    game.player_name
  end

  def attempts_info
    game_hash[:attempts_info]
  end

  def hints_total
    attempts_info[:hints_total]
  end

  def hints_left
    attempts_info[:hints].length
  end

  def attempts_total
    attempts_info[:attempts_total]
  end

  def attempts_left
    attempts_info[:attempts_left]
  end

  def difficulty
    game_hash[:difficulty]
  end
end
