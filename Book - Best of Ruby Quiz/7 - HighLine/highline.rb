class Highline
	
	def ask( question, type, filters = nil )
		puts question
		response = gets.chomp
	
		case type
		when :integer
			return handle_integer response, filters
		end
	end
	
	def self.handle_integer( response, filters )
		return true
	end
	
end