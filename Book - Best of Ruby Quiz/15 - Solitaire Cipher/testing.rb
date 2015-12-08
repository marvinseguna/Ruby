gem 'minitest'
require 'minitest/autorun'
require 'main'

describe 'when passed a 10 letter word' do
	it 'must provide the following sequence: DWJXHYRFDG' do
		( keystream 'ABCDEFGHTY' ).must_equal 'DWJXHYRFDG'
	end
end
