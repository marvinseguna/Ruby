MAPS_LETTERS = { 'A' => '0', 'B' => '1', 'C' => '2', 'D' => '3', 'E' => '4', 'F' => '5', 'G' => '6', 'H' => '7' }
MAPS_NUMBERS = { '8' => '0', '7' => '1', '6' => '2', '5' => '3', '4' => '4', '3' => '5', '2' => '6', '1' => '7' }

def get_destination( cell )
	MAPS_NUMBERS[cell[1]] + MAPS_LETTERS[cell[0].upcase]
end

start = get_destination ARGV[0]
ending = get_destination ARGV[1]

prohibited = []
for i in 2..ARGV.length - 1
	prohibited.push get_destination ARGV[i]
end

puts start
puts ending
puts prohibited