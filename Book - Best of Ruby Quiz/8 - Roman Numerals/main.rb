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
	arabic = arabic.to_i
	raise ArgumentError, 'Invalid argument [get_roman_value]'		if arabic <= 0
	multiple = '1' +  '0' * ( arabic.to_s.length - 1 )
	raise ArgumentError, 'Invalid argument [get_roman_value]'		if arabic % multiple.to_i != 0
	
	roman_keys = ROMAN_LETTERS.keys.reverse
	roman_values = ROMAN_LETTERS.values
	index = 0
	roman = ''
	while arabic > 0
		if roman_values.include? arabic
			ROMAN_LETTERS.each{ |key, value| roman << key.to_s		if value == arabic }
			arabic = 0
			next
		end
	
		arabic_clone = arabic - ROMAN_LETTERS[roman_keys[index]]
		reduction = reduction_check arabic_clone, roman_keys		if arabic_clone < 0
	
		if reduction.to_s != ''
			roman << ( reduction + roman_keys[index].to_s )
			arabic = 0
		elsif arabic_clone < 0
			index = index + 1
		elsif arabic_clone >= 0
			arabic = arabic_clone
			roman << roman_keys[index].to_s
		end
	end
	roman
end

def reduction_check( arabic, roman_letters )
	raise ArgumentError, 'Invalid argument [reduction_check]'		if arabic.to_s.is_not_an_integer
	raise ArgumentError, 'Invalid argument [reduction_check]'		if arabic.to_i >= 0
	
	roman_letters.each{ |letter|
		return letter.to_s		if arabic + ROMAN_LETTERS[letter] == 0
	}
	return ''
end

roman = ''
get_splitted_value( 4999 ).each{ |value|
	roman << get_roman_value( value )
}
puts roman