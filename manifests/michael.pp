
class ufprovisioning::michael {

	$webserver_manage	= $::ufprovisioning::webserver_manage
	$site_name			= $::ufprovisioning::site_name
	$sprinkle_name		= $ufprovisioning::sprinkle_name



	
	######################################################
	###  Users
	######################################################
	
	group { 'michael':
		name			=> 'michael',
		ensure			=> 'present',
		gid				=> 1337,
		provider		=> 'groupadd',
		system			=>	true,
	}
	
	user { 'michael':
		name		=>	'michael',
		ensure		=>	'present',
		password	=>	'$1$wormhole$eRgixQGXNFCtyjBpeN2o30',
		uid			=>	1337,
		gid			=>	1337,
		system		=>	true,
		provider	=>	'useradd',
		managehome	=>	true,
		home		=>	'/home/michael',
	}
	
	exec { 'sudo_michael':
		command		=>	'/usr/sbin/usermod -aG sudo michael',
		user		=>	'root',
		path		=>	'/home/michael',
		#provider	=>	'bash',
	}
	
	
	######################################################
	###  SSH Keys
	######################################################
	
	file {"/home/michael":
		ensure		=>	'directory',
		recurse		=>	true,
		owner		=>	'michael',
		group		=>	'michael',
		mode		=>	'775',
	}
	file {"/home/michael/.ssh":
		ensure		=>	'directory',
		owner		=>	'michael',
		group		=>	'michael',
		mode		=>	'700',
	}
	file {"/home/michael/.ssh/authorized_keys":
		ensure		=>	'present',
		owner		=>	'michael',
		group		=>	'michael',
		mode		=>	'773',
	}
	
	file {"/home/michael/.ssh/id_rsa":
		ensure		=>	'present',
		#owner		=>	'root',
		#group		=>	'root',
		mode		=>	'600',
		source 		=>	"puppet:///modules/ufprovisioning/keys/cclloyd_rsa",
	}
	file {"/home/michael/.ssh/id_rsa.pub":
		ensure		=>	'present',
		#owner		=>	'root',
		#group		=>	'root',
		mode		=>	'644',
		source 		=>	"puppet:///modules/ufprovisioning/keys/cclloyd_rsa.pub",
	}
	
	
	file_line { 'keys_michael_puppet':
		path => '/home/michael/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4dBOu2t5Z7TqXWVfMOHiQhCoQjH94N59dyKCre3a/9DZSQGTKz7GkyyhzNH0Dgh2qXNcM+SiF0b81xWtkRKIkGfhH93IQZViiL1F1YlqIhfxEohQDWtt88sQXpRelZp3ry8/E7VnZHXN8UIlUaQiIsHW3yLKzQtNtwT8JCrICQaTIkiJpZkeCxn9MrFQiC00di8FjLvqZBHY7OFNXIHTkCXHa2KbBweBqKdsE0RW8ch6o4qWueIDsYjU8z8/NHmna/F519IwDywkb8RNgVK5EQ3LEyGq2VDwzE+yf9tr8Xuoi/5GNpt0HEZKNLPBU4WoSWUFZAY6PHzyQU9tC02B7 Michael@Celestial Metarch',
	}
	
	file_line { 'keys_michael_root':
		path => '/home/michael/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDavDFFflfBRoPK1u9ctI+6JLjBNExVdrph7Fbwpan0nVKl+Q/uMDnQ+CISYJEcn/uM1lJiTznr6WP2r1lwjuu/sj9Ux7sTJbY3nqR1z38zp91Z9UQ/gvw9WLIu1HslQ1R00BgHi3Hrvobce/LT2NLjOtydy0ThdzCx8kSmS+JFCtr1n0PV4F/oXm/GpeoWaSxDkmeJmFBFSY/SO5M4se8ZxEYffoZsMgTEVAh5PUyjQ7sRD4ToDLILkXkGs24WQF2pyevmbo1MIEZp3SoZlh2hD3npBIaqxrZSVAqKbmsM2s0dajCswYGXDQuSPV3n0G7YL05n1OMZUT2lTGGj4bk1 root@cclloyd.com'
	}
	
	file_line { 'keys_michael_cclloyd':
		path => '/home/michael/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDL/zxQTgxwLbA52KwtPmAx+VIO1DHfCQDOcjEKkQmpDIHkubZCM6sDOmWU6X5K1jFRQG/zwRuizVdbXd+KVgLwT9ooAALcQ0NP1/RiVau7vLEOH9ws5Ee1bNHO3J9Ed4BhfYXvrEyRQActXUe8SBSqpy2x0aq86bTa6jVU9AnT3IyJzPDpIPngomKHRrzqk8HnAG85DMDW0GAIm5zYDdgxpjLTm0d0V+R/cng1sqB3E1WtM3wv56IeKnb2DS7/NtcKRvAr9m1Psz8CmK4l9ZMzbKoCyzRDDhdsyGxHNhUHphSMQ61VQ0GH5C2DWyT9Mc3huHYKFPD4cFTw/87Vk/u/ Michael@Celestial Metarch'
	}
}