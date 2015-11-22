require 'game_gen'
require 'poker_scores'

RANKS = { 'rf' => 9, 'sf' => 8, 'fk' => 7, 'fh' => 6, 'fl' => 5, 'st' => 4, 'tk' => 3, 'tp' => 2, 'p' => 1}

def rank_hand( hand )
	rf = is_royal_flush hand
end

def assign_score( hands )
	hands.each{ |hand|
		next if hand.length < 7 #fold
		
		hand.push rank_hand hand
	}
end

ranked_hands = assign_score gen_hands #array
