require "sinatra"
require "pry"
require "sinatra/activerecord"
require_relative "app/models/television_show"

set :bind, '0.0.0.0'  # bind to all interfaces
set :views, File.join(File.dirname(__FILE__), "app/views")

get "/" do
  redirect "/television_shows"
end

get "/television_shows" do
  @shows = TelevisionShow.all
  erb :index
end

get "/television_shows/new" do
  @show = TelevisionShow.new
  erb :new
end

post "/television_shows" do
  @show = TelevisionShow.new(params[:television_show])

  if @show.save
    redirect "/television_shows"
  else
    @errors = " Error(s): #{@show.errors.full_messages}"
    erb :new
  end
end

get "/television_shows/:id" do
  @show = TelevisionShow.find(params[:id])
  erb :show
end

get "/television_shows/:id/edit" do
  @show = TelevisionShow.find(params[:id])
  erb :edit
end

post "/television_shows/:id" do
  @show = TelevisionShow.find(params[:id])
  @show.attributes = (params[:television_show])
  if @show.save
    redirect "/television_shows"
  else
    @errors = " Error(s): #{@show.errors.full_messages}"
    erb :edit
  end
end
