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
		raise ArgumentError, "Value [#{response}] is not of type integer!" if ( response =~ /\A[-+]?[0-9]+\z/ ) == nil
		raise ArgumentError, "Value does not fall within range [#{response}]!" if filters.class == Hash and filters.keys.include? :within and !filters[:within].cover? response.to_i
		raise ArgumentError, "Value [#{response}] is not #{filters.to_s}!" if filters != nil and ['odd', 'even'].include? filters.to_s and !response.to_i.send(filters.to_s + "?")
		
		true
	end
	
end