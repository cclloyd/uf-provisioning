# == Class: ufprovisioning::config
class ufprovisioning::config {
	
	assert_private()
	
	$webserver_manage	= $::ufprovisioning::params::webserver_manage
	$site_name			= $::ufprovisioning::params::site_name
	
	class { ::letsencrypt: 
		email		=> 'cclloyd9786@gmail.com',
		#server => 'https://acme-v01.api.letsencrypt.org/directory',
	}
	
	letsencrypt::certonly { '${site_name}_certs': 
		domains 	=> [$site_name],
	}
	
	
	#file { '/etc/ntp.conf':
	#	ensure  => file,
	#	owner   => 'root',
	#	group   => 'root',
	#	mode    => 0644,
	#	content => template($module_name/ntp.conf.erb),
	#}
	
	nginx::resource::server { $site_name:
		ensure			=>	present,
		server_name 	=>	[$site_name],
		www_root 		=>	'/var/www/${site_name}/public',
		listen_port 	=>	80,
		ssl 			=>	true,
		ssl_cert		=>	'/etc/letsencrypt/live/${site_name}/fullchain.pem',
		ssl_key			=>	'/etc/letsencrypt/live/${site_name}/private_key.pem',
		ssl_port		=>	443,
	}
	
	nginx::resource::location { '${site_name}_letsencrypt':
		ensure			=>	present,
		server		 	=>	$site_name,
		www_root 		=>	'/var/www/${site_name}/public/.well_known',
		listen_port 	=>	80,
		ssl_port		=>	443,
		allow			=>	'all',
	}
	
	
	
	
	
	
	
	
	
	#file { "/etc/nginx/sites-available/cclloyd.com.conf":
	#	ensure => "present",
	#	source  => "puppet:///modules/ufprovisioning/conf/cclloyd.com.conf",
	#	owner   => 'root',
	#	group   => 'root',
	#	mode    => '0755',
	#	require => Package['nginx']
	#}
	
	
	file { "/testtemplate.conf":
		ensure => "present",
		#source  => "puppet:///modules/ufprovisioning/templates/testtemplate.epp",
		content => epp('ufprovisioning/testtemplate.epp', { 'site_name' => $site_name }),
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		require => Package['nginx']
	}
	
	
	

	#file { '/etc/nginx/sites-enabled/cclloyd.com.conf':
	#	ensure => 'link',
	#	target => '/etc/nginx/sites-available/cclloyd.com.conf',
	#}

}