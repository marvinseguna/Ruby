VALUE_TO_LETTERS = { 1 => 'A', 2 => 'B', 3 => 'C', 4 => 'D', 5 => 'E', 6 => 'F', 7 => 'G', 8 => 'H', 9 => 'I', 10 => 'J', 11 => 'K', 12 => 'L', 13 => 'M',
	14 => 'N', 15 => 'O', 16 => 'P', 17 => 'Q', 18 => 'R', 19 => 'S', 20 => 'T', 21 => 'U', 22 => 'V', 23 => 'W', 24 => 'X', 25 => 'Y', 26 => 'Z' }

def move_jokers( deck, joker_type, increment )
	index = deck.index joker_type  
	new_index = index + increment
	new_index = new_index % 53
	deck.insert( new_index, deck.delete_at( index ))
	deck
end

def get_card_value( deck )
	deck = move_jokers deck, 53, 1 #move A joker down one card
	deck = move_jokers deck, 54, 2 #move B joker down two cards
	
	joker_positions = [deck.index(53), deck.index(54)]
	deck = deck[joker_positions.max + 1..deck.length] + deck[joker_positions.min..joker_positions.max] + deck[0..joker_positions.min - 1] #triple cut
	
	last_value = deck[deck.length - 1]
	last_value.times{ |val| deck.insert( deck.length - 2, deck.delete_at( 0 )) } #count cut
	
	val = deck[deck[0]] == nil ? deck.last : deck[deck[0]]
	return [deck, val]
end

def get_letter( solitaire_card_value )
	solitaire_card_value > 26 ? VALUE_TO_LETTERS[solitaire_card_value - 26] : VALUE_TO_LETTERS[solitaire_card_value]
end

def keystream( message )
	deck = ( 1..54 ).to_a #53 and 54 are jokers
	keystream_letter = ''
	
	message.each_char{ |letter| 
		if letter == ' '
			keystream_letter << ' '
			next
		end
	
		deck_card = get_card_value deck
		deck_card = get_card_value deck_card[0]		if [53, 54].include? deck_card[1] #if returned card is a joker
		deck = deck_card[0]
		solitaire_card_value = deck_card[1]
		
		keystream_letter << get_letter( solitaire_card_value )
	}
	keystream_letter
end