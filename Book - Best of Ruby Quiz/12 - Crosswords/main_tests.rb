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