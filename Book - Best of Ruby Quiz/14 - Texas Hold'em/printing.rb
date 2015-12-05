def output( ranked_hands )
	rankings = { 900..999 => 'Royal flush', 800..899 => 'Straight flush', 700..799 => 'Four of a kind', 600..699 => 'Full house', 500..599 => 'Flush', 400..499 => 'Straight', 300..399 => 'Three of a kind', 200..299 => 'Two pair', 100..199 => 'Pair' }

	ranked_hands = ranked_hands.sort_by{ |key, val| val }.reverse
	count = 1
	ranked_hands.each{ |key, value|
		hand_type = ''
		rankings.each{ |k, v| hand_type = v		if k.member? value  }
		
		if count == 1
			puts "#{count}: #{key} #{hand_type} (Winner)"
		else
			puts "#{count}: #{key} #{hand_type}"
		end
		count += 1
	}
end