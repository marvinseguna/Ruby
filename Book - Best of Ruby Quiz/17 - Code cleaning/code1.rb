#Code cleaning
require 'cgi'

homepage = 'HomePage'
page = 'wiki.cgi?n=%s'
cgi_obj = CGI.new 'html4'

display_page = cgi_obj['n'] != ' ' ? cgi_obj['n'] : homepage
page_elements = cgi_obj['d']
page_data = "cat #{ display_page }"
"echo #{page_data = CGI.escapeHTML( d )} > #{ display_page }"		if page_elements != ' '

cgi_obj.instance_eval{
	out{
		out_obj = h1{ display_page }
		out_obj << a( B % homepage ){ homepage }
		out_obj << pre{ page_data.gsub(/([A-Z]\w+){2}/){ |matchings| a( B % matchings ){ matchings } }}
		out_obj << form("get"){ textarea(' d' ){ page_data } + hidden( 'page name', display_page ) + submit }
		
		out_obj
	}
}