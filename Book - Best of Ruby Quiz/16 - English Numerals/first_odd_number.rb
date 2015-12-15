require 'value_to_english'

REDUCTIONS = { 100 => 2, 1000 => 100, 10000 => 1000, 100000 => 10000, 1000000 => 100000, 10000000 => 1000000, 100000000 => 10000000, 1000000000 => 100000000, 10000000000 => 1000000000 }

def lowest_odd_number_to_10000000000
	incrementor = 1
	num_lowest = 0
	str_lowest = 'z'
	val = 1
	
	while val < 10000000000
		val += 1 and next 		if val % 2 == 0

		if val > ( incrementor * 10 )
			incrementor *= 10
			val = num_lowest + incrementor
		end
		
		string = num_divider val
		if ( string <=> str_lowest ) == -1 #string is less than str_lowest
			num_lowest = val
			str_lowest = string
		end
		
		val += incrementor
	end
	str_lowest
end

puts lowest_odd_number_to_10000000000