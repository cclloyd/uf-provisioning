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
	
	class { 'nginx': 
		#manage_repo => true,
		#package_source => 'nginx-mainline'
	}
	
	package { 'tree':
		ensure => installed,
	}
	
	
	
	#class{'nginx':
	#	manage_repo => true,
	#	package_source => 'nginx-mainline'
	#}

}