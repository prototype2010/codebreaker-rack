RSpec.describe GameController do
  def app
    Rack::Builder.parse_file('config.ru').first
  end

  let(:code_out_of_range) { '8888' }
  let(:long_code) { '1' * (Codebreaker::Constants::DIGITS_NUMBER + 1) }
  let(:wrong_code) { '1' * Codebreaker::Constants::DIGITS_NUMBER }
  let(:short_code) { '1' * (Codebreaker::Constants::DIGITS_NUMBER - 1) }

  include_context 'when game active'

  context 'when error' do
    it 'out of range characters' do
      post(Constants::GAME_PATH, { 'guess' => code_out_of_range })

      expect(last_response.body).to include(I18n.t(:out_of_range_error))
    end

    it 'too many digits' do
      post(Constants::GAME_PATH, { 'guess' => long_code })

      expect(last_response.body).to include(I18n.t(:unable_to_compare))
    end

    it 'empty code' do
      post(Constants::GAME_PATH, { 'guess' => '' })

      expect(last_response.body).to include(I18n.t(:empty_code))
    end
  end

  it 'redirects to win on win' do
    post(Constants::GAME_PATH, { 'guess' => correct_code })

    expect(last_response).to be_redirect
    expect(last_response.header['Location']).to eq(Constants::WIN_GAME_PATH)
  end

  it 'redirects to lose on lose' do
    game.instance_variable_set(:@attempts_left, 1)

    post(Constants::GAME_PATH, { 'guess' => wrong_code })

    expect(last_response).to be_redirect
    expect(last_response.header['Location']).to eq(Constants::LOSE_GAME_PATH)
  end

  it 'gives hint' do
    post(Constants::GAME_PATH, { 'hint' => '' })

    expect(game.hints_left).to eq(game.to_h[:attempts_info][:hints_total] - 1)
  end
end
