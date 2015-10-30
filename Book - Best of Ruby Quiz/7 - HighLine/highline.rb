class String
	def is_not_an_integer
		(self =~ /\A[-+]?[0-9]+\z/) == nil
	end
	
	def is_not_a_float
		 false		if Float self		rescue true
	end
	
	def does_not_have_all( filters )
		filters.each{ |filter| 
			found = false
			case filter
			when :upper
				self.each_char{ |c| found = true		if c == c.upcase }
			when :lower
				self.each_char{ |c| found = true		if c == c.downcase }
			when :number
				self.each_char{ |c| found = true		if ( c =~ /\d/ ) != nil }
			end
			return true		if !found
		}
		false
	end
end

class Highline
	
	def get_user_response( question )
		puts question
		return gets.chomp
	end
	
	def ask( question, type, filters = nil )
		response = get_user_response question
		
		case type
		when :integer
			return handle_integer response, filters
		when :string
			return handle_string response, filters
		end
	end
	
	def handle_integer( response, filters = nil )
		raise ArgumentError, "Value [#{response}] is not of type integer!"		if response.is_not_an_integer
		
		if [:odd, :even].include? filters
			raise ArgumentError, "Value [#{response}] is not #{filters.to_s}!"		if !response.to_i.send( filters.to_s + '?' )
		end
		
		if filters.class == Hash
			case filters.keys.join.to_sym
			when :within
				raise ArgumentError, "Value does not fall within range [#{response}]!"		if !filters[:within].cover? response.to_i
			when :greater
				raise ArgumentError, "Value [#{response}] must be greater than #{filters[:greater]}!"		if response.to_i <= filters[:greater]
			when :smaller
				raise ArgumentError, "Value [#{response}] must be smaller than #{filters[:smaller]}!"		if response.to_i >= filters[:smaller]
			end
		end
		true
	end
	
	def handle_string( response, filters = nil)
		
		if filters.class == Hash
			case filters.keys.join.to_sym
			when :exclude
				raise ArgumentError, "String contains undesirable characters!"		if filters[:exclude].any? { |c| response.include? c }
			when :include
				raise ArgumentError, "String character requirements not met!"		if response.does_not_have_all filters[:include]
			when :length
				raise ArgumentError, "String does not have required length"			if response.length != filters[:length]
			when :validate
				raise ArgumentError, "String does not match with the regex"			if ( response =~ filters[:validate] ) == nil
			end
		end
	
		true
	end
	
	def handle_float( response, filters = nil )
		raise ArgumentError, "Provided string is not a float"		if response.is_not_a_float
		
		true
	end
	
	def ask_if( question )
		response = get_user_response question + " (y/n)"
		return true		if response.downcase == 'y'
		false
	end
	
end