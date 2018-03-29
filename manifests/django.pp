class ufprovisioning::django {

	$webserver_manage	= $::ufprovisioning::webserver_manage
	$site_name			= $::ufprovisioning::site_name
	$sprinkle_name		= $ufprovisioning::sprinkle_name

	
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
	
	package { 'psycopg2':
		ensure 		=> 	installed,
		provider	=>	'pip3',
	}
	
	package { 'django':
		ensure 		=> 	installed,
		provider	=>	'pip3',
	}
	
	
	######################################################
	###  Git Deployment
	######################################################
	
	
	
	#file { "/var/repo/${site_name}_django.git":
	#	ensure		=>	'directory',
	#	recurse		=>	true,
	#	owner		=>	'git',
	#	group		=>	'git',
	#	mode		=>	'775',
	#}
	
	file { "/var/www/${site_name}_django":
		ensure		=>	'directory',
		recurse		=>	true,
		mode		=>	'777',
	}
	
	vcsrepo{ "/var/repo/${site_name}_django.git":
		ensure 		=> bare,
		provider	=>	git,
		user		=>	'git',
	}
	
	file {"/var/repo/${site_name}_django.git/hooks/post-receive":
		ensure		=>	'present',
		mode		=>	'777',
		content		=>	template('ufprovisioning/post-receive-django.erb'),
	}
	
	
	#vcsrepo { "/home/git/${site_name}_django":
	#	ensure  	=> 	present,
	#	provider	=> 	git,
	#	source  	=> 	'git@bitbucket.org:cclloyd9785/websrd-django.git',
	#	user		=>	'git',
	#}
	#
	#exec { 'pull_changes':
	#	command		=>	"/usr/bin/git --git-dir=/home/git/${site_name}_django/.git pull",
	#	user		=>	'git',
	#	path		=>	"/home/git",
	#	#provider	=>	'bash',
	#}
	
	#file { "/home/git/${site_name}_django":
	#	ensure		=>	'directory',
	#	recurse		=>	true,
	#	mode		=>	'777',
	#}
	
	#exec { 'collectstatic':
	#	command		=>	"/usr/bin/python3 /home/git/${site_name}_django/websrd/manage.py collectstatic --noinput",
	#	user		=>	'git',
	#	path		=>	'/home/git',
	#	#provider	=>	'bash',
	#}
	
	
	
	######################################################
	###  Web server
	######################################################
	
	letsencrypt::certonly { $site_name: }
	
	nginx::resource::server { $site_name:
		listen_port 	=> 80,
		proxy       	=> 'https://localhost:8000',
		ssl_redirect	=>	true,
		ssl 			=>	true,
		ssl_cert		=>	"/etc/letsencrypt/live/${site_name}/fullchain.pem",
		ssl_key			=>	"/etc/letsencrypt/live/${site_name}/privkey.pem",
		ssl_port		=>	443,	
	}
	
	nginx::resource::location{'/staticfiles/':
		server 			=>	$site_name,
		location_alias	=>	"/var/www/${site_name}_django/websrd/staticfiles/",
		ssl 			=>	true,
	}
	
	file { "/etc/supervisor/conf.d/${site_name}.conf":
		ensure		=>	'present',
		content		=>	template('ufprovisioning/supervisor.erb'),
	}
	
	######################################################
	###  Database server
	######################################################
	
	
	class { 'postgresql::server': 
		postgres_password	=>	"SlipspaceTransmission",
	}
		
	postgresql::server::role { 'django':
		password_hash	=> postgresql_password('django', 'secret'),
	}
	
	postgresql::server::db { 'websrd':
		user		=> 'django',
		password	=> postgresql_password('django', 'secret'),
	}
	
	postgresql::server::database_grant { 'websrd':
		privilege	=> 'ALL',
		db			=> 'websrd',
		role		=> 'django',
	}
	
}




