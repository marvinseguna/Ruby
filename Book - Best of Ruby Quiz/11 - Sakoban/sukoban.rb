#ToDo
# Brush code

# @ - man
# # - wall
# . - storage
# o - crates
#   - open floor
# * - crate on storage
# + - man on storage
def load_maps
	maps = []
	current_map = []
	File.readlines( 'levels.txt' ).each{ |line| 
		if line.length == 1
			maps.push current_map
			current_map = []
		else
			current_map.push line.split ''
		end
	}
	maps
end

def check_move( movement, position, map )#check for storage, empty 
	x = position[0]
	y = position[1]
	
	return true		if ['.', ' '].include? map[x][y]
	return false	if map[x][y] == '#'
	check_move movement, [x + movement[0], y + movement[1]], map #keep going in the direction until base case hits
end

def get_movement( input )
	return [-1, 0]		if input.downcase == 'w'
	return [0, -1]		if input.downcase == 'a'
	return [1, 0]		if input.downcase == 's'
	return [0, 1]		if input.downcase == 'd'
end

def get_next_cell_value( moving_object, current_value ) #current value of new cell
	if current_value == ' ' #open floor
		return '@'		if moving_object == '+'
		return 'o'		if moving_object == '*'
		return moving_object
	elsif current_value == '.' #storage
		return moving_object		if ['+', '*'].include? moving_object
		moving_object == '@' ? '+' : '*'
	end
end

def get_old_cell_value( old_cell )
	( ['*', '+'].include? old_cell ) ? '.' : ' '
end

def update_map( movement, position, map )
	new_cell = [position[0] + movement[0], position[1] + movement[1]] #[x, y]
	new_cell_value = map[new_cell[0]][new_cell[1]]
	old_cell_value = map[position[0]][position[1]]
	
	map = update_map movement, new_cell, map		if !['.', ' '].include? new_cell_value
	new_cell_value = map[new_cell[0]][new_cell[1]]
	
	map[new_cell[0]][new_cell[1]] = get_next_cell_value old_cell_value, new_cell_value
	map[position[0]][position[1]] = get_old_cell_value old_cell_value
	return map
end

def get_starting_point( map )
	row = map.detect{ |aa| aa.include?('@')}
	return [ map.index(row), row.index('@') ]		if row != nil
end

def remaining_storage_spaces( map )
	map.detect{ |aa| aa.include?('.')} == nil ? false : true
end

def show( map )
	map.each{ |value| 
		puts "\n"
		value.each{ |val| print val }
	}
end

def play_next_map( maps, level )
	level = level + 1
	puts "\nYou passed level #{level}!\nWould you like to play next map? (y/n)"
	return		if gets.chomp == 'n'
	play maps, level
end

def play( maps, level = 0 )
	puts "\na => left\nw => up\nd => right\ns => down\nq => quit"
	map = maps[level]
	position = get_starting_point map
	
	while true
		show map
		
		input = gets.chomp[0] #in case user enters more than 1 character
		if input == 'q' #quit
			puts 'Ok bye!'
			return
		else
			movement = get_movement input
			valid_move = check_move movement, position, map
			if valid_move
				map = update_map movement, position, map
				position[0] += movement[0]
				position[1] += movement[1]
			end
			break		if !remaining_storage_spaces map
		end
	end
	
	play_next_map maps, level
end

play load_maps