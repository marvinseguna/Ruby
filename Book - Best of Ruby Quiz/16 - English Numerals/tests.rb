gem 'minitest'
require 'minitest/autorun'
require 'main'

describe 'when passing a value to function get_largest_before_0' do
	it 'must provide the largets multiple of 10 value which is still smaller than the value passed' do
		( get_largest_before_0 1241156 ).must_equal 1000000
		( get_largest_before_0 245912 ).must_equal 100000
	end
end

