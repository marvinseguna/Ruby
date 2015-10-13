def get_size( args )
	args[0] == '-s' ? args[1].to_i : 2
end

def get_numbers( args )
	args[0] == '-s' ? args[2] : args[0]
end

def define_array( size, numbers )
	Array.new(3 + (2 * size)) { Array.new(numbers.to_s.length * (3 + size), 0) }
end

def fill_array( display, size, numbers )
	representations = ['1110111', '0010010', '1011101', '1011011',  '0111010', '1101011', '1101111', '1010010', '1111111', '1111010']
	current_number = 0
	x = 0
	y = 0
				
	numbers.each_char{ |number| 
		pos = 1
		bits = representations[number.to_i]
		bits.to_s.each_char{ |bit| 
			if [1, 4, 7].include? pos
				x = [1, 4, 7].index pos #either 0,1 or 2
				(0..size - 1).each{ |i| display[x * (size + 1)][(current_number * (size + 3)) + 1 + i] = '-' } if bit == '1'
			else
				[[2, 5], [3, 6]].each { |arr| y = [[2, 5], [3, 6]].index(arr) if arr.include? pos }
				[[2, 3], [5, 6]].each { |arr| x = [[2, 3], [5, 6]].index(arr) if arr.include? pos }
				(0..size - 1).each{ |i| display[1 + (x * (size + 1)) + i][(current_number * (size + 3)) + (y * (size + 1))] = '|' } if bit == '1'
			end
			pos += 1
		}
		current_number += 1
	}
	display
end

def format_display( display )
	display.each{ |array|
		s = ""
		array.each{ |inside_array| s << inside_array }
		puts s
	} 
end

def main( args )
	size = get_size args			#2
	numbers = get_numbers args		#1378
	display = define_array size, numbers
	
	display = fill_array display, size, numbers
	format_display display
end

main ARGV