NUM_TO_19 = { 0 => '', 1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four', 5 => 'five', 6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine', 10 => 'ten', 11 => 'eleven', 12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen', 15 => 'fifteen', 16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen', 19 => 'nineteen' }
NUM_TENS = { 20 => 'twenty', 30 => 'thirty', 40 => 'forty', 50 => 'fifty', 60 => 'sixty', 70 => 'seventy', 80 => 'eighty', 90 => 'ninety' }
NUM_LARGE = { 0 => '', 3 => 'thousand', 6 => 'million', 9 => 'billion', 12 => 'trillion', 15 => 'quadrillion', 18 => 'quintillion', 21 => 'sextillion', 24 => 'septillion', 27 => 'octillion', 30 => 'nonillion', 33 => 'decillion', 36 => 'undecillion', 39 => 'duodecillion',  42 => 'tredecillion', 45 => 'quattuordecillion', 48 => 'Quindecillion', 51 => 'sexdecillion', 54 => 'septendecillion', 57 => 'octodecillion', 60 =>'novemdecillion', 63 => 'vigintillion' } #always increases with 3 0's

def get_large_mapping( indicator )
	return 0		if indicator <= 1
	3 + get_large_mapping( indicator / 1000 )
end

def english_less_than_100( value, and_s = '' )
	return ''		if value == 0
	return and_s + NUM_TO_19[value]		if value < 20 
		
	div_2 = value.divmod 10
	and_s + NUM_TENS[div_2[0] * 10] + ( div_2[1] == 0 ? '' : '-' + NUM_TO_19[div_2[1]] )
end

def english_translator( value ) #value will always be 3-length or less
	return ''		if value == 0
	div = value.divmod 100
	
	if div[0] == 0 #value is less than 100
		english_less_than_100 value
	else
		string = NUM_TO_19[div[0]] + ' hundred '
		string + english_less_than_100( div[1] )
	end
end

def num_divider( value, divider = 1000, accumulated = 0 )
	return ''		if value - accumulated == 0
	return 'zero'	if value == 0
	
	number = ( value % divider ) - accumulated
	number /= ( divider / 1000 )		if divider > 1000 #201000 => 201
	
	string = ''
	if number != 0
		string = english_translator number
		string = ( string + " #{NUM_LARGE[get_large_mapping divider / 1000]} " ).split.join ' '
		string = ' ' + string		if value - ( accumulated + ( number * ( divider / 1000 )) ) != 0 and number != 0
	end
	
	accumulated += ( number * ( divider / 1000 ))
	divider *= 1000
	
	num_divider( value, divider, accumulated ) << string
end