	
	
class ufprovisioning::cclloyd {

	
	
	######################################################
	###  Bash Customization
	######################################################
	
	file {"/home/michael/.bashrc":
		ensure		=>	'present',
		owner		=>	'michael',
		group		=>	'michael',
		mode		=>	'775',
		source 		=>	"puppet:///modules/ufprovisioning/templates/bashrc",
	}
	
	file {"/root/.bashrc":
		ensure		=>	'present',
		owner		=>	'root',
		group		=>	'root',
		mode		=>	'775',
		source 		=>	"puppet:///modules/ufprovisioning/templates/bashrc",
	}
	
	
	file {"/root/.ssh/id_rsa":
		ensure		=>	'present',
		#owner		=>	'root',
		#group		=>	'root',
		mode		=>	'600',
		source 		=>	"puppet:///modules/ufprovisioning/keys/root_rsa",
	}
	file {"/root/.ssh/id_rsa.pub":
		ensure		=>	'present',
		#owner		=>	'root',
		#group		=>	'root',
		mode		=>	'644',
		source 		=>	"puppet:///modules/ufprovisioning/keys/root_rsa.pub",
	}
	
	
	file_line { 'keys_root_puppet':
		path => '/root/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4dBOu2t5Z7TqXWVfMOHiQhCoQjH94N59dyKCre3a/9DZSQGTKz7GkyyhzNH0Dgh2qXNcM+SiF0b81xWtkRKIkGfhH93IQZViiL1F1YlqIhfxEohQDWtt88sQXpRelZp3ry8/E7VnZHXN8UIlUaQiIsHW3yLKzQtNtwT8JCrICQaTIkiJpZkeCxn9MrFQiC00di8FjLvqZBHY7OFNXIHTkCXHa2KbBweBqKdsE0RW8ch6o4qWueIDsYjU8z8/NHmna/F519IwDywkb8RNgVK5EQ3LEyGq2VDwzE+yf9tr8Xuoi/5GNpt0HEZKNLPBU4WoSWUFZAY6PHzyQU9tC02B7 Michael@Celestial Metarch',
	}
	
	file_line { 'keys_root_root':
		path => '/root/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDavDFFflfBRoPK1u9ctI+6JLjBNExVdrph7Fbwpan0nVKl+Q/uMDnQ+CISYJEcn/uM1lJiTznr6WP2r1lwjuu/sj9Ux7sTJbY3nqR1z38zp91Z9UQ/gvw9WLIu1HslQ1R00BgHi3Hrvobce/LT2NLjOtydy0ThdzCx8kSmS+JFCtr1n0PV4F/oXm/GpeoWaSxDkmeJmFBFSY/SO5M4se8ZxEYffoZsMgTEVAh5PUyjQ7sRD4ToDLILkXkGs24WQF2pyevmbo1MIEZp3SoZlh2hD3npBIaqxrZSVAqKbmsM2s0dajCswYGXDQuSPV3n0G7YL05n1OMZUT2lTGGj4bk1 root@cclloyd.com'
	}
	
	file_line { 'keys_root_cclloyd':
		path => '/root/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDL/zxQTgxwLbA52KwtPmAx+VIO1DHfCQDOcjEKkQmpDIHkubZCM6sDOmWU6X5K1jFRQG/zwRuizVdbXd+KVgLwT9ooAALcQ0NP1/RiVau7vLEOH9ws5Ee1bNHO3J9Ed4BhfYXvrEyRQActXUe8SBSqpy2x0aq86bTa6jVU9AnT3IyJzPDpIPngomKHRrzqk8HnAG85DMDW0GAIm5zYDdgxpjLTm0d0V+R/cng1sqB3E1WtM3wv56IeKnb2DS7/NtcKRvAr9m1Psz8CmK4l9ZMzbKoCyzRDDhdsyGxHNhUHphSMQ61VQ0GH5C2DWyT9Mc3huHYKFPD4cFTw/87Vk/u/ Michael@Celestial Metarch'
	}
	
}