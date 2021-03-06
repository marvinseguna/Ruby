def get_second_line( outer, labelled, i )
	count = 1
	line_2 = ''
	( 0..outer[i].length - 1 ).each do |j|
		if labelled[i][j] == 'l'
			line_2 << "##{count}" + " " * ( 5 - "##{count}".length )
			count += 1
		else
			line_2 << outer[i][j].gsub( 'd', '#####' ).gsub( 'x', '#####' ).gsub( '_', '#    ' )
		end
	end
	line_2
end

def get_full_printable_crossword( outer, labelled )
	arr = []
	( 0..outer.length - 1 ).each do |i|
		arr.push '#' * ( 5 * outer[i].join.length ) + '#' #first line
		arr.push get_second_line( outer, labelled, i ) + '#'
		arr.push outer[i].join.gsub( 'd', '#####' ).gsub( 'x', '#####' ).gsub( '_', '#    ' ) + '#'
	end
	arr.push '#' * ( 5 * outer[0].join.length ) + '#' #last line
	arr
end

def handle_d( outer, full_crossword, i, j )
	x = i * 3
	y = j * 5
	fields = 2
	fields = 3		if i == outer.length - 1
	
	for k in 0..fields do
		next		if k == 0 and i - 1 > 0 and outer[i - 1][j] != 'd'
	
		full_crossword[x + k][y] = ' '		if j - 1 < 0 or outer[i][j - 1] == 'd'
		full_crossword[x + k][y + 1..y + 4] = '    '
		full_crossword[x + k][y + 5] = ' '		if j == outer[i].length - 1
	end
	full_crossword
end

def get_final_crossword( outer, full_crossword )
	( 0..outer.length - 1 ).each do |i|
		( 0..outer[i].length - 1 ).each do |j|
			handle_d outer, full_crossword, i, j		if outer[i][j] == 'd'
		end
	end
	full_crossword
end

def print_crossword( outer, labelled )
	full_crossword = get_full_printable_crossword outer, labelled
	final_crossword = get_final_crossword outer, full_crossword
	puts ""
	final_crossword.each{ |line| puts line }
end