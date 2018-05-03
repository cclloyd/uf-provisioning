class ufprovisioning::reactstack {

	$webserver_manage	= $::ufprovisioning::webserver_manage
	$site_name			= $::ufprovisioning::site_name
	$sprinkle_name		= $ufprovisioning::sprinkle_name

	letsencrypt::certonly { "${site_name}": }
	
	nginx::resource::server { "${site_name}":
		listen_port 	=> 80,
		www_root 		=>	"/var/www/opensrd-frontend",
		#ssl_redirect	=>	false,
		#ssl 			=>	true,
		#ssl_cert		=>	"/etc/letsencrypt/live/${site_name}/fullchain.pem",
		#ssl_key			=>	"/etc/letsencrypt/live/${site_name}/privkey.pem",
		#ssl_port		=>	443,	
	}
	
	
}




