RSpec.describe RedirectToActiveGame do
  def app
    Rack::Builder.parse_file('config.ru').first
  end

  include_context 'when game active'

  it 'game redirects from lose' do
    get(Constants::LOSE_GAME_PATH)

    expect(last_response).to be_redirect
    expect(last_response.header['Location']).to eq(Constants::GAME_PATH)
  end

  it 'game redirects from win' do
    get(Constants::WIN_GAME_PATH)

    expect(last_response).to be_redirect
    expect(last_response.header['Location']).to eq(Constants::GAME_PATH)
  end

  it 'game redirects from home' do
    get(Constants::HOME_PATH)

    expect(last_response).to be_redirect
    expect(last_response.header['Location']).to eq(Constants::GAME_PATH)
  end

  it 'game redirects from statistics' do
    get(Constants::STATISTICS_PATH)

    expect(last_response).to be_redirect
    expect(last_response.header['Location']).to eq(Constants::GAME_PATH)
  end

  it 'game redirects from rules' do
    get(Constants::RULES_PATH)

    expect(last_response).to be_redirect
    expect(last_response.header['Location']).to eq(Constants::GAME_PATH)
  end
end
