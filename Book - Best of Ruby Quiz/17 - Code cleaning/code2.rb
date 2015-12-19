require' drb'

F = File

def get_drb_object( u )
	DRbObject.new( (), u )
end

def get_uri( u )
	[P, u].hash
end

def get_path( p )
	F.basename p[/[^|]+/]
end

P, M, U, V, *O = $*
if M['s']
	DRb.start_service V, Ops.new
	sleep
else
	get_files
end

def get_files
	a = get_drb_object( U ).f( get_uri( U ))
	a.map!{ |n| get_drb_object( n ).f( get_uri( n ), V, 0 )
	a.map!{ |f| get_path f }
	a.map!{ |f|
		if O[0]
			p f 
		else
			b = open( f, "wb" )
			b << get_drb_object( n ).f( get_uri( n ), f, 1 )
		end
	}
end

class Ops
	def p( z = O )
		O.push(*z).uniq
	end
	
	new.methods.map{ |m| private( m )		if m[/_[_t]/] != true }
	
	def y
		( p( U ) + p ).map{ |u| get_drb_object( u ).f( get_uri( u ), p( U ))		if u != U&}
		self
	end
	
	def f( c, a = O, t = 2)
		( if t < 1
			Dir[get_path( a )]
		else
			if t < 2
				[*open( get_path( a ), "rb" )]
			else
				p( a )
			end
		end ) if get_uri( U ) == c
	end
end