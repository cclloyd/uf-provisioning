class ufprovisioning (
	
	
	#Boolean $webserver_manage		= true,
	$webserver_manage				= $::ufprovisioning::params::webserver_manage,
	$site_name						= $::ufprovisioning::params::site_name
	#$daemon_user					= $::nginx::params::daemon_user

	#include ufprovisioning::params
	
	#include ufprovisioning::install
	#include ufprovisioning::config
	#include ufprovisioning::service
	

) inherits ::ufprovisioning::params {

	#contain '::nginx::package'
	#contain '::nginx::config'
	#contain '::nginx::service'
	
	contain ufprovisioning::install
	contain ufprovisioning::config
	contain ufprovisioning::service
	
	# Allow the end user to establish relationships to the "main" class
	# and preserve the relationship to the implementation classes through
	# a transitive relationship to the composite class.
	#Class['::nginx::package'] -> Class['::nginx::config'] ~> Class['::nginx::service']
	#Class['::nginx::package'] ~> Class['::nginx::service']
}
