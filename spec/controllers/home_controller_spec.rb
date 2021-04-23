RSpec.describe HomeController do
  def app
    Rack::Builder.parse_file('config.ru').first
  end

  let(:env) { { 'name' => 'Boris', 'difficulty' => 'easy' } }

  it 'game redirects back to active game' do
    post(Constants::HOME_PATH, { 'name' => 'Boris', 'difficulty' => 'easy' })

    expect(last_response).to be_redirect
    expect(last_response.header['Location']).to eq(Constants::GAME_PATH)
  end

  it 'shows name error' do
    post(Constants::HOME_PATH, { 'name' => 'Bo', 'difficulty' => 'easy' })

    expect(last_response.body).to include(I18n.t(:player_name_error))
  end

  it 'shows difficulty error' do
    post(Constants::HOME_PATH, { 'name' => 'Boris', 'difficulty' => 'easy22' })

    expect(last_response.body).to include(I18n.t(:incorrect_difficulty))
  end
end
