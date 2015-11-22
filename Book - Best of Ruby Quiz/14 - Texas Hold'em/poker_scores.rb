INDEX_RANKING = { '2' => 0, '3' => 1, '4' => 2, '5' => 3, '6' => 4, '7' => 5, '8' => 6, '9' => 7, 'T' => 8, 'J' => 9, 'Q' => 10, 'K' => 11, 'A' => 12 }

def is_royal_flush( hand )
	['d', 's', 'c', 'h'].each{ |c|
		return true => c		if hand.scan(/([a-z]#{c})/i).length == 5
	}
	false
end

def is_straight_flush( hand )
	['d', 's', 'c', 'h'].each{ |c, occur_5 = []|
		if hand.count( c ) == 5 
			hand.split.each{ |val| occur_5.push INDEX_RANKING[val[0]]		if val.include? c }
			return occur_5.sort.each_cons(2).all?{ |a,b| b = a + 1 } => occur_5
		end
	}
	false
end

def is_four_of_a_kind( hand )
	INDEX_RANKING.keys.each{ |face| 
		return true => face		if hand.scan(/#{face}[dsch]/i).length == 4
	}
	false
end

def is_full_house( hand )
end

def is_flush( hand )
	['d', 's', 'c', 'h'].each{ |c|
		return true => c		if hand.scan(/([a-z0-9]#{c})/i).length == 5
	}
	false
end

def is_straight( hand )
end

def is_three_of_a_kind( hand )
	INDEX_RANKING.keys.each{ |face| 
		return true => face		if hand.scan(/#{face}[dsch]/i).length == 3
	}
	false
end

def is_two_pair( hand )
end

def is_pair( hand )
	INDEX_RANKING.keys.each{ |face| 
		return true => face		if hand.scan(/#{face}[dsch]/i).length == 2
	}
	false
end

def is_high_card( hand )
end