require 'value_to_english'

REDUCTIONS = { 10 => 2, 100 => 10, 1000 => 100, 10000 => 1000, 100000 => 10000, 1000000 => 100000, 10000000 => 1000000, 100000000 => 10000000, 1000000000 => 100000000, 10000000000 => 1000000000 }

def get_reduction( val )
	REDUCTIONS.each{ |key, value| return value		if val <= key }
end

def lowest_odd_number_to_10000000000
	lowest = 'z'
	val = 1
	while val < 10000000000
		string = num_divider val
		if ( lowest <=> string ) == 1 
			puts val
			lowest = string
			val += 2
		else
			val += get_reduction( val )
		end
	end
	lowest
end

puts lowest_odd_number_to_10000000000