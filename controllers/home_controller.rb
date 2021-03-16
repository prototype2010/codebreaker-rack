class Home < BaseController
  include Codebreaker::Validation

  attr_reader :name, :difficulty

  def get
    render
  end

  def post
    validate_params
    return render unless @errors.empty?

    secret_code = Codebreaker::CodeGenerator.generate_by_defaults
    @request.session[:game] = Codebreaker::GameProcess.new({ difficulty: @difficulty,
                                                             player_name: @name,
                                                             secret_code: secret_code })

    Rack::Response.new do |response|
      response.redirect(Constants::GAME_PATH)
    end
  end

  private

  def validate_params
    @name = @request.params['name']
    @difficulty = @request.params['difficulty'].to_sym

    errors.push('Param `name` not found') unless @name
    errors.push('Param `difficulty` not found') unless @difficulty

    validate_player_name(name)
    validate_player_difficulty(difficulty)
  end

  def validate_player_name(name)
    validate_name(name)
  rescue Codebreaker::Exceptions::NameValidationError => e
    @errors.push(e.message)
  end

  def validate_player_difficulty(difficulty)
    validate_difficulty(difficulty.to_sym)
  rescue Codebreaker::Exceptions::WrongDifficultyError => e
    @errors.push(e.message)
  end
end
