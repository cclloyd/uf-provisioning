
class ufprovisioning::params {

	#$site_name = "notarealsite"
	$_module_parameters = {
		'site_name'				=> "site-name"
		'webserver_manage'		=> true
	}
	
	$site_name = $_module_parameters['site_name']
	$webserver_manage = $_module_parameters['webserver_manage']
	
	#$_module_parameters = merge($_module_defaults, $_module_os_overrides)
	
}

