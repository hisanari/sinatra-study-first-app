
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'post.sqlite3')

class Post < ActiveRecord::Base
end
