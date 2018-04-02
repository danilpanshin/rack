#require 'rack/console'
require_relative 'middleware/logger'
require_relative 'app'


######

use AppLogger
run App.new
