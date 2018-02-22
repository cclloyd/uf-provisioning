# == Class: ufprovisioning::install
class ufprovisioning::install inherits ufprovisioning {

	package { 'nginx':
		ensure => installed,
	}

	package { 'python-pip':
		ensure => installed,
	}

}