class ufprovisioning {
	
	
	#Boolean $webserver_manage		= true,
	$webserver_manage				= $::ufprovisioning::params::webserver_manage,
	$site_name						= $::ufprovisioning::params::site_name,
	#$daemon_user					= $::nginx::params::daemon_user,

	include ufprovisioning::params
	
	include ufprovisioning::install
	include ufprovisioning::config
	include ufprovisioning::service
	
}
