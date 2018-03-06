class ufprovisioning (
	
	$webserver_manage	= $::ufprovisioning::params::webserver_manage,
	$site_name			= $::ufprovisioning::params::site_name,
	

) inherits ::ufprovisioning::params {

	contain ufprovisioning::install
	contain ufprovisioning::config
	contain ufprovisioning::service
	
	# Allow the end user to establish relationships to the "main" class
	# and preserve the relationship to the implementation classes through
	# a transitive relationship to the composite class.
	Class['::ufprovisioning::install'] -> Class['::ufprovisioning::config'] ~> Class['::ufprovisioning::service']
	Class['::ufprovisioning::install'] ~> Class['::ufprovisioning::service']
}
