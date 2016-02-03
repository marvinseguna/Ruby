require 'rubygems'
require 'sinatra'
require 'sinatra/cookies'
require 'json'

get "/" do
	content_type 'html'
	erb :index
end

get "/happy" do
	"Happy!"
end

get "/sad" do
	"sad!"
end

get "/GetMachineUser" do
	user = cookies[ :name ]
	
	return JSON.generate({ :machine_user => user })		if user != nil
	""
end