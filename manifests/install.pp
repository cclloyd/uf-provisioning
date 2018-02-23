# == Class: ufprovisioning::install
class ufprovisioning::install inherits ufprovisioning::base {

	package { 'nginx':
		ensure => installed,
	}

	package { 'python-pip':
		ensure => installed,
	}

}