class BaseMiddleware
  def initialize(app)
    @app = app
  end

  def init_request_params(env)
    @env = env
    @request = Rack::Request.new(@env)
    @game = @request.session[:game]
    @path = @request.path
  end

  def call(env)
    init_request_params(env)

    response = proceed
    return call_next if response.nil?

    response
  end

  def redirect(path)
    [301, { 'Location' => path }, ['']]
  end

  def call_next
    @app.call(@env)
  end

  def game_route?
    [Constants::LOSE_GAME_PATH, Constants::WIN_GAME_PATH, Constants::GAME_PATH].include?(@path)
  end

  protected

  def proceed
    raise NotImplementedError('Should be overridden by child class')
  end
end
