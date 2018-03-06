class ufprovisioning {
	
	
	#Boolean $webserver_manage		= true,
	Optional[Boolean] $webserver_manage				= $::ufprovisioning::params::webserver_manage
	Optional[String] $site_name						= $::ufprovisioning::params::site_name
	#$daemon_user					= $::nginx::params::daemon_user

	
	include ufprovisioning::install
	include ufprovisioning::config
	include ufprovisioning::service
	

}
