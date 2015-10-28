def get_size( args )
	args[0] == '-s' ? args[1].to_i : 2
end

def get_numbers( args )
	args[0] == '-s' ? args[2] : args[0]
end

def init_array( size, numbers )
	Array.new(3 + (2 * size)) { Array.new(numbers.to_s.length * (3 + size), 0) }
end

def vertical(x, size, i, current_number, y) #place | in array, depending on current position
	@display[1 + (x * (size + 1)) + i][(current_number * (size + 3)) + (y * (size + 1))] = '|'
end

def horizontal( x, size, current_number, i ) #place - in array
	@display[x * (size + 1)][(current_number * (size + 3)) + 1 + i] = '-' 
end

def fill_array( size, numbers )
	representations = ['1110111', '0010010', '1011101', '1011011',  '0111010', '1101011', '1101111', '1010010', '1111111', '1111010']
	horizontals = [1, 4, 7]
	verticals_y = [[2, 5], [3, 6]]
	verticals_x = [[2, 5], [3, 6]]
	current_number = 0
	x = 0
	y = 0
				
	numbers.each_char{ |number| 
		pos = 1
		bits = representations[number.to_i]
		bits.to_s.each_char{ |bit| 
			if horizontals.include? pos
				x = horizontals.index pos #either 0,1 or 2
				(0..size - 1).each{ |i| horizontal x, size, current_number, i } if bit == '1'
			else
				verticals_y.each { |arr| y = verticals_y.index(arr) if arr.include? pos }
				verticals_x.each { |arr| x = verticals_x.index(arr) if arr.include? pos }
				(0..size - 1).each{ |i| vertical x, size, i, current_number, y } if bit == '1'
			end
			pos += 1
		}
		current_number += 1
	}
end

def format_display
	@display .each{ |array|
		s = ""
		array.each{ |inside_array| s << inside_array }
		puts s
	} 
end

size = get_size ARGV			#2
numbers = get_numbers ARGV		#1378
@display = init_array size, numbers

fill_array size, numbers
format_display