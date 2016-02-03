function AppViewModel() {
	var self = this;
	
    this.mood = "happy.jpg";
	this.userprovidedname = ko.observable( "111111111" ); 
	
	$.getJSON("/GetMachineUser", function( returnedMachineUser ) {
		if( returnedMachineUser == "" ) {
			
		}
		else {
			var machineUser = returnedMachineUser.machine_user;
			self.userprovidedname( machineUser ); 
		}
    }); 
}

ko.applyBindings(new AppViewModel());