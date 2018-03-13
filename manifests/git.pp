
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

}