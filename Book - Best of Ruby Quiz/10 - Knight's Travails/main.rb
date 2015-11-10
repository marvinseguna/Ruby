#to implement:
#prohibited locations

MAPS_LETTERS = { 'A' => 0, 'B' => 1, 'C' => 2, 'D' => 3, 'E' => 4, 'F' => 5, 'G' => 6, 'H' => 7 }

def get_destination( cell )
	( 8 - cell[1].to_i ) * 10 + MAPS_LETTERS[cell[0].upcase]
end

def get_cell_name( cell_number )
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
		valid_moves.push x_move * 10 + y_move		if (0..7).include? x_move and (0..7).include? y_move
	}
	valid_moves
end

def get_F( cell, g )
	x = cell / 10
	y = cell % 10
	@h[x][y] + g
end

def get_final_path( cell )
	final = "#{get_cell_name cell}"
	cell = @open_list[cell][0]
	final = "#{get_cell_name cell}," + final
	while( true )
		final = "#{get_cell_name @closed_list[cell][0]}," + final
		cell = @closed_list[cell][0]
		break		if @closed_list[cell] == nil
	end
	final
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
	val_with_lowest_F = @open_list.sort_by{ |key, value| value[1] }.first[0]
	
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
puts get_final_path ending