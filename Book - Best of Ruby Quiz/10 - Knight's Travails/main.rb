#to implement:
#get_F
#prohibited locations

MAPS_LETTERS = { 'A' => 0, 'B' => 1, 'C' => 2, 'D' => 3, 'E' => 4, 'F' => 5, 'G' => 6, 'H' => 7 }

def get_destination( cell )
	( 8 - cell[1].to_i ) * 10 + MAPS_LETTERS[cell[0].upcase]
end

def get_cell_names( cell_number )
	x = cell_number / 10
	y = cell_number % 10
	
	MAPS_LETTERS.key(y).downcase + (8 - x).to_s
end

def set_H( ending )# 8x8 board. H - distance each cell has from end point
	@h = []
	x = ending / 10
	y = ending % 10
	
	( 0..7 ).each{ |i| 
		@h.push []
		( 0..7 ).each { |j| 
			@h[i].push ( x - i ).abs + ( y - j ).abs
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
		valid_moves.push x_move * 10 + y_move		if x_move >= 0 and y_move >= 0 and x_move < 8 and y_move < 8
	}
	valid_moves
end

def get_F( cell, g )
	x = cell / 10
	y = cell % 10
	@h[x][y] + g
end

def get_lowest_F( open_list = @open_list )
	lowest = 9999
	cell = 0
	open_list.each{ |key, value|
		if value[1] < lowest
			lowest = value[1]
			cell = key
		end
	}
	cell
end

def get_final_path( cell )
	list = [cell]
	cell = @open_list[cell][0]
	list.push cell
	g = 9999
	while( true )
		list.push @closed_list[cell][0]
		cell = @closed_list[cell][0]
		break		if @closed_list[cell] == nil
		g = @closed_list[cell][1]		
	end
	list
end

def find_target( starting, ending, g = 0 )
	return		if starting == ending #Base case
	childs = get_valid_moves starting
	
	childs.each{ |cell|
		if @open_list.keys.include? cell
			@open_list[cell] = [ starting, g + 3, get_F( cell, g + 3 )]		if g + 3 < @open_list[cell][1]
		elsif @closed_list.keys.include? cell
			childs.delete cell
		else
			@open_list[cell] = [ starting, g + 3, get_F( cell, g + 3 )]
		end
	}
	
	@closed_list[starting] = @open_list[starting]
	@open_list.delete starting
	val_with_lowest_F = get_lowest_F 
	
	find_target val_with_lowest_F, ending, @open_list[val_with_lowest_F][1]
end


#prep
@open_list = {}
@closed_list = {}

starting = get_destination ARGV[0]
ending = get_destination ARGV[1]
prohibited = []
for i in 2..ARGV.length - 1
	prohibited.push get_destination ARGV[i]
end
set_H ending
find_target starting, ending
final = get_final_path ending
proper_final = ""
final.reverse.each{ |value|
	proper_final <<  get_cell_names( value ) + ','
}
proper_final = proper_final[0..proper_final.length - 2]
puts proper_final