
class ufprovisioning::userfrosting {
	
	
	$webserver_manage	= $::ufprovisioning::webserver_manage
	$site_name			= $::ufprovisioning::site_name
	$sprinkle_name		= $ufprovisioning::sprinkle_name

	
	
	#class { '::composer': }
	
	class { '::nodejs':
		version => 'latest',
	}

	
	class { '::php::globals':
		php_version		=> '7.0',
	}->
	class { '::php':
		ensure			=>	present,
		manage_repos	=>	true,
		fpm				=>	true,
		composer		=>	true,
		settings		=>	{
			'PHP/post_max_size'	=> '32M',
		},
		extensions		=>	{
			gd			=>	{ },
			mbstring	=>	{ },
			pgsql		=>	{ },
		},
	}
	class { 'postgresql::server': 
		postgres_password	=>	"SlipspaceTransmission",
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	######################################################
	###  SSL
	######################################################
	
	letsencrypt::certonly { $site_name: }
	letsencrypt::certonly { "stats.${site_name}":	}
	
	
	
	
	######################################################
	###  Nginx
	######################################################
	
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
	
	file { "/var/www":
		ensure		=>	'directory',
		owner		=>	'www-data',
		group		=>	'www-data',
		mode		=>	'775',
	}
	
	file { "/var/www/${site_name}":
		ensure		=>	'directory',
		recurse		=>	true,
		owner		=>	'www-data',
		group		=>	'www-data',
		mode		=>	'777',
	}
	
	file {"/var/www/${site_name}/app":
		ensure		=>	'directory',
		recurse		=>	true,
	}
	
	file {"/var/www/${site_name}/app/sprinkles.json":
		ensure		=>	'present',
		content		=>	template('ufprovisioning/sprinkles.json.erb'),
	}
	
	file {"/var/www/${site_name}/app/cache":
		ensure		=>	'directory',
		recurse		=>	true,
		mode		=>	'777',
	}
	
	
	
	######################################################
	###  Database (Postgre)
	######################################################
	
	$database_user 		=	"userfrosting"
	
	postgresql::server::role { 'userfrosting':
		password_hash	=> postgresql_password($database_user, 'secret'),
	}
	
	postgresql::server::db { $sprinkle_name:
		user		=> $database_user,
		password	=> postgresql_password($database_user, 'secret'),
	}
	
	postgresql::server::database_grant { 'userfrosting':
		privilege	=> 'ALL',
		db			=> $sprinkle_name,
		role		=> 'userfrosting',
	}
	
	
	
	
	######################################################
	###  Git
	######################################################	
	
	file { "/var/repo/${site_name}.git":
		ensure		=>	'directory',
		recurse		=>	true,
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'775',
	}
	
	vcsrepo{ "/var/repo/${site_name}.git":
		ensure 		=> bare,
		provider	=>	git,
		user		=>	'git',
	}
	
	vcsrepo { "/home/git/${site_name}":
		ensure  	=> 	present,
		provider	=> 	git,
		source  	=> 	'git@bitbucket.org:cclloydcom/userfrosting.git',
		user		=>	'git',
		submodules	=>	true,
	}
	
	file {"/var/repo/${site_name}.git/hooks/post-receive":
		ensure		=>	'present',
		mode		=>	'777',
		content		=>	template('ufprovisioning/post-receive.erb'),
	}
	
	
}