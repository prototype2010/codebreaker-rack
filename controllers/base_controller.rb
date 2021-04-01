class BaseController
  include RequestUtils

  attr_reader :path, :template_path
  attr_accessor :request, :errors, :env

  def initialize(path, template_path)
    @path = path
    @template_path = template_path
    @request = nil
    @errors = []
  end

  def respond(request)
    @request = request
    response = send(request_method)

    @request = nil
    @errors = []

    response
  end

  protected

  def redirect(path)
    Rack::Response.new do |response|
      response.redirect(path)
    end
  end

  def render(status = 200)
    path = File.expand_path("./views/#{@template_path}")

    Rack::Response.new(ERB.new(File.read(path)).result(binding), status)
  end

  def render_partial(path)
    path = File.expand_path(path)
    ERB.new(File.read(path)).result(binding)
  end

  def secret_code
    game.secret_code
  end

  def game
    @request.session[:game]
  end

  def hints
    attempts_info[:hints]
  end

  def hints_shown
    game.hints_shown
  end

  def game_hash
    game.to_h
  end

  def attempts_info
    game_hash[:attempts_info]
  end

  def hints_total
    attempts_info[:hints_total]
  end

  def hints_left
    attempts_info[:hints].length
  end

  def attempts_total
    attempts_info[:attempts_total]
  end

  def attempts_left
    attempts_info[:attempts_left]
  end

  def difficulty
    game_hash[:difficulty]
  end
end
