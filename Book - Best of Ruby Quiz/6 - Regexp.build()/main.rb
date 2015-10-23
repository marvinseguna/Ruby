#NOT FINISHED

class Regexp
	def self.build( *params )
		params.each{ |param| 
			if param.class == Range
				new_lower_bound = self.process_lower param.first, param.last
			end
		}
	end
	
	def self.process_lower( lower_bound, upper_bound )
		transformation = ""
		lower_bound_length = lower_bound.to_s.length
		
		(lower_bound_length - 1).downto(0) { |i|
			break if i == 0
			last_number = lower_bound.to_s[i]
			
			if last_number != 0
				to_round = "1" + ("0" * (lower_bound_length - i)) #E.g 10
				incremental_5 = 5 * (to_round.to_i / 10)
				rounding = "-#{lower_bound_length - i}".to_i
				new_number = (lower_bound + incremental_5).round(rounding)
				
				break if new_number > upper_bound
				#regex should go here!!!!!!!
				lower_bound = new_number
			end
		}
		lower_bound
	end
end

class String
	alias_method :old, :=~

	def =~( param )
		(old param) == nil ? (puts "false") : (puts "true")
	end
end

def main
	lucky = Regexp.build(255..526)
end


main
#time = Regexp.build(0..23)