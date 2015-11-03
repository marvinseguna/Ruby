ROMAN_LETTERS = { 'I' => 1, 'IV' => 4, 'V' => 5, 'IX' => 9, 'X' => 10, 'XL' => 40, 'L' => 50, 'XC' => 90, 'C' => 100, 'CD' => 400, 'D' => 500, 'CM'  => 900, 'M' => 1000 }

def arabic_to_roman( arabic, roman_s = '' )
	raise ArgumentError, 'Invalid argument [arabic_to_roman]'		if arabic.class != Fixnum
	ROMAN_LETTERS.keys.reverse.each{ |roman| 
		div = arabic.divmod ROMAN_LETTERS[roman]
		next		if div[0] == 0
		roman_s << ( roman * div[0] )
		arabic = div[1]
	}
	roman_s
end

def roman_to_arabic( roman_s, arabic = 0 )
	raise ArgumentError, 'Invalid argument [roman_to_arabic]'		if roman_s.class != String
	ROMAN_LETTERS.keys.sort_by(&:length).reverse.each{ |roman|
		arabic += ( roman_s.scan roman ).length * ROMAN_LETTERS[roman] 
		roman_s.gsub! roman, ''
	}
	arabic
end

answers = []
File.readlines('Resources/Numerals.txt').each{ |line| 
	if line.scan( /^\d+$/ ).empty? 
		answers.push roman_to_arabic line
	else
		answers.push arabic_to_roman line.to_i 
	end
}
puts answers