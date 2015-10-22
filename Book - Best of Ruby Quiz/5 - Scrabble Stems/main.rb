require 'Set'

class String
	def sort
		self.chars.sort.join
	end
end

def init_dictionary
	File.readlines('Resources/wordlist.txt').each{ |line| (@dictionary ||= []).push line.chomp.downcase.sort }
end

def get_possible_stems
	@dictionary.each{ |word| (@possible_stems ||= []).push word if !word.scan(/[#{Regexp.quote(@cutoff)}]/).empty? }
end

def get_cutoff_stems
	@six_stem = Set.new
	@possible_stems.each{ |stem|
		included_cutoffs = stem.scan(/[#{Regexp.quote(@cutoff)}]/)
		@cutoff.split("").each{ |letter| 
			next if included_cutoffs.include? letter
			new_word = stem.sub(included_cutoffs[0], letter).sort #replace only 1st occurrance
			(@dictionary.include? new_word) ? (included_cutoffs.push letter) : break
		}
		@six_stem.add stem.sub(included_cutoffs[0], "") if included_cutoffs.sort.join == @cutoff.sort
	}
end

def get_other_possibilities
	@final_six_stem = {}
	@six_stem.each{ |stem| 
		@final_six_stem[stem] = @cutoff.length
		(('a'..'z').to_a - @cutoff.split("")).each{ |letter| 
			@final_six_stem[stem] += 1 if @dictionary.include? (stem + letter).sort
		}
	}
end

def main
	@cutoff = ARGV[0]
	init_dictionary
	
	get_possible_stems
	get_cutoff_stems
	get_other_possibilities
	
	(@final_six_stem.sort_by { |k, v| v }).reverse[0..5].each{ |k, v| puts "#{k} : #{v}points" }
end

main

