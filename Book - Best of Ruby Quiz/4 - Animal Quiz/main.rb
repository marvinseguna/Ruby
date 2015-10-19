class String
	def strip
		self.gsub("\n", "").gsub("\r", "")
	end
end

def read_animals_file( file )
	File.readlines(file).each{ |line| 
		matches = line.strip.scan(/([a-zA-Z]+):\s\[(.*)\]/).first
		assign_attributes matches[0], matches[1] #property = animals
		@animals[matches[0]] = (matches[1].empty? ? ["na"] : matches[1].split(","))
		@animals_original[matches[0]] = (matches[1].empty? ? ["na"] : matches[1].split(","))
	}
end

def assign_attributes( animal, properties )
	return if properties.empty?
	properties.split(",").each{ |property| 
		(@attributes.keys.include? property) ? (@attributes[property].push animal) : (@attributes[property] = [animal])
	}
end

def eliminate_animals( input, property)
	if input.include? 'y' #eliminate all others
		@evidences.push property
		@animals.delete_if{ |animal, properties| !properties.include? property } 
	else
		@animals.delete_if{ |animal, properties| properties.include? property } 
	end
end

def get_user_response( question )
	puts question 
	return gets.strip
end

def try_guessing
	index = Random.rand @animals.length
	if (get_user_response "You're thinking of: #{@animals.keys[index]}? (y/n)" ).include? 'n'
		animal = get_user_response "Ok, I give up. What was the animal?"
		question = get_user_response "Give me a question to distinguish between #{@animals.keys[index]} and #{animal}"
		answer = get_user_response "(For: #{@animals.keys[index]}) What is the answer to that question? (y/n)"
		
		File.open('Resources/questions.txt', "a+"){ |f| f.write "#{question}\n" } if !@questions.include? question
		@questions.push question if !@questions.include? question
		
		if answer.include? 'n'
			(@animals_original.keys.include? animal) ? (@animals_original[animal].push question) : (@animals_original[animal] = [question])
		else
			@animals_original[@animals.keys[index]].push question
			@evidences.each{ |evidence| @animals_original[@animals.keys[index]].push evidence if !@animals_original[@animals.keys[index]].include? evidence }
		end
		@animals_original[animal] = [] if !@animals_original.keys.include? animal
		@evidences.each{ |evidence| @animals_original[animal].push evidence if !@animals_original[animal].include? evidence }
		File.open('Resources/animals.txt', 'w'){ |f| @animals_original.each{ |k, v| f.write k + ': [' + v.join(",") + "]\n" } }
	else
		puts "Haha! Got you!"
	end
end

def input_new_animal
	animal = get_user_response "Ok, I give up. What was the animal?"
	@animals_original[animal] = []
	@evidences.each{ |evidence| @animals_original[animal].push evidence if !@animals_original[animal].include? evidence }
	File.open('Resources/animals.txt', 'w'){ |f| @animals_original.each{ |k, v| f.write k + ': [' + v.join(",") + "]\n" } }
end

def guess
	@attributes.sort_by{ |k, v| v.length }.reverse.each{ |property, v|
		if @animals.length == 1
			try_guessing
			return
		elsif @animals.length == 0
			input_new_animal
			return
		end
		
		@questions.each{ |question| puts "#{question} (y/n)" and break if property.downcase.include? question.downcase }
		user_input = gets
		
		eliminate_animals user_input, property
	}
end

def init
	@attributes = {}
	@questions = []
	@animals = {}
	@animals_original = {}
	@evidences = []

	File.open('Resources/questions.txt', 'r').each_line{ |line| @questions.push line.strip }
	read_animals_file 'Resources/animals.txt'
	puts "\nThink of an animal..\n\n"
	guess
end

def main
	init
	
	while (get_user_response "\nWant to play again? (y/n)").strip.include? 'y'
		puts '-----------------------------------------------------'
		init
	end
end

main