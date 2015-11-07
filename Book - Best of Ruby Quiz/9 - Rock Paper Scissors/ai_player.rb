class YourPlayer < Player
	def initialize( opponent_name )
		# (optional) called at the start of a match verses opponent
		# opponent_name = String of opponent' s class name
		#
		# Player' s constructor sets @opponent_name
		@opp_last_option = nil
		@my_last_option = nil
		@round = 0
		@result = nil
		@opp_los = {'11' => 0, '12' => 0, '13' => 0, '21' => 0, '22' => 0, '23' => 0, '31' => 0, '32' => 0, '33' => 0}
		@opp_tie = {'11' => 0, '12' => 0, '13' => 0, '21' => 0, '22' => 0, '23' => 0, '31' => 0, '32' => 0, '33' => 0}
		@opp_win = {'11' => 0, '12' => 0, '13' => 0, '21' => 0, '22' => 0, '23' => 0, '31' => 0, '32' => 0, '33' => 0}
	end
	def choose
		return :rock		if @result == nil #cause I'm a man :D

		first_possibility =  first_strategy
		return first_possibility		if @round < 50
		
		second_possibility = second_strategy
		
		if @round < 300
			if first_possibility != second_possibility
				rand = @round % 2
				rand ? ( return first_possibility ) : ( return second_possibility )
			end
		else
			return second_possibility if first_possibility != second_possibility
		end
		first_possibility
	end

	def result( your_choice, opponents_choice, win_lose_or_draw )
		# (optional) called after each choice you make to give feedback
		# your_choice = your choice
		# opponents_choice = opponent' s choice
		# win_lose_or_draw = :win, :lose or :draw, your result
		
		@result = win_lose_or_draw
		add_pattern opponents_choice		if @opp_last_option != nil
		@opp_last_option = opponents_choice
		@my_last_option = your_choice
		@round += 1
	end
	
	def second_strategy
		mappings = { :rock => '1', :paper => '2', :scissors => '3'}
		val_map = mappings[@opp_last_option]
		final = {}
		
		case @result
		when :win
			@opp_win.each{ |key, value|	final[key] = value if key.start_with? val_map }
		when :lose
			@opp_los.each{ |key, value|	final[key] = value if key.start_with? val_map }
		when :draw
			@opp_tie.each{ |key, value|	final[key] = value if key.start_with? val_map }
		end
		number_hand = final.sort_by{ |key, value| value }.reverse.first.first[1]
		mappings.each{ |key, value| return cycle key		if value == number_hand }
	end
	
	def first_strategy
		if @result == :won
			return cycle		if @round % 2 == 0
			@my_last_option
		else #tie/lost
			cycle
		end
	end
	
	def cycle( option = @my_last_option )
		case option
		when :rock
			:paper
		when :paper
			:scissors
		when :scissors
			:rock
		end
	end
	
	def add_pattern( opponents_choice )
		joint_possibility = hand_to_number @opp_last_option, opponents_choice
		
		if @result == :win #Opponent lost
			@opp_los[ joint_possibility ] += 1
		elsif @result == :lose #Opponent won
			@opp_win[ joint_possibility ] += 1
		else#tie
			@opp_tie[ joint_possibility ] += 1
		end
	end
	
	def hand_to_number( hand_1, hand_2)
		mappings = { :rock => '1', :paper => '2', :scissors => '3'}
		mappings[hand_1] + mappings[hand_2]
	end
end

