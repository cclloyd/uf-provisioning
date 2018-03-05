class ufprovisioning {
	

	
	include ufprovisioning::install
	include ufprovisioning::config
	include ufprovisioning::service
	
}

class ufprovisioning::ufprovisioning {
	
	String $site_name = "notarealsite",
	
	include ufprovisioning::install
	include ufprovisioning::config
	include ufprovisioning::service
	
}
