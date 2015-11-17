require 'rspec'
require 'main'

describe '#disable_outers' do
	let( :crossword ) { [['x','_','_','_','_','x','x'], 
						 ['_','_','x','_','_','_','_'], 
						 ['_','_','_','_','x','_','_'], 
						 ['_','x','_','_','x','x','x'], 
						 ['_','_','_','x','_','_','_'],
						 ['x','_','_','_','_','_','x']] }
						 
	let( :filtered_crossword ) { [['d','_','_','_','_','d','d'], 
								  ['_','_','x','_','_','_','_'], 
								  ['_','_','_','_','d','_','_'], 
								  ['_','x','_','_','d','d','d'], 
								  ['_','_','_','x','_','_','_'],
								  ['d','_','_','_','_','_','d']] }

	it 'eliminates all outer fields of the crossword' do
		expect( disable_outers crossword ).to eq filtered_crossword
	end
end

describe '#label_crossword' do
	let( :crossword ) { [['x','_','_','_','_','x','x'], 
						 ['_','_','x','_','_','_','_'], 
						 ['_','_','_','_','x','_','_'], 
						 ['_','x','_','_','x','x','x'], 
						 ['_','_','_','x','_','_','_'],
						 ['x','_','_','_','_','_','x']] }
						 
	let( :numbered_crossword ) { [['x','l','_','l','l','x','x'], 
								  ['l','_','x','l','_','l','l'], 
								  ['l','_','l','_','x','l','_'], 
								  ['_','x','l','_','x','x','x'], 
								  ['l','l','_','x','l','l','_'],
								  ['x','l','_','_','_','_','x']] }
								  
	it 'labels the grid with numbers, indicating a beginning of a word' do
		expect( label_crossword crossword ).to eq numbered_crossword
	end
end