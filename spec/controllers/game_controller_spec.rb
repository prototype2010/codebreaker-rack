RSpec.describe GameController do
  def app
    Rack::Builder.parse_file('config.ru').first
  end

  include_context 'when game active'

  context 'when error' do
    it 'out of range characters' do
      post(Constants::GAME_PATH, { 'guess' => '8888' })

      expect(last_response.body).to include('There are characters that are out of comparison range')
    end

    it 'too many digits' do
      post(Constants::GAME_PATH, { 'guess' => '11111' })

      expect(last_response.body).to include('Codes are unable to compare because of different size')
    end

    it 'empty code' do
      post(Constants::GAME_PATH, { 'guess' => '' })

      expect(last_response.body).to include('Unable to compare empty arrays')
    end
  end

  it 'redirects to win on win' do
    post(Constants::GAME_PATH, { 'guess' => '1234' })

    expect(last_response).to be_redirect
    expect(last_response.header['Location']).to eq(Constants::WIN_GAME_PATH)
  end

  it 'redirects to lose on lose' do
    game.instance_variable_set(:@attempts_left, 1)

    post(Constants::GAME_PATH, { 'guess' => '1111' })

    expect(last_response).to be_redirect
    expect(last_response.header['Location']).to eq(Constants::LOSE_GAME_PATH)
  end

  it 'gives hint' do
    post(Constants::GAME_PATH, { 'hint' => '' })

    expect(game.hints_left).to eq(game.to_h[:attempts_info][:hints_total] - 1)
  end
end
