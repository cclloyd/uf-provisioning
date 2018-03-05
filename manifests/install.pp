# == Class: ufprovisioning::install
class ufprovisioning::install inherits ufprovisioning {

	package { 'tree':
		ensure => installed,
	}

}