def get_xml( level, tag_or_id, data )
	is_tag = tag_or_id.scan(/@([a-zA-z0-9]+)@/).empty?
	@xml << "\n"		if stack_length < level
	pop_until level		if stack_length >= level
		
	if is_tag
		@stack.push tag_or_id
		@xml << "<#{@stack.last}>#{data}"
	else
		@stack.push data
		@xml << "<#{@stack.last} id=\"#{tag_or_id}\">"
	end
end

def stack_length
	@stack.length - 1
end

def pop_until( level )
	while stack_length >= level
		@xml << "</#{@stack.last}>\n"
		@stack.pop
	end
end

@stack = []
@xml = ''
File.readlines('Resources/royal.ged').each{ |line| 
	next if line.chomp.empty?
	fields = line.scan(/([0-9*])\s+([a-zA-z0-9@]+)\s*(.*)/)
	raise "Invalid format found in file"		if fields.empty?
	
	get_xml fields.first[0].to_i, fields.first[1], fields.first[2]
}
pop_until 0
File.open('Resources/result.xml', 'w') { |file| file.write "<GEDCOM>\n#{@xml}\n</GEDCOM>" }