class String
	def strip #remove all spaces - used only in alias-case
		gsub(/\s+/, "")
	end
end

def extract_reqs #extracts all reqs for sentence
	keywords = @sentence.scan(/\(\(([a-zA-z\s:,]*)\)\)/)
	
	if keywords.empty?
		raise "Nothing to replace!"
	else
		keywords
	end
end

def check_hash( req, reusables ) #check if alias already exists
	return reusables.keys.include? req		unless reusables.empty?
	
	false
end

def ask( question, keyword, reusables ) #asks user for input [and inserts it in hash (if required)]
	puts question
	replacable = gets.chomp
	
	@sentence.sub! "((#{keyword}))", replacable
	reusables[keyword.strip.split(':')[0]] = replacable		if keyword.include? ':'
	reusables
end

def form_new_sentence( keywords ) #loops on each keyword for replacement
	reusables = {}
	
	keywords.each{ |keyword| 
		keyword = keyword.first
		req = keyword
		
		if keyword.include? ':'
			split_keyword = keyword.strip.split ':'
			if check_hash split_keyword[0], reusables #if alias already exists in hash
				raise "Error in sentence! Alias - #{split_keyword[0]} - already exists!" 
			end
			req = split_keyword[1]
		elsif not reusables.empty? and check_hash req, reusables #if alias is found in hash, no need to ask for user input
			@sentence.sub! "((#{req}))", reusables[req]
			next #substitute and return
		end
		
		reusables = ask "Provide #{req}", keyword, reusables
	}
	@sentence
end


@sentence = File.read "Resources/Gift_Giving.madlib"
keywords = extract_reqs 
puts form_new_sentence keywords

