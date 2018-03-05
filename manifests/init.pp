class ufprovisioning {
	
	
	include ufprovisioning::install
	include ufprovisioning::config
	include ufprovisioning::service
	
	package { 'tree':
		ensure => installed,
	}
}

