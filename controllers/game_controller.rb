class GameController < BaseController
  def get
    render
  end

  def post
    proceed_user_params
    return proceed_finished_game if game.win? || game.lose?

    render
  end

  private

  def proceed_user_params
    if @request.params.key?('hint')
      give_hint
    elsif @request.params.key?('guess')
      make_guess
    end
  end

  def proceed_lose
    redirect(Constants::LOSE_GAME_PATH)
  end

  def proceed_finished_game
    return proceed_win if game.win?

    proceed_lose
  end

  def proceed_win
    Codebreaker::ScoreManager.add_score(game.to_h)

    redirect(Constants::WIN_GAME_PATH)
  end

  def make_guess
    game.guess(user_code)
  rescue Codebreaker::Exceptions::DigitsExpectedError,
         Codebreaker::Exceptions::NoMoreAttemptsError,
         Codebreaker::Exceptions::EmptyArrayError,
         Codebreaker::Exceptions::UnableToCompareError,
         Codebreaker::Exceptions::OutOfComparisonRangeError => e
    @errors.push(e.message)
  end

  def user_code
    @request.params['guess'].chars.map(&:to_i)
  end

  def last_comparison
    game.last_comparison
  end

  def give_hint
    @request.session[:game].hint
  rescue Codebreaker::Exceptions::NoMoreHintsError => e
    @errors.push(e.message)
  end
end
