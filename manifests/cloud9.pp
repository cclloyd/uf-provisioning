	
	
class ufprovisioning::cloud9 {

	
	
	
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
	###  Bash Customization
	######################################################
	
	file {"/home/c9/.bashrc":
		ensure		=>	'present',
		owner		=>	'michael',
		group		=>	'michael',
		mode		=>	'775',
		source 		=>	"puppet:///modules/ufprovisioning/templates/bashrc",
	}
	
	
	
	
	######################################################
	###  SSH
	######################################################
	
	file_line { 'keys_c9_cclloyd':
		path => '/root/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDL/zxQTgxwLbA52KwtPmAx+VIO1DHfCQDOcjEKkQmpDIHkubZCM6sDOmWU6X5K1jFRQG/zwRuizVdbXd+KVgLwT9ooAALcQ0NP1/RiVau7vLEOH9ws5Ee1bNHO3J9Ed4BhfYXvrEyRQActXUe8SBSqpy2x0aq86bTa6jVU9AnT3IyJzPDpIPngomKHRrzqk8HnAG85DMDW0GAIm5zYDdgxpjLTm0d0V+R/cng1sqB3E1WtM3wv56IeKnb2DS7/NtcKRvAr9m1Psz8CmK4l9ZMzbKoCyzRDDhdsyGxHNhUHphSMQ61VQ0GH5C2DWyT9Mc3huHYKFPD4cFTw/87Vk/u/ Michael@Celestial Metarch'
	}
	
	file_line { 'keys_c9_c9':
		path => '/root/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC50NKAANeZZVJRP1jIpeertcMKB1H69LZBhhpA8AfobIPGZP+Zq0x35fJQjwRJh1XtvPdyTirkOv2iS68bJmUIxkHz3eCqUslz1PYGVcUvABzkBNhgzLnUrxgju1gpjhSUhXZODxOIug/I9YsJkfkxnFfjUgZmFGuwdmlyGHqTLXSsT8G+oXEwUFFbFrjN03D7WxUdTpZJrwSPtFnRCz3ItQ7PFDWX2IitUm99QOlLdBxX51ZYHNaleC4r81DDX/BB2aOXrkzJLQyjU/9t6j/KqvMEgnke5f2M5Aq7pNBiROiJsQA8cs6GskAOUGrF9leOyDkzvwXcfroNkZwzjsiKC0DVtOIaWV2X0UJYGoz1FgXRrrl1K0zwqQN0bxztSYcg7ZXElAiF2eBnH7Z6XvP2eviFP5IBnZ62xUntKMS26ve67oBLgkpSp3fdzz2FZFbaD488z5Z2YbG5AW+PrHrYeA1oVTmKWi0qFnI5iLOErROFVEFc60LPNarGAiIHJ5GXz6PzoGEks7TdrA21dPIyAapUcGUpEE2xZGIxa/60W2y3IaMyPbDFKHQ8WmcBDEDMz30Arwep8B5nGx+f/Dk/4iscotyCjKFrlJMyOMg9N8srR8QLJzgqYwsa5QYGV4Kj6D7qRPCABbragzYGOuOktubQZJP7a3+PxMTmE2IwoQ== root+407729815142@cloud9.amazon.com'
	}
	
	
	
}