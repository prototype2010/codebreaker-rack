module RequestUtils
  def request_method
    @request.request_method.downcase.to_sym
  end
end
