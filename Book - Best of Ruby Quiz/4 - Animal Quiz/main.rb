require 'set'

def read_animals_file( file ) #'attributes' hash is also formed, used for elimination of animals (from animals array)
	File.readlines(file).each{ |line| 
		matches = line.chomp.scan(/([a-zA-Z]+):\s\[(.*)\]/).first
		assign_attributes matches[0], matches[1] #property = animals
		
		if matches[1].empty?
			@animals[matches[0]] = Set.new(["na"])
			@animals_original[matches[0]] = Set.new ["na"]
		else
			@animals[matches[0]] = Set.new matches[1].split(","))
			@animals_original[matches[0]] = Set.new matches[1].split(",")))
		end
	}
end

def assign_attributes( animal, properties )
	return if properties.empty?
	properties.split(",").each{ |property| 
		if @attributes.keys.include? property
			@attributes[property].push animal
		else
			@attributes[property] = [animal]
		end
	}
end

def eliminate_animals( input, property)
	if input.include? 'y'
		@evidences.push property
		@animals.delete_if{ |animal, properties| !properties.include? property } #if it doesnt include porperty
	else
		@animals.delete_if{ |animal, properties| properties.include? property } 
	end
end

def get_user_response( question )
	puts question 
	return gets.chomp.downcase
end

def rewrite_animals_file
	File.open('Resources/animals.txt', 'w'){ |f| @animals_original.each{ |k, v| f.write k + ': [' + v.to_a.join(",") + "]\n" } }
end

def modify_files_and_structures #update hashes and files
	@animals_original[animal] = Set.new		if !@animals_original.keys.include? animal
	
	if answer.include? 'n'
		@animals_original[animal].add question 
	else
		@animals_original[@animals.keys[index]].add question
		@evidences.each{ |evidence| @animals_original[@animals.keys[index]].add evidence }
	end

	@evidences.each{ |evidence| @animals_original[animal].add evidence }
	rewrite_animals_file
end

def try_guessing #only 1 animal is left in array, so either guessed or not
	index = Random.rand @animals.length
	if (get_user_response "You're thinking of: #{@animals.keys[index]}? (y/n)" ).include? 'n'
		animal = get_user_response "Ok, I give up. What was the animal?"
		question = get_user_response "Give me a question to distinguish between #{@animals.keys[index]} and #{animal}"
		answer = get_user_response "(For: #{@animals.keys[index]}) What is the answer to that question? (y/n)"
		
		File.open('Resources/questions.txt', "a+"){ |f| f.write "#{question}\n" } 
		@questions.add question 
		
		modify_files_and_structures animal, answer, question, index
	else
		puts "Haha! Got you!"
	end
end

def input_new_animal #no animals left to choose from
	animal = get_user_response "Ok, I give up. What was the animal?"
	@animals_original[animal] = Set.new
	@evidences.each{ |evidence| @animals_original[animal].add evidence }
	rewrite_animals_file
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
		
		@questions.each{ |question|
			if property.downcase.include? question.downcase
				puts "#{question} (y/n)"
				break
			end
		}
		user_input = gets
		
		eliminate_animals user_input, property
	}
end

def init
	@attributes = {}
	@questions = Set.new
	@animals = {}
	@animals_original = {}
	@evidences = []

	File.open('Resources/questions.txt', 'r').each_line{ |line| @questions.add line.chomp }
	read_animals_file 'Resources/animals.txt'
	puts "\nThink of an animal..\n\n"
	guess
end


init
while (get_user_response "\nWant to play again? (y/n)").chomp.include? 'y'
	puts '-----------------------------------------------------'
	init
end
