
class ufprovisioning::git {

	$webserver_manage	= $::ufprovisioning::webserver_manage
	$site_name			= $::ufprovisioning::site_name
	$sprinkle_name		= $ufprovisioning::sprinkle_name

	
	group { 'git':
		name			=> 'git',
		ensure			=> 'present',
		gid				=> 465,
		provider		=> 'groupadd',
		system			=>	true,
	}
	
	user { 'git':
		name		=>	'git',
		ensure		=>	'present',
		password	=>	'$1$wormhole$eRgixQGXNFCtyjBpeN2o30',
		uid			=>	465,
		gid			=>	465,
		system		=>	true,
		provider	=>	'useradd',
		managehome	=>	true,
		home		=>	'/home/git',
		
	}
	
	file { "/var/repo":
		ensure		=>	'directory',
		recurse		=>	true,
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'775',
	}
	
	
	git::config { 'user.name':
		value => 'git',
	}
	git::config { 'user.email':
		value => 'git@cclloyd.com',
	}
	
	
	
	
	file {"/home/git/.ssh":
		ensure		=>	'directory',
		recurse		=>	true,
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'700',
	}
	
	
	file {"/home/git/.ssh/authorized_keys":
		ensure		=>	'present',
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'773',
	}
	
	
	file {"/home/git/.ssh/id_rsa":
		ensure		=>	'present',
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'600',
		source 		=>	"puppet:///modules/ufprovisioning/keys/git_rsa",
	}
	
	
	file {"/home/git/.ssh/id_rsa.pub":
		ensure		=>	'present',
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'644',
		source 		=>	"puppet:///modules/ufprovisioning/keys/git_rsa.pub",
	}
	
	
	
	
	
	
	file_line { 'keys_git_mac':
		path => '/home/git/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFoyTIxhjZNIDocz2Pw4TlezAcwNXuEyo7oEfr+qsY8UWPaXKH8DcVXBTdPh2fcCYfzYJ98Ef8DhdvjMxpvSTw+3xETlC55qbHZdAkfNnZUZRaGmPZysy+jeErQEN2q6Flb6MX2ozEiQKwR4um1XaY1USW8dXO/bgVZ2EIAoE7Zu9wy2nqoHACH6phPVU6Wlg6w2jYQkNwxb+5FUo9mDREwshy7LwR5s8jxnsUJkEhC7ZImdEX9ZexAhfHkee9VWWkepxHtXE8D18uXEn/w8GCXwqlxJ6D5AtBGSAtSKcUIfsS63PKs8aVHoFX1eYX1UOHUlsNZuY6tr7/8Fq/Yr85 Michael@Celestial Metarch'
	}
	
	file_line { 'keys_git_git':
		path => '/home/git/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCYnyEPyq9itlw6tbw3Ptlj9I55eTKJ1m4MifRh8TEhCU53AQPmkuwH3X4/cdDN9KiNx4w4vJuDmqn9WVmmAVtqVwhNPTHJxxMVPsZXvV9uTT2XAhj8oibsfrFTQK1etFQEWhhnazawc12YXGt+sjixvoP6r6IfPyQdN9JVf2SxsGh/5YWtTHUcHFQ73UHwfbt4PXHnXE8weqeqjTFC5/zfAV0nAutsP6W8YVrTYRB7ZDdt3so6luzP38Lo8ZyQZT08uagteIsVDVRlwKktx5mIF/YX8KGpqnRoIH69b7moGOpoYDa5zorUFEwi+1lte3RfTbMt3xeVDIW/xyc1evRf git@cclloyd.com'
	}
	
	
	
	
	
	

}