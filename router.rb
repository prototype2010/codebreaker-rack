class Router
  include RequestUtils

  ROUTES = [
    Home.new(Constants::HOME_PATH, Constants::HOME_VIEW),
    Game.new(Constants::GAME_PATH, Constants::GAME_VIEW),
    WinGame.new(Constants::WIN_GAME_PATH, Constants::WIN_GAME_VIEW),
    LoseGame.new(Constants::LOSE_GAME_PATH, Constants::LOSE_GAME_VIEW),
    Statistics.new(Constants::STATISTICS_PATH, Constants::STATISTICS_VIEW),
    Rules.new(Constants::RULES_PATH, Constants::RULES_VIEW)
  ].freeze

  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def response
    route = request_route
    # rubocop:disable Lint/RedundantSafeNavigation
    return Rack::Response.new('Page not found', 404) unless route&.respond_to?(request_method)

    # rubocop:enable Lint/RedundantSafeNavigation
    route.respond(@request)
  end

  def request_route
    ROUTES.find { |route| route.path == @request.path }
  end
end
