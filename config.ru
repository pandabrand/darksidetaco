require './app'
require 'sprockets'

map '/assets'
  Application.assets
end

run Darksidetaco::App