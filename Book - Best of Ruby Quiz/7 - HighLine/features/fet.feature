Feature: Float
	In order to avoid invalid formats
	As a user
	I want to be told if my input is valid or not
	
	Scenario: Valid Float
		Given I have provided 20 as an input
		When I call handle_float
		Then the result should be true on the screen
		
	Scenario: Invalid Float
		Given I have provided what_do_you_meeeaaaann as an input
		When calling handle_float an exception saying 'Provided string is not a float' should be thrown