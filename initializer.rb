require 'erb'
require 'delegate'
require 'bundler/setup'
require 'codebreaker'
require 'time'
require 'i18n'

I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]

require_relative './constants'
require_relative './utils/request_utils'
require_relative './utils/game_utils'

Dir['./controllers/*.rb'].sort.each { |file| require file }

require_relative './router'

Dir['./middlewares/*.rb'].sort.each { |file| require file }

