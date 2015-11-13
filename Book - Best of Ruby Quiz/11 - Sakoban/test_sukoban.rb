require 'rspec'
require 'sukoban'

describe '#load_maps' do
	it 'loads all the maps from the file' do
		expect( load_maps.length ).to eq 50
	end
end

describe '#check_move' do
	it 'encounters a crate and then a wall' do
		map = [['#', '#'], ['#', 'o'], ['#', '@']]
		expect( check_move [-1, 0], [2, 1], map ).to be false
	end
	
	it 'encounters a crate and then an empty storage space' do
		map = [['#', '.'], ['#', 'o'], ['#', '@']]
		expect( check_move [-1, 0], [2, 1], map ).to be true
	end
	
	it 'encounters a wall' do
		map = [['#', '#'], ['#', '#'], ['#', '@']]
		expect( check_move  [-1, 0], [2, 1], map ).to be false
	end
end

describe '#get_next_cell_value' do
	it 'is a storage, so the @(man) => +' do
		expect( get_next_cell_value '@', '.' ).to eq '+'
	end
	
	it 'is an open floor, so the o(crate) => o' do
		expect( get_next_cell_value 'o', ' ' ).to eq 'o'
	end
end

describe '#get_old_cell_value' do
	it 'was a storage with @(man) => .' do
		expect( get_old_cell_value '+' ).to eq '.'
	end
	
	it 'was open floor => open floor' do
		expect( get_old_cell_value '@' ).to eq ' '
	end
end

describe '#get_starting_point' do
	let(:map) { [[' ', ' ', ' '], ['.', '@', ' '], ['o', ' ', ' ']] }
	
	it 'is starting at [1, 1]' do
		expect( get_starting_point map ).to eq [1, 1]
	end
	
	it 'contains no starting point' do
		map[1][1] = ' '
		expect( get_starting_point map ).to eq nil
	end
end
