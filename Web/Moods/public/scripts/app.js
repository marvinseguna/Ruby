function AppViewModel() {
	var self = this;
	this.username = ko.observable( "Enter name" ); 
	
	$.getJSON( "/GetPreviousUsername", function( returnedMachineUser ) {
		var machineUser = returnedMachineUser.machine_user;
		self.username( machineUser ); 
    }); 
}

function AcceptInput( mood ) {
	var username = appViewModel.username();
	
	alert(username);
	alert(mood);
	if( username == '' ) { //If username is not provided -> alert
		alert( 'Kindly provide username before selecting your mood!' );
	}
	else { //else, add user in cookie & file system
		var data = { username : username, mood : mood }
		$.getJSON("/SaveMood", data, function() {
			alert( 'Thanks!' );
		});
	}
}

var appViewModel = new AppViewModel();
ko.applyBindings( appViewModel );