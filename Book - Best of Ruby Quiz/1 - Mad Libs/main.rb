class String
	def strip
		gsub(/\s+/, "")
	end
end

def read_file( file )
	File.read(file)
end

def extract_fillings( sentence )
	keywords = sentence.scan(/\(\(([a-zA-z\s:,]*)\)\)/)
	keywords.empty? ? (raise "Nothing to replace!") : (keywords)
end

def check_hash( req, reusables )
	unless reusables.empty?
		return reusables.keys.include? req
	end
	false
end

def form_new_sentence( sentence, keywords )
	reusables = {}
	
	keywords.each{ |keyword| 
		add_hash = 0
		keyword = keyword.first
		req = keyword
		
		if keyword.include? ':'
			split_keyword = keyword.strip.split(':')
			raise "Error in sentence! Re-usable - #{split_keyword[0]} - already exists!" if check_hash split_keyword[0], reusables
			req = split_keyword[1]
			add_hash = 1
		elsif not reusables.empty?
			if check_hash req, reusables
				sentence = sentence.sub! "((#{req}))", reusables[req]
				next
			end
		end
		puts "Provide #{req}"
		replacable = gets.delete!("\r\n")
		sentence = sentence.sub! "((#{keyword}))", replacable
		reusables[keyword.strip.split(':')[0]] = replacable if add_hash == 1 
	}
	sentence
end


def main
	#sentence = read_file "Resources\\Gift_Giving.madlib"
	#sentence = read_file "Resources\\Lunch_Hungers.madlib"
	# sentence = read_file "Resources\\Wash_Face.madlib"
	sentence = read_file "Resources\\Owner.madlib"
	keywords = extract_fillings sentence
	puts form_new_sentence sentence, keywords
end

main

