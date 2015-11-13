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

describe '#get_movement' do
	it 'is directed south' do
		expect( get_movement 's' ).to eq [1, 0]
	end
end

describe '#get_cell_value' do
	it 'transforms a storage to: a man on storage' do
		expect( get_cell_value '@', '.' ).to eq '+'
	end
	
	it 'transforms a storage to: a crate on storage' do
		expect( get_cell_value 'o', '.' ).to eq '*'
	end
end
