index_ranking = { '2' => 0, '3' => 1, '4' => 2, '5' => 3, '6' => 4, '7' => 5, '8' => 6, '9' => 7, 'T' => 8, 'J' => 9, 'Q' => 10, 'K' => 11, 'A' => 12 }

def is_royal_flush( hand )
	['d', 's', 'c', 'h'].each{ |c|
		if hand.count( c ) == 5 
			hand.split.each{ |val| hand.gsub! val, ''		if !val.include? c }
			arr_5 = hand.split.map{ |val| index_ranking[val[0]] }
			return arr_5.sort.each_cons(2).all?{ |a,b| b = a + 1 }
		end
	}
	false
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