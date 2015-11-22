require 'game_gen'
require 'poker_scores'

RANKS = { 'rf' => 9, 'sf' => 8, 'fk' => 7, 'fh' => 6, 'fl' => 5, 'st' => 4, 'tk' => 3, 'tp' => 2, 'p' => 1}

def rank_hand( hand )
	rf = is_royal_flush hand
	puts rf
end

def assign_score( hands )
	hands.each{ |hand|
		next if hand.strip.length < 20 #fold
		hand = 'Ts Js Qs Ks 7h 3h As'		
		rank_hand hand
	}
end

ranked_hands = assign_score gen_hands #array
