require "./main"
require "minitest/autorun"
require "rack/test"
require "minitest/reporters"

ENV['RACK_ENV'] = 'test'

MiniTest::Reporters.use!

class HomeTest < MiniTest::Test
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

	def test_my_default
		get '/'
		assertresponse :success
		assert last_response.body.include?('Now')
	end
end
