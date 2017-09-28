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
		assert last_response.ok?
		assert_includes last_response.body, "Now"
	end

	def test_message
		get '/message'
		assert last_response.ok?
	end

	def test_post_message
		post '/message', :message => 'hello'
		assert_includes last_response.body, 'なんでhelloやねん'
		post '/message', :message => ''
		assert_includes last_response.body, 'なんやねん'
	end

end
