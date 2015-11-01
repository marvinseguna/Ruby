#NOT FINISHED

ROMAN_LETTERS = { :I => 1, :V => 5, :X => 10, :L => 50, :C => 100, :D => 500, :M => 1000 }

class String
	def is_not_an_integer
		( self =~ /^-?\d*$/ ) == nil
	end
end

def get_splitted_value( number ) #Return: array
	number = number.to_s
	raise ArgumentError, 'Invalid argument [get_splitted_value]'		if number.is_not_an_integer
	
	splitted_values = []
	for i in 0..number.length - 1
		splitted_values.push number[i] + ( '0' * ( number.length - 1 - i )) # 256 => ['200', '50', '6']
	end
	splitted_values
end

def get_roman_value( arabic )
	raise ArgumentError, 'Invalid argument [get_roman_value]'		if arabic.to_s.is_not_an_integer
	raise ArgumentError, 'Invalid argument [get_roman_value]'		if arabic.to_i <= 0
	multiple = '1' +  '0' * ( arabic.to_s.length - 1 )
	raise ArgumentError, 'Invalid argument [get_roman_value]'		if arabic.to_i % multiple.to_i != 0
	
	roman_keys = ROMAN_LETTERS.keys.reverse
	index = 0
	# while arabic > 0
		# arabic_clone = arabic - ROMAN_LETTERS[roman_keys[index]]
		# reduction_check arabic_clone		if arabic_clone < 0
	# end
end

def reduction_check( arabic, roman_letters )
	raise ArgumentError, 'Invalid argument [reduction_check]'		if arabic.to_s.is_not_an_integer
	raise ArgumentError, 'Invalid argument [reduction_check]'		if arabic.to_i >= 0
	
	roman_letters.each{ |letter|
		return letter.to_s		if arabic + ROMAN_LETTERS[letter] == 0
	}
	return ''
end