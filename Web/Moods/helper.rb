def get_users
	text = File.open( 'public/data.txt' ).read
	all_users = []
	
	text.each_line do |line| #User: dd/mm/yyyy-hh:mm-M. M = mood
		all_users.push line.split( ':' ).first
	end
	all_users
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