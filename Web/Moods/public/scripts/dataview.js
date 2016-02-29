function fillGrid() { //default is 1-week
	$.getJSON( "/GetMoodData", function( moodData ) {
		var table = document.getElementById( "moodTable" );
		var row = table.insertRow( 0 );
		var tableColumnHeaders = '';
		
		var fromDate = new Date();
		fromDate.setDate( fromDate.getDate() - 7 );
		for( var i = 0; i < 6; i++ ) {
			var fullDate = ( "0" + ( fromDate.getDate() + 1 )).slice( -2 ) + "/" + ( "0" + ( fromDate.getMonth() + 1 )).slice( -2 ) + "/" + fromDate.getFullYear();
			tableColumnHeaders += "<th scope=\"col\" colspan=\"3\" class=\"with_double_border\">" + fullDate + "</th>"
			
			fromDate.setDate( fromDate.getDate() + 1 );
		}
		var fullDate = ( "0" + ( fromDate.getDate() + 1 )).slice( -2 ) + "/" + ( "0" + ( fromDate.getMonth() + 1 )).slice( -2 ) + "/" + fromDate.getFullYear();
		tableColumnHeaders += "<th scope=\"col\" colspan=\"3\">" + fullDate + "</th>"
		
		row.innerHTML = "<th class=\"no_border_table\"></th>" + tableColumnHeaders;
	});
}