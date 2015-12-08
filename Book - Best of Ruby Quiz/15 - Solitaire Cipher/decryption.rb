require 'encryption'

def subtract_arrays( arr_1, arr_2 )
	[arr_1, arr_2].transpose.map{ |x| x.reduce( :- ) + ( 26 * ( ( x[0] <= x[1] ) ? 1 : 0 )) }
end

def decrypt( sequence )
	key = keystream sequence
	
	num_seq = convert_letters sequence
	num_key = convert_letters key #converted both to array of integers
	
	num_both = subtract_arrays num_seq, num_key #subtracting 2 arrays
	
	num_both.map{ |val| VALUE_TO_LETTERS[val] }.join.scan(/.{1,5}/).join ' '
end

# puts decrypt 'CLEPK HHNIY CFPWH FDFEH'
# puts decrypt 'ABVAW LWZSY OORYK DUPVH'