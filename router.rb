class Router
  include RequestUtils

  ROUTES = [
    HomeController.new(Constants::HOME_PATH, Constants::HOME_VIEW),
    GameController.new(Constants::GAME_PATH, Constants::GAME_VIEW),
    WinGameController.new(Constants::WIN_GAME_PATH, Constants::WIN_GAME_VIEW),
    LoseGameController.new(Constants::LOSE_GAME_PATH, Constants::LOSE_GAME_VIEW),
    StatisticsController.new(Constants::STATISTICS_PATH, Constants::STATISTICS_VIEW),
    RulesController.new(Constants::RULES_PATH, Constants::RULES_VIEW)
  ].freeze

  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def response
    route = request_route
    return not_found unless route
    return not_found unless route.respond_to?(request_method)

    route.respond(@request)
  end

  def not_found
    Rack::Response.new('Page not found', 404)
  end

  def request_route
    ROUTES.find { |route| route.path == @request.path }
  end
end
