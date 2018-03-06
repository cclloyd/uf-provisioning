# == Class: ufprovisioning::config
class ufprovisioning::config {
	
	assert_private()
	
	$webserver_manage	= $::ufprovisioning::params::webserver_manage
	$site_name			= $::ufprovisioning::params::site_name
	
	class { ::letsencrypt: 
		config => {
			email		=> 'cclloyd9786@gmail.com',
			server => 'https://acme-v01.api.letsencrypt.org/directory',
		}
	}
	class{git:
		ensure => 'installed',
	}
	
	letsencrypt::certonly { $site_name: }
	
	
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
		www_root 		=>	"/var/www/${site_name}/public",
		listen_port 	=>	80,
		ssl 			=>	true,
		ssl_cert		=>	"/etc/letsencrypt/live/${site_name}/fullchain.pem",
		ssl_key			=>	"/etc/letsencrypt/live/${site_name}/privkey.pem",
		ssl_port		=>	443,
	}
	
	nginx::resource::location { "~ /.well-known":
		ensure			=>	present,
		server		 	=>	$site_name,
		#www_root 		=>	"/var/www/${site_name}/public/.well_known",
	}
	
	
	
	$keys = '/home/git/.ssh/authorized_keys'
	concat { $keys:
		owner => 'git',
		group => 'git',
		mode  => '0775'
	}
	concat::fragment{ 'mac_key':
		target  => $keys,
		content => "puppet:///modules/ufprovisioning/conf/cclloyd_rsa.pub",
		order   => '01',
	}
	
	
	git::user { 'git':
		user_name  => 'git',
		user_email => 'git@cclloyd.com',
	}
	
	git::config{'git_core_autocrlf':
		config   => 'core.autocrlf',
		value    => 'input',
		provider => 'global',
		user     => 'git',
	}
	
	file { "/var/repo/${site_name}.git":
		ensure		=>	'directory',
		recurse		=>	true,
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'755',
	}
	
	vcsrepo{ "/var/repo/${site_name}.git":
		ensure 		=> bare,
		provider	=>	git,
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