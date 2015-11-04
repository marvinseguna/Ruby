class YourPlayer < Player
	def initialize( opponent_name )
		# (optional) called at the start of a match verses opponent
		# opponent_name = String of opponent' s class name
		#
		# Player' s constructor sets @opponent_name
		@irrispective = []
		@opp_los = {'11' => 0, '12' => 0, '13' => 0, '21' => 0, '22' => 0, '23' => 0, '31' => 0, '32' => 0, '33' => 0}
		@opp_tie = {'11' => 0, '12' => 0, '13' => 0, '21' => 0, '22' => 0, '23' => 0, '31' => 0, '32' => 0, '33' => 0}
		@opp_win = {'11' => 0, '12' => 0, '13' => 0, '21' => 0, '22' => 0, '23' => 0, '31' => 0, '32' => 0, '33' => 0}
	end
	def choose
		# (required) return your choice of :paper, :rock or :scissors
	end

	def result( your_choice, opponents_choice, win_lose_or_draw )
		# (optional) called after each choice you make to give feedback
		# your_choice = your choice
		# oppenents_choice = opponent' s choice
		# win_lose_or_draw = :win, :lose or :draw, your result
		
		add_pattern win_lose_or_draw, oppenents_choice		if !irrispective.empty?
		@irrispective.push oppenents_choice
	end
	
	def add_pattern( win_lose_or_draw, opponents_choice )
		joint_possibility = hand_to_number @irrispective.last, opponents_choice
		
		if win_lose_or_draw == :win #Opponent lost
			@opp_los[ joint_possibility ] += 1
		elsif win_lose_or_draw == :lose #Opponent won
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

