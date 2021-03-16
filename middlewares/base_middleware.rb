class BaseMiddleware
  def redirect(path)
    [301, { 'Location' => path }, ['']]
  end
end
