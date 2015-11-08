#to implement:
#get_F
#prohibited locations

MAPS_LETTERS = { 'A' => 0, 'B' => 1, 'C' => 2, 'D' => 3, 'E' => 4, 'F' => 5, 'G' => 6, 'H' => 7 }
MAPS_NUMBERS = { '8' => 0, '7' => 1, '6' => 2, '5' => 3, '4' => 4, '3' => 5, '2' => 6, '1' => 7 }

def get_destination( cell )
	MAPS_NUMBERS[cell[1]] * 10 + MAPS_LETTERS[cell[0].upcase]
end

def set_H( ending )# 8x8 board. H - distance each cell has from end point
	@h = []
	x = ending / 10
	y = ending % 10
	
	( 0..7 ).each{ |i| 
		@h.push []
		( 0..7 ).each { |j| 
			@h[i].push ( x - j ).abs + ( y - i ).abs
		}
	}
	@h
end

def get_valid_moves( cell )
	x = cell / 10
	y = cell % 10
	valid_moves = []
	incrementals = [1, 2, -1, -2, -1, 2, 1, -2, 2, 1, -2, -1, -2, 1, 2, -1]
	( 0..incrementals.length - 1 ).step( 2 ).each{ |index|
		x_move = x + incrementals[index]
		y_move = y + incrementals[index + 1]
		valid_moves.push x_move * 10 + y_move		if x_move >= 0 and y_move >= 0
	}
	valid_moves
end

def find_target( starting, ending, g = 0, open_list = {}, closed_list = {} )
	return		if starting == ending #Base case
	childs = get_valid_moves starting
	
	childs.each{ |cell|
		if open_list.keys.include? cell
			open_list[cell] = [ starting, g + 3, get_F( g + 3 )]		if g + 3 < open_list[cell][1]
		elsif closed_list.include? cell
			childs.delete cell
		else
			open_list[cell] = [ starting, g + 3, get_F( g + 3 )]
		end
	}
	
	open_list.delete starting
	closed_list.push starting
	open_list = open_list.sort_by{ |key, values| values[1] }
	
	find_target open_list.keys.first, ending, pen_list.values.first[1], open_list, closed_list
end


#prep
starting = get_destination ARGV[0]
ending = get_destination ARGV[1]

prohibited = []
for i in 2..ARGV.length - 1
	prohibited.push get_destination ARGV[i]
end
find_target starting, ending