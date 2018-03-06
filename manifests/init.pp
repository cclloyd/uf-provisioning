#
#
#
#
#
#
#
#
#

class ufprovisioning (
	
	$webserver_manage	= $ufprovisioning::params::webserver_manage,
	#$site_name			= $ufprovisioning::params::site_name,
	$site_name,

) inherits ufprovisioning::params {

	contain ufprovisioning::install
	contain ufprovisioning::config
	contain ufprovisioning::service
	
	Class['::ufprovisioning::install'] -> Class['::ufprovisioning::config'] ~> Class['::ufprovisioning::service']
	Class['::ufprovisioning::install'] ~> Class['::ufprovisioning::service']
}
