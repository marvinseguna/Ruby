require 'rspec'
require 'main'

describe '#arabic_to_roman' do

	context 'is passed a valid value' do
		it 'is passed a value < 100' do
			expect( arabic_to_roman 78 ).to eq 'LXXVIII'
		end
		
		it 'is passed a value < 1000' do
			expect( arabic_to_roman 343 ).to eq 'CCCXLIII'
		end
		
		it 'is passed a value < 3999' do
			expect( arabic_to_roman 2165 ).to eq 'MMCLXV'
		end
	end
	
	context 'is passed an invalid value' do
		it 'is of type String' do
			expect{ arabic_to_roman '100' }.to raise_error(ArgumentError, 'Invalid argument [arabic_to_roman]')
		end
	end 
end

describe '#roman_to_arabic' do

	context 'is passed a valid value' do
		it 'is passed a value < 100' do
			expect( roman_to_arabic 'XCVII' ).to eq 97
		end
		
		it 'is passed a value < 1000' do
			expect( roman_to_arabic 'CCCXLIII' ).to eq 343
		end
		
		it 'is passed a value < 3999' do
			expect( roman_to_arabic 'MMCLXV' ).to eq 2165
		end
	end
	
	context 'is passed an invalid value' do
		it 'is of type String' do
			expect{ roman_to_arabic 100 }.to raise_error(ArgumentError, 'Invalid argument [roman_to_arabic]')
		end
	end 
end