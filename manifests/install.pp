# == Class: ufprovisioning::install
class ufprovisioning::install {

	package { 'tree':
		ensure => installed,
	}
	
	package { 'nginx':
		ensure => installed,
	}
	
	#class{'nginx':
	#	manage_repo => true,
	#	package_source => 'nginx-mainline'
	#}

}