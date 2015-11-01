require 'rspec'
require 'main'

describe '#get_splitted_value' do

	context 'is passed a valid value' do
		it 'is a multiple of 100' do
			expect( get_splitted_value 200 ).to eq ['200', '00', '0']
		end
		
		it 'is not a multiple of 100' do
			expect( get_splitted_value '394' ).to eq ['300', '90', '4']
		end
	end
	
	context 'not passed a valid value' do
		it 'contains letters and values' do
			expect{ get_splitted_value 'th65f' }.to raise_error(ArgumentError, 'Invalid argument [get_splitted_value]')
		end
	end
end

describe '#get_roman_value' do

	context 'is passed a valid value' do
		it 'is a multiple of 100' do
			expect( get_roman_value 200 ).to eq 'CC'
		end
		
		it 'is passed value [90]' do # 4, 9 both require extra method
			expect( get_roman_value '90' ).to eq 'XC'
		end
	end

	context 'not passed a valid value' do
		it 'is not a multiple of 10/100' do
			expect{ get_roman_value 213 }.to raise_error(ArgumentError, 'Invalid argument [get_roman_value]')
		end
		
		it 'contains letters and values' do
			expect{ get_roman_value 'th65f' }.to raise_error(ArgumentError, 'Invalid argument [get_roman_value]')
		end
		
		it 'iss less than 1' do
			expect{ get_roman_value '0' }.to raise_error(ArgumentError, 'Invalid argument [get_roman_value]')
		end
	end
end

describe '#reduction_check' do #valid value for this function should be < 0!
	let(:roman_letters) { [:M, :D, :C, :L, :X, :V, :I] } #roman letters - reversed
	
	context 'is passed a valid value' do
		it 'is passed a value which does not match' do
			expect( reduction_check -9, roman_letters ).to eq ''
		end
		
		it 'is passed a value less than 0 but does not match' do
			expect( reduction_check -10, roman_letters ).to eq 'X'
		end
	end

	context 'is passed an invalid value' do
		it 'is passed a value greeater than 0' do
			expect{ reduction_check '100', roman_letters }.to raise_error(ArgumentError, 'Invalid argument [reduction_check]')
		end
		
		it 'is passed a value [0]' do
			expect{ reduction_check 0, roman_letters }.to raise_error(ArgumentError, 'Invalid argument [reduction_check]')
		end
		
		it 'contains letters and values' do
			expect{ reduction_check 'th65f', roman_letters }.to raise_error(ArgumentError, 'Invalid argument [reduction_check]')
		end
	end 
end