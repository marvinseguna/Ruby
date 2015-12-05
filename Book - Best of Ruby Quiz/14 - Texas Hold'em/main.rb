require 'game_gen'
require 'poker_scores'
require 'printing'

RANKS = { 'rf' => 900, 'sf' => 800, 'fk' => 700, 'fh' => 600, 'fl' => 500, 'st' => 400, 'tk' => 300, 'tp' => 200, 'pa' => 100, 'hc' => 0}

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
	return 'pa'		if ps.is_pair hand
	return 'hc'
end

def assign_score( hands )
	scores = {}
	hands.each{ |hand|
		if hand.strip.length < 20 #fold
			scores[hand] = -1
		else
			scores[hand] = RANKS[rank_hand hand]
		end
	}
	scores
end

def high_card_duplicates( hands )
	duplicates = hands.select{ |key, val| hands.values.count( val ) > 1 and val != -1 }
	return hands		if duplicates.empty? or duplicates.values.uniq == [-1] #no duplicates or folded

	ps = PokerScores.new
	duplicates.each{ |key, value| 
		hands[key] = value + ps.get_high_card( key )
	}
	hands
end

ranked_hands = assign_score gen_hands #array
ranked_hands = high_card_duplicates ranked_hands
output ranked_hands