class ufprovisioning::owncloud {

	$webserver_manage	= $::ufprovisioning::webserver_manage
	$site_name			= $::ufprovisioning::site_name
	$sprinkle_name		= $ufprovisioning::sprinkle_name


	######################################################
	###  Git Deployment
	######################################################
	
	
	######################################################
	###  Web server
	######################################################
	
	class { '::php':
		ensure			=>	present,
		manage_repos	=>	true,
		fpm				=>	true,
		composer		=>	true,
		settings		=>	{
			'PHP/post_max_size'	=> '512M',
		},
		extensions		=>	{
			gd			=>	{ },
			mbstring	=>	{ },
			pgsql		=>	{ },
		},
	}
	
	letsencrypt::certonly { "cloud.${site_name}": }
	
	nginx::resource::server { "cloud.${site_name}":
		listen_port 	=> 80,
		www_root 		=>	"/var/www/owncloud",
		ssl_redirect	=>	true,
		ssl 			=>	true,
		ssl_cert		=>	"/etc/letsencrypt/live/cloud.${site_name}/fullchain.pem",
		ssl_key			=>	"/etc/letsencrypt/live/cloud.${site_name}/privkey.pem",
		ssl_port		=>	443,	
	}
	
	
	######################################################
	###  Database server
	######################################################
	
	
		
	postgresql::server::role { 'owncloud':
		password_hash	=> postgresql_password('owncloud', 'secret'),
	}
	
	postgresql::server::db { 'owncloud':
		user		=> 'owncloud',
		password	=> postgresql_password('owncloud', 'secret'),
	}
	
	postgresql::server::database_grant { 'owncloud':
		privilege	=> 'ALL',
		db			=> 'owncloud',
		role		=> 'owncloud',
	}
	
}




