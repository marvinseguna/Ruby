require 'rspec'
require 'main'

describe '#arabic_to_roman' do

	context 'is passed a valid value' do
		it 'is passed a vlaue < 100' do
			expect( arabic_to_roman 78 ).to eq 'LXXVIII'
		end
		
		it 'is passed a vlaue < 1000' do
			expect( arabic_to_roman 343 ).to eq 'CCCXLIII'
		end
		
		it 'is passed a vlaue < 3999' do
			expect( arabic_to_roman 2165 ).to eq 'MMCLXV'
		end
	end
	
	context 'is passed an invalid value' do
		it 'is of type String' do
			expect{ arabic_to_roman '100' }.to raise_error(ArgumentError, 'Invalid argument [arabic_to_roman]')
		end
	end 
end