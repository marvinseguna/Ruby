require 'spam_filter'

dict = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine' 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen', 'twenty', 'twenty-one', 'twenty-two', 'twenty-three', 'twenty-four', 'twenty-five', 'twenty-six', 'twenty-seven', 'twenty-eight', 'twenty-nine', 'thirty']

def get_banned_words( list_of_words, banned_words = [] )
	
end

def check_dictionary( dictionary )
	if @filter.verify dictionary
		puts "Banned words: #{dictionary}"
		return false
	end
	return true		if !@filter.clean? dictionary.join ' ' 
	
	puts 'There are no banned words in the dictionary'
	return false
end

@filter = LanguageFilter.new ['three', 'four', 'seventeen', 'twenty-four', 'thirty'] #almost 17% of the words banned - book specifies 10%
list = get_banned_words		if !check_dictionary dict