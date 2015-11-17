require 'print_func'

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