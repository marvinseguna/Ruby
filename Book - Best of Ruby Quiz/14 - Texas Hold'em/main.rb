require 'game_gen'
require 'poker_scores'

RANKS = { 'rf' => 9, 'sf' => 8, 'fk' => 7, 'fh' => 6, 'fl' => 5, 'st' => 4, 'tk' => 3, 'tp' => 2, 'p' => 1}

def rank_hand( hand )
	ps = PokerScores.new

	return 'rf'		if ps.is_royal_flush hand
	return 'sf'		if ps.is_straight_flush hand
	return 'fk'		if ps.is_four_of_a_kind hand
	return 'fh'		if ps.is_full_house hand
	return 'fl'		if ps.is_flush hand
	return 'st'		if ps.is_straight hand
	return 'tk'		if ps.is_three_of_a_kind hand
	return 'tp'		if ps.is_two_pair hand
	return 'p'		if ps.is_pair hand
end

def assign_score( hands )
	hands.each{ |hand|
		next if hand.strip.length < 20 #fold
		
		puts "Hand is: #{hand} => #{rank_hand hand}"
	}
end

ranked_hands = assign_score gen_hands #array
