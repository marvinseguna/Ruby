require 'keystream'

LETTERS_TO_VALUE = { 'A' => 1, 'B' => 2, 'C' => 3, 'D' => 4, 'E' => 5, 'F' => 6, 'G' => 7, 'H' => 8, 'I' => 9, 'J' => 10, 'K' => 11, 'L' => 12, 'M' => 13,
	'N' => 14, 'O' => 15, 'P' => 16, 'Q' => 17, 'R' => 18, 'S' => 19, 'T' => 20, 'U' => 21, 'V' => 22, 'W' => 23, 'X' => 24, 'Y' => 25, 'Z' => 26 }

def split_sentence( sentence )
	sentence << 'X'		while sentence.length % 5 != 0
	sentence.scan(/.{1,5}/).join ' ' #split into chunks of 5
end

def convert_letters( sentence )
	sentence.gsub(' ', '').split("").map{ |i| LETTERS_TO_VALUE[i] }
end

def add_arrays( arr_1, arr_2 )
	[arr_1, arr_2].transpose.map{ |x| ( x.reduce( :+ ) - ( 26 * ( x.reduce( :+ ) / 26 ))) + ( 52 * ( x.reduce( :+ ) / 52 )) }
end

def get_letters( arr )
	arr.map{ |val| VALUE_TO_LETTERS[val] }.join.scan(/.{1,5}/).join ' '
end

def encrypt( sentence )
	new_sentence = sentence.scan(/([a-z]+)/i).join.upcase #eliminate symbols and upper case remaining
	
	splitted = split_sentence new_sentence
	key = keystream splitted
	
	num_orig = convert_letters splitted
	num_key = convert_letters key #converted both to array of integers

	num_both = add_arrays num_orig, num_key #adding 2 arrays

	get_letters num_both #translate values back to letters
end