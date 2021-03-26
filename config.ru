require_relative './initializer'

use Rack::Reloader, 0
use Rack::Static, urls: ['/assets'], root: 'public'
use Rack::Session::Cookie, key: 'rack.session',
                           domain: 'https://evening-meadow-15263.herokuapp.com/',
                           path: Constants::HOME_PATH,
                           expire_after: 2_592_000,
                           secret: 'change_me',
                           old_secret: 'also_change_me'

use RedirectToFinalGamePage
use RedirectToActiveGame
use RedirectHomeUnlessHaveGame

run Router
