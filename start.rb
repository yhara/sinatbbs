require 'rubygems'
require 'sinatra'
require 'sequel'
Sequel::Model.plugin(:schema)

DB = Sequel.sqlite("comments.db")
class Comments < Sequel::Model
  set_schema do
    string :name
    string :title
    text :message
  end
end
Comments.create_table unless Comments.table_exists?

get '/' do
  @comments = Comments.all
  haml :index
end

put '/comment' do
  Comments.create({
    :name => request[:name],
    :title => request[:title],
    :message => request[:message],
  })

  redirect '/'
end
