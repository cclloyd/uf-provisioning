# == Class: ufprovisioning::config
class ufprovisioning::config {

	
	$webserver_manage				= $::ufprovisioning::params::webserver_manage
	$site_name						= $::ufprovisioning::params::site_name
	
	
	#file { '/etc/ntp.conf':
	#	ensure  => file,
	#	owner   => 'root',
	#	group   => 'root',
	#	mode    => 0644,
	#	content => template($module_name/ntp.conf.erb),
	#}
	
	nginx::resource::server { 'www.puppetlabs.com':
		ensure			=>	present,
		server_name 	=>	'cclloyd.com',
		www_root 		=>	'/var/www/cclloyd.com',
		listen_port 	=>	80,
		ssl 			=>	'false',
	}
	
	#file { "/etc/nginx/sites-available/cclloyd.com.conf":
	#	ensure => "present",
	#	source  => "puppet:///modules/ufprovisioning/conf/cclloyd.com.conf",
	#	owner   => 'root',
	#	group   => 'root',
	#	mode    => '0755',
	#	require => Package['nginx']
	#}
	
	
	
	file { "/etc/nginx/sites-available/testtemplate.conf":
		ensure => "present",
		#source  => "puppet:///modules/ufprovisioning/templates/testtemplate.epp",
		content => template('ufprovisioning/testtemplate.erb'),
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		require => Package['nginx']
	}
	
	
	

	file { '/etc/nginx/sites-enabled/cclloyd.com.conf':
		ensure => 'link',
		target => '/etc/nginx/sites-available/cclloyd.com.conf',
	}

}