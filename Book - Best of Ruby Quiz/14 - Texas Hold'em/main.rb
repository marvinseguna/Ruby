require 'game_gen'

def is_royal_flush( hand )
end

def is_straight_flush( hand )
end

def is_four_of_a_kind( hand )
end

def is_full_house( hand )
end

def is_flush( hand )
end

def is_straight( hand )
end

def is_three_of_a_kind( hand )
end

def is_two_pair( hand )
end

def is_pair( hand )
end

def is_high_card( hand )
end

def assign_scores( hands, scores )
	hands.each.with_index{ |hand, index| 
		next		if hand.length < 7
		
		scores[index] = 99999999 and return 		if is_royal_flush hand
		
	}
end

def init_scores( length )
	h = Hash.new{ |hash, key| hash[key] = 0 }
	( 0..length - 1 ).each{ |index| hash[index] }
	h
end

hands = gen_hands #array
scores = init_scores hands.length
assign_scores hands, scores