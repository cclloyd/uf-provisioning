class ufprovisioning::django {

	
	
	######################################################
	###  Bash Customization
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
	
	package { 'uwsgi':
		ensure 		=> 	installed,
		provider	=>	'apt',
	}
	
	package { 'setuptools':
		ensure 		=> 	installed,
		provider	=>	'pip3',
	}
	
	package { 'wheel':
		ensure 		=> 	installed,
		provider	=>	'pip3',
	}
	
	package { 'django':
		ensure 		=> 	installed,
		provider	=>	'pip3',
	}
	
	
	
	vcsrepo { "/home/git/${site_name}_django":
		ensure  	=> 	present,
		provider	=> 	git,
		source  	=> 	'git@bitbucket.org:cclloyd9785/websrd-django.git',
		user		=>	'git',
	}
}