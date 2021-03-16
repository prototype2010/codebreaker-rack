class Statistics < BaseController
  def get
    render
  end

  private

  def score
    Codebreaker::ScoreManager.score
  end
end
