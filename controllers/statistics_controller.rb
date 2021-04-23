class StatisticsController < BaseController
  def get
    render
  end

  private

  def score
    Codebreaker::ScoreManager.score
  end
end
