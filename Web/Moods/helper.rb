def get_users
	File.read( 'public/data.txt' ).split( "\n" )
end

def get_mood_data( users, start_date )
	mood_data = {}
	users.each{ |user| 
		user_data = []
		File.read( "public/#{user}.txt" ).split( "\n" ).each{ |daily_info|
			file_date = daily_info.split( ',' ).first.to_i
			if file_date >= start_date
				hour = daily_info.split( ',' )[ 1 ].to_i
				hour = ( "0900" if hour < 1300 ) || ( 1300 if hour < 1700) || 1700
				
				mood = daily_info.split( ',' ).last
				
				user_data.push "#{file_date}|#{hour}|#{mood}"
			end
		}
		puts user_data
		mood_data[ user ] = user_data
	}
	mood_data
end

def save_existing_user_mood( username, mood )
	text = File.open( 'public/data.txt' ).read
	line_to_append = ''
	
	text.each_line do |line| #User: dd/mm/yyyy-hh:mm-M. M = mood
		user = line.split( ':' ).first
		if user == username
			line_to_append = line.strip #cut out carriage return
			break
		end
	end
	
	new_data = Time.now.strftime( "%d/%m/%Y-%H:%M" ) + '-' + mood[ 0 ]
	new_text = text.gsub line_to_append, line_to_append + ", #{new_data}"
	File.open( 'public/data.txt', "w" ) { |file| file.puts new_text }
end

def save_user_mood( username, mood )
	new_line = "#{username}: #{Time.now.strftime( "%d/%m/%Y-%H:%M" )}-#{mood[ 0 ]}"
	File.open( 'public/data.txt', "a+" ) { |file| file.puts new_line }
end