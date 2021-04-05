RSpec.describe RedirectToFinalGamePage do
  def app
    Rack::Builder.parse_file('config.ru').first
  end

  context 'when won game' do
    include_context 'when game win'

    it 'game redirects from lose' do
      get(Constants::LOSE_GAME_PATH)

      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to eq(Constants::WIN_GAME_PATH)
    end

    it 'game redirects from game' do
      get(Constants::GAME_PATH)

      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to eq(Constants::WIN_GAME_PATH)
    end

    it 'new game can be started after win' do
      get(Constants::HOME_PATH)

      expect(last_response.body).to include(I18n(:start_game))
    end
  end

  context 'when lose-game' do
    include_context 'when game lose'

    it 'game redirects from win' do
      get(Constants::WIN_GAME_PATH)

      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to eq(Constants::LOSE_GAME_PATH)
    end

    it 'game redirects from game' do
      get(Constants::GAME_PATH)

      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to eq(Constants::LOSE_GAME_PATH)
    end

    it 'new game can be started after lose' do
      get(Constants::HOME_PATH)

      expect(last_response.body).to include(I18n(:start_game))
    end
  end
end
