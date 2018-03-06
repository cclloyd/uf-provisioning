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

}