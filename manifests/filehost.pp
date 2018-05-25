
class ufprovisioning::filehost {

  $webserver_manage	= $::ufprovisioning::webserver_manage
  $site_name			= $::ufprovisioning::site_name
  $sprinkle_name		= $ufprovisioning::sprinkle_name


  file { "/var/www/gamedvr.${site_name}":
    ensure		=>	'directory',
    recurse		=>	true,
    owner		=>	'www-data',
    group		=>	'www-data',
    mode		=>	'777',
  }


  nginx::resource::server { "gamedvr.${site_name}":
    ensure			=>	present,
    www_root 		=>	"/var/www/gamedvr.${site_name}/",
    listen_port 	=>	80,
    ssl 			=>	false,
  }
}