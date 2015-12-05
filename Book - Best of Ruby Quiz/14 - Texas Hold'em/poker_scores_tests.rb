gem 'minitest'
require 'minitest/autorun'
require 'poker_scores'

describe PokerScores do #this must match the class name being tested

	before do #equivalent to setup method
		@ps = PokerScores.new
	end
	
	describe 'when passed a valid ROYAL FLUSH hand' do
		it 'must provide a boolean true' do
			( @ps.is_royal_flush 'Ts Js Qs Ks 7h 3h As' ).must_equal true
		end
	end
	describe 'when passed an invalid ROYAL FLUSH hand' do
		it 'must provide a boolean false' do
			( @ps.is_royal_flush '7s Js Qs Ks 7h 3h As' ).must_equal false
		end
	end
	
	
	describe 'when passed a valid STRAIGHT FLUSH hand' do
		it 'must provide a boolean true' do
			( @ps.is_straight_flush '2s 3s 4s 5s 7h 3h 6s' ).must_equal true
		end
	end
	describe 'when passed an invalid STRAIGHT FLUSH hand' do
		it 'must provide a boolean false' do
			( @ps.is_straight_flush '2s 3s 4d 5s 7h 3h 6s' ).must_equal false
		end
	end
	
	
	describe 'when passed a valid FOUR OF A KIND hand' do
		it 'must provide a boolean true' do
			( @ps.is_four_of_a_kind '2s 2d 4s 2c 7h 2h 6s' ).must_equal true
		end
	end
	describe 'when passed an invalid FOUR OF A KIND hand' do
		it 'must provide a boolean false' do
			( @ps.is_four_of_a_kind '2s 3s 4d 5s 7h 3h 6s' ).must_equal false
		end
	end
	
	
	describe 'when passed a valid FULL HOUSE hand' do
		it 'must provide a boolean true' do
			( @ps.is_full_house '2s 2d 2h 5s 7h 3h 5h' ).must_equal true
		end
	end
	describe 'when passed an invalid FULL HOUSE hand' do
		it 'must provide a boolean false' do
			( @ps.is_full_house '2s 3s 4d 5s 7h 3h 6s' ).must_equal false
		end
	end
	
	
	describe 'when passed a valid FLUSH hand' do
		it 'must provide a boolean true' do
			( @ps.is_flush '2s 7s Ts Ks 7h 3h 4s' ).must_equal true
		end
	end
	describe 'when passed an invalid FLUSH hand' do
		it 'must provide a boolean false' do
			( @ps.is_flush '2s 3s 4d 5s 7h 3h 6s' ).must_equal false
		end
	end
	
	
	describe 'when passed a valid STRAIGHT hand' do
		it 'must provide a boolean true' do
			( @ps.is_straight '2s 3h 4d 5h Th 3h 6s' ).must_equal true
		end
	end
	describe 'when passed an invalid STRAIGHT hand' do
		it 'must provide a boolean false' do
			( @ps.is_straight '2s Td 4d 5s 7h Th 9c' ).must_equal false
		end
	end
	
	
	describe 'when passed a valid THREE OF A KIND hand' do
		it 'must provide a boolean true' do
			( @ps.is_three_of_a_kind '2s 2h 4d 5h 2c 3h 6s' ).must_equal true
		end
	end
	describe 'when passed an invalid THREE OF A KIND hand' do
		it 'must provide a boolean false' do
			( @ps.is_three_of_a_kind '2s Td 4d 5s 7h Th 9c' ).must_equal false
		end
	end
	
	
	describe 'when passed a valid TWO PAIR hand' do
		it 'must provide a boolean true' do
			( @ps.is_two_pair '2s 2h 4d 5h Th 3h 3s' ).must_equal true
		end
	end
	describe 'when passed an invalid TWO PAIR hand' do
		it 'must provide a boolean false' do
			( @ps.is_two_pair '2s Td 4d 5s 7h Th 9c' ).must_equal false
		end
	end
	
	
	describe 'when passed a valid PAIR hand' do
		it 'must provide a boolean true' do
			( @ps.is_pair '2s 8d 4d 5h Th 3h 8s' ).must_equal true
		end
	end
	describe 'when passed an invalid PAIR hand' do
		it 'must provide a boolean false' do
			( @ps.is_pair '2s Td 4d 5s 7h 8h 9c' ).must_equal false
		end
	end
end