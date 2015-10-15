def get_xml( level, tag_or_id, data )
	is_tag = check_a tag_or_id	
	@xml << "\n"	if stack_length < level
	pop_stack level	if stack_length == level or stack_length > level
		
	is_tag ? (@stack.push tag_or_id) : (@stack.push data)
	is_tag ? (@xml << "<#{@stack.last}>#{data}") : (@xml << "<#{@stack.last} id=\"#{tag_or_id}\">")
end

def check_a( tag_or_id )
	tag_or_id.scan(/@([a-zA-z0-9]+)@/).empty?
end

def stack_length
	@stack.length - 1
end

def pop_stack( level )
	while stack_length >= level
		@xml << "</#{@stack.last}>\n"
		@stack.pop
	end
end

def main( file )
	@stack = []
	@xml = ''
	
	File.readlines(file).each{ |line| 
		next if line.gsub("\n", "").empty?
		fields = line.scan(/([0-9*])\s+([a-zA-z0-9@]+)\s*(.*)/)
		raise "Invalid format found in file" if fields.empty?
		
		get_xml(fields.first[0].to_i, fields.first[1], fields.first[2])
	}
	
	pop_stack 0
	File.open('Resources/result.xml', 'w') { |file| file.write "<GEDCOM>\n#{@xml}\n</GEDCOM>" }
end

main 'Resources/royal.ged'