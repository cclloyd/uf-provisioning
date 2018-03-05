class ufprovisioning {
	
	$site_name = "notarealsite"

	
	include ufprovisioning::install
	include ufprovisioning::config
	include ufprovisioning::service
	
}

class ufprovisioning::ufprovisioning {
	
	
	include ufprovisioning::install
	include ufprovisioning::config
	include ufprovisioning::service
	
}
