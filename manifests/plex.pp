
class ufprovisioning::plex {

	$webserver_manage	= $::ufprovisioning::webserver_manage
	$site_name			= $::ufprovisioning::site_name
	$sprinkle_name		= $ufprovisioning::sprinkle_name

	
	######################################################
	###  Plex Media Server
	######################################################
	
	apt::source { 'plexmediaserver':
		comment  => 'This is the apt repo for plex.tv on Ubuntu.',
		location => 'https://downloads.plex.tv/repo/deb',
		release => 'public',
		repos    => 'main',
		key      => {
			#'id'    	=>	'3ADCA79D',
			'id'		=>	'CD665CBA0E2F88B7373F7CB997203C7B3ADCA79D',
			'server'	=>	'pgpkeys.mit.edu',
		},
	}
	
	package { 'plexmediaserver':
		ensure => latest,
	}
}