def check_outers( map, x, y, parent, visited = [] )
	visited.push [x, y]
	return true			if !( 0..map.length - 1 ).include? x or !( 0..map[x].length - 1 ).include? y
	return false		if map[x][y] == '_' or map[x][y] == 'd'
	
	north = check_outers map, x - 1, y, parent, visited		if !visited.include? [x - 1, y]
	south = check_outers map, x + 1, y, parent, visited		if !visited.include? [x + 1, y]
	east = check_outers map, x, y + 1, parent, visited		if !visited.include? [x, y + 1]
	west = check_outers map, x, y - 1, parent, visited		if !visited.include? [x, y - 1]
	
	if north or south or east or west
		return true		if [x, y] != parent
		
		map[x][y] = 'd'
	end
	map
end

def disable_outers( map )
	( 0..map.length - 1 ).each do |i|
		( 0..map[i].length - 1 ).each do |j|
			map = check_outers map, i, j, [i, j]		if map[i][j].downcase == 'x'
		end
	end
	map
end

def init_crossword( map )
	labelled_crossword = []
	
	( 0..map.length - 1 ).each do |i|
		labelled_crossword.push []
		( 0..map[i].length - 1 ).each do |j|
			labelled_crossword[i].push [-1, -1]
		end
	end
	labelled_crossword
end

def label_east( map, labelled_crossword, cw_i, cw_j, parent_i = cw_i, parent_j = cw_j )
	return labelled_crossword		if map[cw_i][cw_j] == 'x' or labelled_crossword[cw_i][cw_j][0] != -1
	
	labelled_crossword = label_east map, labelled_crossword, cw_i, cw_j + 1, parent_i, parent_j		if cw_j + 1 < map[0].length
	labelled_crossword[cw_i][cw_j - 1][0] = [parent_i, parent_j]		if cw_j != parent_j
	return labelled_crossword
end

def label_south( map, labelled_crossword, cw_i, cw_j, parent_i = cw_i, parent_j = cw_j )
	return labelled_crossword		if map[cw_i][cw_j] == 'x' or labelled_crossword[cw_i][cw_j][1] != -1
	
	labelled_crossword = label_south map, labelled_crossword, cw_i + 1, cw_j, parent_i, parent_j		if cw_i + 1 < map.length
	labelled_crossword[cw_i - 1][cw_j][1] = [parent_i, parent_j]		if cw_i != parent_i
	return labelled_crossword
end

def label_crossword( map )
	labelled_crossword = init_crossword map
	
	( 0..map.length - 1 ).each do |i|
		( 0..map[i].length - 1 ).each do |j|
			labelled_crossword = label_east map, labelled_crossword, i, j
			labelled_crossword = label_south map, labelled_crossword, i, j
			
			map[i][j] = 'l'		if labelled_crossword[i][j].include? [i,j]
		end
	end
	map
end

def get_full_printable_crossword( outer, labelled )
	count = 1
	arr = []
	( 0..outer.length - 1 ).each do |i|
		arr.push '#' * ( 5 * outer[i].join.length ) + '#' #first line
		line_2 = ''
		( 0..outer[i].length - 1 ).each do |j|
			if labelled[i][j] == 'l'
				line_2 << "##{count}" + " " * ( 5 - "##{count}".length )
				count += 1
			else
				line_2 << outer[i][j].gsub( 'd', '#####' ).gsub( 'x', '#####' ).gsub( '_', '#    ' )
			end
		end
		arr.push line_2 + '#'
		arr.push outer[i].join.gsub( 'd', '#####' ).gsub( 'x', '#####' ).gsub( '_', '#    ' ) + '#'
	end
	arr.push '#' * ( 5 * outer[0].join.length ) + '#' #last line
	arr
end

def get_final_crossword( outer, full_crossword )
	( 0..outer.length - 1 ).each do |i|
		( 0..outer[i].length - 1 ).each do |j|
			if outer[i][j] == 'd'
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
			end
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

map = 	[['x','_','_','_','_','x','x'], 
		 ['_','_','x','_','_','_','_'], 
		 ['_','_','_','_','x','_','_'], 
		 ['_','x','_','_','x','x','x'], 
		 ['_','_','_','x','_','_','_'],
		 ['x','_','_','_','_','_','x']]
map2 = 	[['x','_','_','_','_','x','x'], 
		 ['_','_','x','_','_','_','_'], 
		 ['_','_','_','_','x','_','_'], 
		 ['_','x','_','_','x','x','x'], 
		 ['_','_','_','x','_','_','_'],
		 ['x','_','_','_','_','_','x']]
outer = disable_outers map
labelled = label_crossword map2
print_crossword outer, labelled