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
	
	nginx::resource::location { "~ \.php$":
		server		 	=>	"cloud.${site_name}",
		www_root 		=>	"/var/www/cloud.${site_name}",
		index_files     => ['index.php', 'index.html'],
		fastcgi         => "127.0.0.1:9000",
		#fastcgi_script  => undef,
		location_cfg_append => {
			fastcgi_connect_timeout => '3m',
			fastcgi_read_timeout    => '3m',
			fastcgi_send_timeout    => '3m'
		}
	}
	
	
	######################################################
	###  Database server
	######################################################
	
	
		
	postgresql::server::role { 'nextcloud':
		password_hash	=> postgresql_password('nextcloud', 'secret'),
	}
	
	postgresql::server::db { 'nextcloud':
		user		=> 'nextcloud',
		password	=> postgresql_password('nextcloud', 'secret'),
	}
	
	postgresql::server::database_grant { 'nextcloud':
		privilege	=> 'ALL',
		db			=> 'nextcloud',
		role		=> 'nextcloud',
	}
	
}




