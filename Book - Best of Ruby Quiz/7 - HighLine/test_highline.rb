require "highline"
require "test/unit"
 
class TestHighline < Test::Unit::TestCase
 
	def setup
		@highline = Highline.new
	end
	
	######### INTEGER TESTING ############
	
	def test_integer_class
		assert_equal true, @highline.handle_integer( 2 )
	
		assert_raise_with_message( ArgumentError, 'Value is not of type integer!' ) do
			@highline.handle_integer 'ruby'
		end
	end
 
	def test_integer_range
		assert_equal true, @highline.handle_integer( 2, :within => 1..5  )
		
		assert_raise_with_message( ArgumentError, 'Value does not fall within specified range!' ) do
			@highline.handle_integer 2, :within => 3..6
		end
	end
	
	def test_integer_even
		assert_equal true, @highline.handle_integer( 2, :even )
		
		assert_raise_with_message( ArgumentError, 'Value is not even!' ) do
			@highline.handle_integer 3, :even
		end
	end
	
	def test_integer_odd
		assert_equal true, @highline.handle_integer( 2, :odd )
		
		assert_raise_with_message( ArgumentError, 'Value is not odd!' ) do
			@highline.handle_integer 3, :odd
		end
	end
	
	def test_integer_greater
		assert_equal true, @highline.handle_integer( 2, :greater => 1 )
		
		value = 5
		assert_raise_with_message( ArgumentError, "Value must be greater than #{value}!" ) do
			@highline.handle_integer 3, :greater => value
		end
	end
	
	def test_integer_less
		assert_equal true, @highline.handle_integer( 2, :less => 3 )
		
		vale = 1
		assert_raise_with_message( ArgumentError, "Value must be smaller than #{value}!" ) do
			@highline.handle_integer 3, :less => value
		end
	end
 
end
