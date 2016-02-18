require 'rubygems'
require 'sinatra'
require 'sinatra/cookies'
require 'helper'
require 'json'

before do
	@users = []
end

get "/" do
	content_type 'html'
	erb :index
end

get "/GetPreviousUsername" do
	user = ( cookies[ :name ] == nil ? "" : cookies[ :name ] )
	JSON.generate({ :previous_user => user })
end

get "/GetAllUsers" do
	users = get_users
	JSON.generate({ :all_users => users })
end

get "/SaveMood" do
	username = params[ 'username' ]
	mood = params[ 'mood' ]

	cookies[ :name ] = username
	if @users.empty?
		data = File.open( 'public/data.txt' ).read
		data.each_line do |line| #User: dd/mm/yyyy-hh:mm-M. M = mood
			@users.push line.split( ':' ).first
		end
	end
	
	if @users.include? username 
		save_existing_user_mood username, mood
	else 
		save_user_mood username, mood
	end
	JSON.generate({ :message => 'Thanks!' })
end