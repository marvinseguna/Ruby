require 'rspec'
require 'main'

describe '#get_destination' do

	context 'passed a value as a chess board reference' do
		it 'is provided with a value of A6' do
			expect( get_destination 'A6' ).to eq 20
		end
		
		it 'is provided with a value of E4' do
			expect( get_destination 'E4' ).to eq 44
		end
		
		it 'is provided with a value of G5' do
			expect( get_destination 'G5' ).to eq 36
		end
	end
end

describe '#set_H' do

	context 'provided with a valid cell' do
		it 'is provided with endpoint A6 (20)' do
			arr = set_H 20
			expect( arr[0][0] ).to eq 2
		end
		
		it 'is provided with endpoint E5 (34)' do
			arr = set_H 34
			expect( arr[0][0] ).to eq 7
		end
	end
end

describe '#get_F' do

	context 'provided with a valid cell and g-value' do
		it 'is provided with 11 and 3' do
			arr = set_H 20
			expect( get_F 11, 3 ).to eq 5
		end
		
		it 'is provided with 14 and 6' do
			arr = set_H 34
			expect( get_F 14, 6 ).to eq 8
		end
	end
end

describe '#get_lowest_F' do

	context 'provided with a valid list' do
		it 'returns the value with the lowest F' do
			open_list = { 34 => [0, 3, 5], 12 => [3, 6, 9] }
			expect( get_lowest_F open_list ).to eq 34
		end
	end
end

describe '#get_cell_names' do

	context 'provided with a valid cell' do
		it 'returns the respective cell name (e2)' do
			expect( get_cell_names 64 ).to eq 'e2'
		end
	end
end

describe '#get_valid_moves' do

	context 'provided with a valid cell' do
		it 'is provided with a value of 23' do
			expect( get_valid_moves 23 ).to eq [ 35, 11, 15, 31, 44, 02, 04, 42 ]
		end
		
		it 'is provided with a value of 11' do
			expect( get_valid_moves 11 ).to eq [ 23, 03, 32, 30 ]
		end
	end
end