require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "sinatra/json"
require "sinatra/content_for"
require "./models/post.rb"
require "json"
require "open-uri"
require "dotenv"
require "rack-flash"

enable :sessions
use Rack::Flash

# openWeathermapAPIのアドレス
TENKI_BASE_URL = "https://api.openweathermap.org/data/2.5/weather"

# 最初のページ
get '/' do
	@title = "home"
	@time_now = Time.now

	# openWeathermapAPIのAPIキーを呼び出す
	Dotenv.load

	# 取得する
	response_tokyo = open(TENKI_BASE_URL + "?q=Tokyo,jp&APPID=#{ENV["TENKI_API_KEY"]}")
	response_newyork = open(TENKI_BASE_URL + "?q=newyork&APPID=#{ENV["TENKI_API_KEY"]}")
	@tokyo = JSON.parse(response_tokyo.read)
	@newyork = JSON.parse(response_newyork.read)

	erb :home
end

# メッセージを送るページ
get '/message' do
	@title = "message"
	@message = ""

	erb :message
end

# メッセージを送るとなんでやねんしてくれる
post '/message' do
	@title = "message"
	message = params[:message]

	if message == ""
		@message = "なんやねん。。"
	else
		@message = "なんで" + message + "やねん！"
	end

	erb :message
end

# コメントをDBに保存するページ
get '/comment' do
	@title = "コメント"
	@post = Post.all.order('created_at DESC')
	erb :comment
end

# コメントを新しく作る
post '/new' do
	post = Post.new
	post.comment = params[:comment]

	unless post.comment.empty? then
		flash[:succese] = "投稿しました。"
		post.save
	end

	redirect '/comment'

end

# コメントを削除する
delete '/delete/:id' do
	Post.find_by(:id => params[:id]).destroy

	flash[:warning] = "削除しました！"

	redirect '/comment'
end
