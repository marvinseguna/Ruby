class String
	def is_not_an_integer
		(self =~ /\A[-+]?[0-9]+\z/) == nil
	end
	
	def does_not_have_all( filters )
		filters.each{ |filter| 
			found = false
			case filter
			when :upper
				self.each_char{ |c| found = true		if c == c.upcase }
				return true		if !found
			when :lower
				self.each_char{ |c| found = true		if c == c.downcase }
				return true		if !found
			when :number
				self.each_char{ |c| found = true		if ( c =~ /\d/ ) != nil }
				return true		if !found
			end
		}
		false
	end
end

class Highline
	
	def ask( question, type, filters = nil )
		puts question
		response = gets.chomp
	
		case type
		when :integer
			return handle_integer response, filters
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
			end
		end
	
		true
	end
	
end