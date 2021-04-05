class BaseController
  include RequestUtils
  include GameUtils

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
end
