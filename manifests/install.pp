# == Class: ufprovisioning::install
class ufprovisioning::install {

	package { 'tree':
		ensure => installed,
	}
	
	package { 'nginx':
		ensure => installed,
	}

}