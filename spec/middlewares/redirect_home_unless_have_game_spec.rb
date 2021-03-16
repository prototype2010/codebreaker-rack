RSpec.describe RedirectHomeUnlessHaveGame do
  def app
    Rack::Builder.parse_file('config.ru').first
  end

  it 'game redirects back to home' do
    get(Constants::GAME_PATH)

    expect(last_response).to be_redirect
    expect(last_response.header['Location']).to eq(Constants::HOME_PATH)
  end

  it 'game-lose redirects back to home' do
    get(Constants::LOSE_GAME_PATH)

    expect(last_response).to be_redirect
    expect(last_response.header['Location']).to eq(Constants::HOME_PATH)
  end

  it 'game-win redirects back to home' do
    get(Constants::WIN_GAME_PATH)

    expect(last_response).to be_redirect
    expect(last_response.header['Location']).to eq(Constants::HOME_PATH)
  end
end
