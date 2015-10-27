require "highline"
require "test/unit"
 
class TestHighline < Test::Unit::TestCase
 
	def setup
		@highline = Highline.new
	end
	
	######### INTEGER TESTING ############
	
	def test_integer_class
		assert_equal true, @highline.handle_integer( '2' )
	
		value = '999t'
		assert_raise( ArgumentError, "Value [#{value}] is not of type integer!" ) do
			@highline.handle_integer value
		end
	end
 
	def test_integer_range
		assert_equal true, @highline.handle_integer( '2', :within => 1..5  )
		
		value = 3..6
		assert_raise( ArgumentError, "Value does not fall within range [#{value}]!" ) do
			@highline.handle_integer '2', :within => 3..6
		end
	end
	
	def test_integer_even
		assert_equal true, @highline.handle_integer( '2', :even )
		
		value = '3'
		assert_raise( ArgumentError, "Value [#{value}] is not even!" ) do
			@highline.handle_integer value, :even
		end
	end
	
	def test_integer_odd
		assert_equal true, @highline.handle_integer( '3', :odd )
		
		value = '2'
		assert_raise( ArgumentError, "Value [#{value}] is not odd!" ) do
			@highline.handle_integer value, :odd
		end
	end
	
	def test_integer_greater
		assert_equal true, @highline.handle_integer( '2', :greater => 1 )
		
		value = '3'
		greater_value = 5
		assert_raise( ArgumentError, "Value [#{value}] must be greater than #{greater_value}!" ) do
			@highline.handle_integer value, :greater => greater_value
		end
	end
	
	def test_integer_less
		assert_equal true, @highline.handle_integer( '2', :less => 3 )
		
		value = '3'
		greater_value = 1
		assert_raise( ArgumentError, "Value [#{value}] must be smaller than #{greater_value}!" ) do
			@highline.handle_integer value, :smaller => greater_value
		end
	end
 
end
