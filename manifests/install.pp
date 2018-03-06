#
#
#
#
#
#
#
#
#

class ufprovisioning::install {
	
	class { 'nginx': }
	
	package { 'tree':
		ensure => installed,
	}
	
	
	
	#class{'nginx':
	#	manage_repo => true,
	#	package_source => 'nginx-mainline'
	#}

}