def get_names
	names = []
	name = ''
	
	while name != 'r'
		puts 'Enter name (E.g. Mr. Gray). Enter "r" to exit'
		name = gets.chomp
		names.push name
	end
	names
end

def get_remaining_candidates( names, already_selected, secret_santas, current_person )
	remaining_candidates = []
	
	#From list, need to remove the following:
	# 1) Matching name
	# 2) Already selected candidates
	# 3) Candidates of a family which was selected by a relative of the current person
	remaining_candidates = names.reject{ |c_name| 
		c_name.split[1].downcase == current_person.split[1].downcase		or
		already_selected.include? c_name
	} # 1) & 2)
	secret_santas.each{ |key, value|
		if key.split[1].downcase == current_person.split[1].downcase
			remaining_candidates = remaining_candidates.reject{ |c_name| c_name.split[1].downcase == value.split[1].downcase }
		end
	} # 3)
	remaining_candidates
end

def get_secret_santa( names )
	secret_santas = {}
	already_selected = []
	
	names.each{ |current_person|
		remaining_candidates = get_remaining_candidates names, already_selected, secret_santas, current_person
		p remaining_candidates
		index = Random.rand( 0...remaining_candidates.size - 1 )
		selected_person = remaining_candidates[index]
		p selected_person
		secret_santas[current_person] = selected_person
		already_selected.push selected_person
	}
	secret_santas
end

#names = get_names
names = ['Mr. Gray', 'Mrs. Gray', 'Mr. Thomas', 'Mrs. Thomas', 'Mr. Fats', 'Mrs. Fats', 'Mr. B']
puts get_secret_santa( names )

# Mr. Gray => Mr. Fats
# Mrs. Gray => Mrs. Thomas
# Mr. Thomas => Mrs. Fats
# Mrs. Thomas => Mr. Gray
# Mr. Fats => Mrs. Gray
# Mrs. Fats => Mr. Thomas
#