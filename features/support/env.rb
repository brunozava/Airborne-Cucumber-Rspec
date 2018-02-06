require 'airborne'
require 'faker'

include Airborne

Airborne.configure do |c|
    c.base_url = 'https://nloja.herokuapp.com'
    c.headers = {
      content_type: 'application/json'
    }
end