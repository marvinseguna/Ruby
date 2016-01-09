require 'spam_filter'

dict = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen', 'twenty', 'twentyone', 'twentytwo', 'twentythree', 'twentyfour', 'twentyfive', 'twentysix', 'twentyseven', 'twentyeight', 'twentynine', 'thirty']

def get_banned_words( list_of_words, banned_words = [] )
	if list_of_words.size == 1
		banned_words.push list_of_words[0]
	else
		half = ( list_of_words.size / 2.0 ).round
		
		left = list_of_words[0..half-1]
		right = list_of_words[half..list_of_words.size]
		
		banned_words = get_banned_words left, banned_words		if !@filter.clean?( left.join ' ' )
		return banned_words		if @filter.verify banned_words
		banned_words = get_banned_words right, banned_words		if !@filter.clean?( right.join ' ' )
	end
	banned_words
end

def any?( dictionary ) #checks if whole dicitonary is banned or at least 1 word
	if @filter.verify dictionary
		puts "Banned words: #{dictionary}"
		return false
	end
	return true		if !@filter.clean?( dictionary.join ' ' )
	
	puts 'There are no banned words in the dictionary'
	return false
end

#17%
@filter = LanguageFilter.new ['three', 'four', 'seventeen', 'twentyfour', 'thirty'] #almost 17% of the words banned - book specifies 10%
list = get_banned_words dict		if any? dict
puts "\n---------------------\nBanned Words\n"
p list
puts "---------------------\nCalls made: #{@filter::clean_calls}\n---------------------"

#3%
@filter = LanguageFilter.new ['seventeen'] #almost 17% of the words banned - book specifies 10%
list = get_banned_words dict		if any? dict
puts "\n---------------------\nBanned Words\n"
p list
puts "---------------------\nCalls made: #{@filter::clean_calls}\n---------------------"