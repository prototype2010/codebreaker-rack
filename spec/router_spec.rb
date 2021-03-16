RSpec.describe Router do
  def app
    Rack::Builder.parse_file('config.ru').first
  end

  context 'when no game' do
    it 'index page works well' do
      get(Constants::HOME_PATH)
      expect(last_response.body).to include('Codebreaker')
    end

    it 'statistics page works well' do
      get(Constants::STATISTICS_PATH)
      expect(last_response.body).to include('Top of Players:')
    end

    it 'rules page works well' do
      get(Constants::RULES_PATH)
      expect(last_response.body).to include('Game Rules')
    end
  end
end
