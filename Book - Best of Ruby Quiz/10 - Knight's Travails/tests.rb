require 'rspec'
require 'main'

describe '#get_destination' do

	context 'passed a value as a chess board reference' do
		it 'is provided with a value of A6' do
			expect( get_destination 'A6' ).to eq '20'
		end
		
		it 'is provided with a value of E4' do
			expect( get_destination 'E4' ).to eq '44'
		end
		
		it 'is provided with a value of G5' do
			expect( get_destination 'G5' ).to eq '36'
		end
	end
end
