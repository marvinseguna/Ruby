NUM_TO_19 = { 0 => 'zero', 1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four', 5 => 'five', 6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine', 10 => 'ten', 11 => 'eleven', 12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen', 15 => 'fifteen', 16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen', 19 => 'nineteen' }
NUM_TENS = { 20 => 'twenty', 30 => 'thirty', 40 => 'forty', 50 => 'fifty', 60 => 'sixty', 70 => 'seventy', 80 => 'eighty', 90 => 'ninety' }
NUM_LARGE = { 0 => '', 3 => 'thousand', 6 => 'million', 9 => 'billion', 12 => 'trillion', 15 => 'quadrillion', 18 => 'quintillion', 21 => 'sextillion', 24 => 'septillion', 27 => 'octillion', 30 => 'nonillion', 33 => 'decillion', 36 => 'undecillion', 39 => 'duodecillion',  42 => 'tredecillion', 45 => 'quattuordecillion', 48 => 'Quindecillion', 51 => 'sexdecillion', 54 => 'septendecillion', 57 => 'octodecillion', 60 =>'novemdecillion', 63 => 'vigintillion' } #always increases with 3 0's

def get_large_mapping( indicator )
	return 0		if indicator <= 1
	3 + get_large_mapping( indicator / 1000 )
end

def english_translator( value )
	
end


def num_divider( value, divider = 1000, accumulated = 0 )
	return ''		if value - accumulated == 0
	
	number = ( value % divider ) - accumulated
	number /= ( divider / 1000 )		if divider > 1000 #201000 => 201
	
	string = english_translator number
	string << " #{NUM_LARGE[get_large_mapping divider / 1000]} "
	
	accumulated += number
	divider *= 1000
	value -= divider
	string << num_divider( value, divider, accumulated )
end