#NEED TO CLEAN CODE!!!!!

def encodings( letter )
	letter = letter.downcase

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
	matched = {}
	for i in 0..array.length - 1
		matched[i] = []
	end
	matched
end

def get_possibilities( dictionary, phone )
	phone_digits = phone.split '.'
	phone_lengths = phone_digits.map{ |digit| digit.length }
	matched = get_storage phone_digits
	almost = get_storage phone_digits
	
	File.readlines(dictionary).each{ |word| 
		word = word.chomp
		next		if !phone_lengths.include? word.length #performance #1

		number = encode word
		if phone_digits.include? number
			phone_digits.each.with_index{ |value, index| 
				matched[index].push word		if phone_digits[index] == number and !matched[index].include? word
			}
		else
			phone_digits.each.with_index{ |value, index| 
				next		if value.length != number.length
			
				consecutive = false
				no_match = false
				
				for i in 0..value.length - 1
					val = value[i]
					num = number[i]
					
					if val != num and consecutive
						no_match = true
						break
					elsif val != num and !consecutive
						consecutive = true
					elsif val == num
						consecutive = false
					end
				end
				almost[index].push word		if !no_match and !almost[index].include? word
			}
		end
	}
	puts "Daw kwazi!!!"
	puts almost
	puts "Dawn insta"
	puts matched
end

get_possibilities ARGV[2], ARGV[0]