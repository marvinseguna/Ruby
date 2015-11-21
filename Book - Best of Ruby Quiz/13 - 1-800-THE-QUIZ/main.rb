require 'set'

def encodings( letter )
	return '2'		if ['a','b','c'].include? letter
	return '3'		if ['d','e','f'].include? letter
	return '4'		if ['g','h','i'].include? letter
	return '5'		if ['j','k','l'].include? letter
	return '6'		if ['m','n','o'].include? letter
	return '7'		if ['p','q','r','s'].include? letter
	return '8'		if ['t','u','v'].include? letter
	return '9'		if ['w','x','y','z'].include? letter
end

def encode( word, i = 0 ) #i = index
	return ''		if i == word.length
	return encodings( word[i] ) + encode( word, i + 1 )
end

def get_storage( array )
	h =  Hash.new{ |hash, key| hash[key] = Set.new } #default value
	( 0..array.length - 1 ).each{ |index| h[index] }
	h
end

def check_other( word, number, phone_digits )
	phone_digits.each.with_index{ |value, index| 
		next		if value.length != number.length
		insert = true
		
		for i in 0..value.length - 2
			if value[i] != number[i] and value[i + 1] != number[i + 1]
				insert = false
				break
			end
		end
		@others[index].add word		if insert
	}
end

def process( word, phone_digits )
	number = encode word
	index = phone_digits.index number
	
	if index != nil #matched
		@matched[index].add word
	else
		check_other word, number, phone_digits
	end
end

def read_dictionary( dictionary )
	phone_digits = ARGV[0].split '.' #873.7829
	phone_lengths = phone_digits.map{ |digit| digit.length }
	
	File.readlines(dictionary).each{ |word| 
		word = word.chomp.downcase
		next		if !phone_lengths.include? word.length #performance #1
		
		process word, phone_digits
	}
end

def print_phone
	r = Random.new
	x = ''
	@matched.each{ |key, value|
		if !@matched[key].empty?
			x << "#{@matched[key].to_a[r.rand 0..@matched[key].length - 1]}."
		else
			x <<  "#{@others[key].to_a[r.rand 0..@others[key].length - 1]}."
		end
	}
	puts x[0..x.length - 2]
end

#Hashes which hold the (possible) matches
@matched = get_storage ARGV[0].split '.'
@others = get_storage ARGV[0].split '.'

read_dictionary ARGV[2]
print_phone 
#sample input: 873.7829 -d Resources/dictionary.txt