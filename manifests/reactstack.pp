class ufprovisioning::reactstack {

	$webserver_manage	= $::ufprovisioning::webserver_manage
	$site_name			= $::ufprovisioning::site_name
	$sprinkle_name		= $ufprovisioning::sprinkle_name

	letsencrypt::certonly { "react.${site_name}": }
	
	nginx::resource::server { "react.${site_name}":
		listen_port 	=> 80,
		www_root 		=>	"/var/www/opensrd_fullstack/frontend/build",
		ssl_redirect	=>	true,
		ssl 			=>	true,
		ssl_cert		=>	"/etc/letsencrypt/live/react.${site_name}/fullchain.pem",
		ssl_key			=>	"/etc/letsencrypt/live/react.${site_name}/privkey.pem",
		ssl_port		=>	443,	
	}
	
}




