class ufprovisioning::reactstack {

	$webserver_manage	= $::ufprovisioning::webserver_manage
	$site_name			= $::ufprovisioning::site_name
	$sprinkle_name		= $ufprovisioning::sprinkle_name

	letsencrypt::certonly { "${site_name}": }
	
	file {"/var/www":
		ensure		=>	'directory',
		owner		=>	'www-data',
		group		=>	'www-data',
		mode		=>	'755',
		source 		=>	"puppet:///modules/ufprovisioning/templates/bashrc",
	}
	
	file {"/var/www/opensrd-frontend":
		ensure		=>	'directory',
		owner		=>	'www-data',
		group		=>	'www-data',
		mode		=>	'755',
	}
	
	nginx::resource::server { "${site_name}":
		listen_port 	=> 80,
		www_root 		=>	"/var/www/opensrd-frontend",
		ssl_redirect	=>	false,
		ssl 			=>	true,
		ssl_cert		=>	"/etc/letsencrypt/live/${site_name}/fullchain.pem",
		ssl_key			=>	"/etc/letsencrypt/live/${site_name}/privkey.pem",
		ssl_port		=>	443,	
	}
	
	nginx::resource::location{'/api':
		server 			=>	$site_name,
		proxy			=>	"https://${site_name}:8000",
		ssl 			=>	true,
	}
	
	
	
	
	
	
	
	
	
	
	
	
	######################################################
	###  Packages
	######################################################
	
	package { 'virtualenv':
		ensure 		=> 	installed,
		provider	=>	'apt',
	}	
	
	package { 'virtualenvwrapper':
		ensure 		=> 	installed,
		provider	=>	'apt',
	}
	
	package { 'python3-dev':
		ensure 		=> 	installed,
		provider	=>	'apt',
	}
	
	package { 'python3-pip':
		ensure 		=> 	installed,
		provider	=>	'apt',
	}
	
	package { 'gunicorn':
		ensure 		=> 	installed,
		provider	=>	'pip3',
	}
	
	package { 'supervisor':
		ensure 		=> 	installed,
		provider	=>	'apt',
	}
	
	package { 'uwsgi':
		ensure 		=> 	installed,
		provider	=>	'pip3',
	}
	
	package { 'setuptools':
		ensure 		=> 	installed,
		provider	=>	'pip3',
	}
	
	package { 'wheel':
		ensure 		=> 	installed,
		provider	=>	'pip3',
	}
	
	package { 'psycopg2-binary':
		ensure 		=> 	installed,
		provider	=>	'pip3',
	}
	
	package { 'django':
		ensure 		=> 	installed,
		provider	=>	'pip3',
	}
	
	
	
	
	
	
	
	file {"/var/www/opensrd-api":
		ensure		=>	'directory',
		owner		=>	'www-data',
		group		=>	'www-data',
		mode		=>	'755',
	}
	
	file { "/etc/supervisor/conf.d/${site_name}.conf":
		ensure		=>	'present',
		content		=>	template('ufprovisioning/supervisor.erb'),
	}
	
	class { 'postgresql::server': 
		postgres_password	=>	"SlipspaceTransmission",
	}
		
	postgresql::server::role { 'django':
		password_hash	=> postgresql_password('django', 'secret'),
	}
	
	postgresql::server::db { 'opensrd':
		user		=> 'django',
		password	=> postgresql_password('django', 'secret'),
	}
	
	postgresql::server::database_grant { 'opensrd':
		privilege	=> 'ALL',
		db			=> 'opensrd',
		role		=> 'django',
	}
	
}




