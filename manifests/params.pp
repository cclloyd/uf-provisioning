
class ufprovisioning::params {

	#$site_name = "notarealsite"

	$site_name				= "site-name"
	$webserver_manage		= true
	
	
	$_module_parameters = merge($_module_defaults, $_module_os_overrides)
	
}

