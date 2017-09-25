require "./main"
require "minitest/autorun"
require "rack/test"

ENV['RACK_ENV'] = 'test'

class HomeTest < MiniTest::Test
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

	def test_my_default
		get '/'
		assert last_response.ok?
		assert_equal "home", doc.at_css('title').tex
	end
end
