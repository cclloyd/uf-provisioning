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
	include git
	
	
	group { 'michael':
		name			=> 'michael',
		ensure			=> 'present',
		gid				=> 1337,
		provider		=> 'groupadd',
		system			=>	true,
	}
	
	user { 'michael':
		name		=>	'michael',
		ensure		=>	'present',
		password	=>	"$2y$10$c3mpxQYg25mLfxRLZVUX6e8gDkHy/.JfXHK3u3MfF9WSM/pVc2vei",
		uid			=>	1337,
		gid			=>	1337,
		system		=>	true,
		provider	=>	'useradd',
		managehome	=>	true,
		home		=>	'/home/michael',
		
	}
	exec { 'sudo_michael':
		command		=>	'/usr/sbin/usermod -aG sudo michael',
		user		=>	'root',
		path		=>	'/home/michael',
		#provider	=>	'bash',
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
	
	group { 'git':
		name			=> 'git',
		ensure			=> 'present',
		gid				=> 465,
		provider		=> 'groupadd',
		system			=>	true,
	}
	
	user { 'git':
		name		=>	'git',
		ensure		=>	'present',
		password	=>	"73aa606f6e0eb06e06b0dc606239564ed65a59af",
		uid			=>	465,
		gid			=>	465,
		system		=>	true,
		provider	=>	'useradd',
		managehome	=>	true,
		home		=>	'/home/git',
		
	}
	
	
	file {"/home/git/.ssh":
		ensure		=>	'directory',
		recurse		=>	true,
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'775',
	}
	file {"/home/git/.ssh/authorized_keys":
		ensure		=>	'present',
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'775',
	}
	
	
	$keys = '/home/git/.ssh/authorized_keys'
	
	concat { $keys:
		owner => 'git',
		group => 'git',
		mode  => '0775'
	}
	
	concat::fragment{ 'keys_header':
		target  => $keys,
		content => "# Authorized ssh keys\n",
		order   => '01',
	}
	
	concat::fragment{ 'mac_key':
		target  => $keys,
		source	=> "puppet:///modules/ufprovisioning/conf/cclloyd_rsa.pub",
		order   => '01',
	}
	
	
	git::config { 'user.name':
		value => 'git',
	}

	git::config { 'user.email':
		value => 'git@cclloyd.com',
	}
	
	
	file { [
		"/var/repo",
		"/var/repo/${site_name}.git",
	]:
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