class BaseMiddleware
  def redirect(path)
    [301, { 'Location' => path }, ['']]
  end

  def request_params(env)
    @request = Rack::Request.new(env)
    @game = @request.session[:game]
    @path = @request.path
  end
end
