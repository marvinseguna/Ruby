require 'Highline'
require 'rspec' #to use should

Before do
	@float = 0.00
	@highline = Highline.new
end

Given /I have provided (.*) as an input/ do |number|
	@float = number
end

When /I call (.*)/ do |op|
	@result = @highline.send op, @float
end
Then /the result should be (.*) on the screen/ do |expected| #Valid float test
	@result.should.to_s == expected
end

When /calling (.*) an exception saying (.*) should be thrown/ do |op, message|
	expect { @highline.send op, @float }.to raise_error(message.gsub! "'", "")
end