
class ufprovisioning::bittorrent {

	$webserver_manage	= $::ufprovisioning::webserver_manage
	$site_name			= $::ufprovisioning::site_name
	$sprinkle_name		= $ufprovisioning::sprinkle_name


	class { 'transmission':
			rpc_username 	=>	'family',
			rpc_password	=>	'family',
			rpc_port     	=>	24011,
			peer_port    	=>	54612,
			encryption   	=>	2,
	}
	
	nginx::resource::server { "bt.${site_name}":
		listen_port => 80,
		proxy       => "http://${site_name}:24011",
	}
}