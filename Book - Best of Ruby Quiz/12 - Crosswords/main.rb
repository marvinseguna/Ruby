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
	for i in 0..map.length - 1 do
		for j in 0..map[i].length - 1 do
			map = check_outers map, i, j, [i, j]		if map[i][j].downcase == 'x'
		end
	end
	map
end