gem 'minitest'
require 'minitest/autorun'
require 'keystream'
require 'encryption'

describe 'when invoking keystream function with a 10-letter word' do
	it 'must provide the following sequence: DWJXHYRFDG' do
		( keystream 'ABCDEFGHTY' ).must_equal 'DWJXHYRFDG'
	end
end

describe 'when passing a sentence to the encryption method' do
	it 'must provide the encrypted version' do
		( encrypt 'Code in Ruby, live longer!' ).must_equal 'GLNCQ MJAFF FVOMB JIYCB'
	end
end
