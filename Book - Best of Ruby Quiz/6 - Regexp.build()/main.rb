class Regexp
	def self.build( *params )
		@final_regex = '^('
		params.each{ |param| 
			if param.class == Range
				new_lower_bound = self.get_nearest "+", ">", param.first, param.last
				new_upper_bound = self.get_nearest "-", "<", param.last, new_lower_bound, 1
				
				self.match_bounds new_lower_bound - 1, new_upper_bound
			else
				self.insert_regex param.class, param
			end
		}
		return /#{@final_regex[0..@final_regex.length - 2]})$/
	end
	
	def self.get_nearest( op_5, op_comp, prim_bound, sec_bound, negation = 0 )
		bound_length = prim_bound.to_s.length
		
		(bound_length - 1).downto(0) { |i|
			break if i == 0
			
			if prim_bound.to_s[i].to_i != 0
				to_round = "1" + ("0" * (bound_length - i)) #E.g 10
				new_number = (prim_bound.method(op_5).(5 * (to_round.to_i / 10))).round "-#{bound_length - i}".to_i
				
				break if new_number.send(op_comp, sec_bound)
				
				if negation == 0
					self.insert_regex Range, prim_bound..new_number - 1
				else
					self.insert_regex Range, new_number..prim_bound
				end
				
				prim_bound = new_number - negation
			end
		}
		prim_bound
	end
	
	def self.match_bounds( lower_bound, upper_bound )
		while( upper_bound != lower_bound )
			new_number = upper_bound
			while( new_number >= lower_bound )
				new_number -= "1#{"0" * (upper_bound.to_s.length - 1)}".to_i
			end
			new_number += "1#{"0" * (upper_bound.to_s.length - 1)}".to_i
			
			self.insert_regex Range, (new_number + 1)..upper_bound
			
			upper_bound = new_number
		end
	end
	
	def self.process_range( first, second )
		for i in x..first.length - 1
			if first[i] == second[i]
				@final_regex << first[i]
			else
				@final_regex << "0*"	if first.length == 1
				if i == 0 and !first.length == 1
					@final_regex << "[#{first[i]}#{second[i]}]"
				else
					@final_regex << "[#{first[i]}-#{second[i]}]")
				end
			end
		end
	end
	
	def self.insert_regex( type, param )
		if type == Range
			first = param.first.to_s
			second = param.last.to_s
			x = 0
			if first.length != second.length
				@final_regex << "0*[#{second[0]}]*"
				first = "0#{first}"
				x += 1
			end
			
			process_range first, second
		else
			for i in 0..param.to_s.length - 1
				@final_regex << "[#{param.to_s[i]}]"
			end
		end
		
		@final_regex << "|"
	end
end

class String
	alias_method :old, :=~

	def =~( param )
		(old param) == nil ? (puts "false") : (puts "true")
	end
end

lucky = Regexp.build(3,7)
# month = Regexp.build(1..12)
# day = Regexp.build(1..31)
# year = Regexp.build(98,99,2000..2005)
# time = Regexp.build(0..23)

"7" =~ lucky
"13" =~ lucky