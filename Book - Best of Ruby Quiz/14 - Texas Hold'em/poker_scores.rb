INDEX_RANKING = { '2' => 0, '3' => 1, '4' => 2, '5' => 3, '6' => 4, '7' => 5, '8' => 6, '9' => 7, 'T' => 8, 'J' => 9, 'Q' => 10, 'K' => 11, 'A' => 12 }

class PokerScores
	def is_royal_flush( hand )
		['d', 's', 'c', 'h'].each{ |c|
			return true		if hand.scan(/([tjkqa]#{c})/i).length == 5 #tjkqa = ten jack queen king ace
		}
		false
	end

	def is_straight_flush( hand )
		['d', 's', 'c', 'h'].each{ |c, occur_5 = []|
			if hand.count( c ) == 5 
				hand.split.each{ |val| occur_5.push INDEX_RANKING[val[0]]		if val.include? c }
				return is_incremental occur_5
			end
		}
		false
	end

	def is_four_of_a_kind( hand )
		same_kind hand, 4
	end

	def is_full_house( hand )
		faces = hand.gsub(/[\sdsch]/, '')
		full_house = [get_occurence_matches( faces, 3 ), get_occurence_matches( faces, 2 )]
		( full_house.include? nil ) ? false : true
	end

	def is_flush( hand )
		['d', 's', 'c', 'h'].each{ |c|
			return true		if hand.scan(/([a-z0-9]#{c})/i).length == 5
		}
		false
	end

	def is_straight( hand )
		occur_5 = []
		hand.split.each{ |val| occur_5.push INDEX_RANKING[val[0]] }
		return is_incremental occur_5
	end

	def is_three_of_a_kind( hand )
		same_kind hand, 3
	end

	def is_two_pair( hand )
		count = 0
		INDEX_RANKING.keys.each{ |face| 
			count += 1		if hand.scan(/#{face}[dsch]/i).length == 2
		}
		count == 2 ? true : false
	end

	def is_pair( hand )
		same_kind hand, 2
	end

	def get_high_card( hand )
		face = hand.gsub(/[\sdsch]/, '').split("")
		count = 0
		
		face.each{ |val| count += INDEX_RANKING[val] }
		count
	end

	#HELPERS
	def same_kind( hand, amount ) # amount => face cards that need to be present in hand
		INDEX_RANKING.keys.each{ |face| 
			return true		if hand.scan(/#{face}[dsch]/i).length == amount
		}
		false
	end

	def get_occurence_matches( string, occurrence ) # ( "Q345QQ7", 3 ) => "Q", ( "1234567", 3 ) => nil
		string.split("").group_by{ |val| val }.select{ |key, value| value.size == occurrence }.map(&:first).first
	end
	
	def is_incremental( hand, same_cards = 5 ) # "2537496" => true. Checks for consecutive numbers
		count = 1
		hand = hand.sort
		0.upto hand.length - 2 do |i|
			count += 1		if hand[i + 1] == hand[i] + 1
		end
		( count == same_cards ) ? true : false
	end
end