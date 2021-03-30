RSpec.shared_context 'when game active' do
  let(:correct_code) { [1, 2, 3, 4] }
  let(:game) do
    Codebreaker::GameProcess.new({ difficulty: :easy,
                                   player_name: 'Boris',
                                   secret_code: correct_code })
  end

  before do
    env('rack.session', game: game)
  end
end

RSpec.shared_context 'when game lose' do
  let(:correct_code) { [1, 2, 3, 4] }
  let(:game) do
    Codebreaker::GameProcess.new({ difficulty: :easy,
                                   player_name: 'Boris',
                                   secret_code: correct_code })
  end

  before do
    game.instance_variable_set(:@attempts_left, 0)

    env('rack.session', game: game)
  end
end

RSpec.shared_context 'when game win' do
  let(:correct_code) { [1, 2, 3, 4] }
  let(:game) do
    Codebreaker::GameProcess.new({ difficulty: :easy,
                                   player_name: 'Boris',
                                   secret_code: correct_code })
  end

  before do
    game.instance_variable_set(:@guess_code, game.secret_code)

    env('rack.session', game: game)
  end
end
