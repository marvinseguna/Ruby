#ToDo
# get_starting_point => [x, y]
# storage_spaces => support incremental value
# puts the maze each time on screen for every keystroke

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
			current_map.push line.split
		end
	}
	maps
end

def check_move( movement, position, map )#check for storage, empty 
	x = position[0]
	y = position[1]

	return true		if ['.', ''].include? map[x][y]
	return false	if ['#', '*'].include? map[x][y]
	check_move movement, [x + movement[0], y + movement[1]], map #keep going in the direction until base case hits
end

def get_movement( input )
	return [-1, 0]		if input.downcase == 'w'
	return [0, -1]		if input.downcase == 'a'
	return [1, 0]		if input.downcase == 's'
	return [0, 1]		if input.downcase == 'd'
end

def get_cell_value( moving_object, current_value )
	if current_value == '' #open floor
		moving_object
	elsif current_value == '.' #storage
		moving_object == '@' ? '+' : '*'
	end
end

def update_map( movement, position, map )
	new_cell = [position[0] + movement[0], position[1] + movement[1]] #[x, y]
	new_cell_value = map[new_cell[0]][new_cell[1]]
	old_cell_value = map[position[0]][position[1]]
	
	update_map movement, new_cell, map		if !['.', ''].include? new_cell_value
	
	map[new_cell[0]][new_cell[1]] = get_cell_value old_cell_value, new_cell_value
	map[position[0]][position[1]] = get_cell_value old_cell_value
end

def play( map )
	position = get_starting_point map
	storage_spaces = get_storage_spaces map
	
	while true
		input = gets.chomp
		if input == 'q' #quit
			puts 'Ok bye!'
			break
		elsif input == 'u' #undo move
		else
			movement = get_movement input
			valid_move = check_move movement, position, map
			if valid_move
				map = update_map movement, position, map
				position[0] += movement[0]
				position[1] += movement[1]
			end
		end
	end
end


# maps = load_maps
# play maps[0]