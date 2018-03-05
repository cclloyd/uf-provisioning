# == Class: ufprovisioning::install
class ufprovisioning::install {

	package { 'tree':
		ensure => installed,
	}

}