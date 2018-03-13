# == Class: ufprovisioning::config
class ufprovisioning::config {
	
	assert_private()
	
	
	#######################################################
	####                            #######################
	###   Dependencies and Classes   ######################
	####                            #######################
	#######################################################
	
	$webserver_manage	= $::ufprovisioning::webserver_manage
	$site_name			= $::ufprovisioning::site_name
	$sprinkle_name		= $ufprovisioning::sprinkle_name


	class { ::letsencrypt: 
		config => {
			email		=> 'cclloyd9786@gmail.com',
			server => 'https://acme-v01.api.letsencrypt.org/directory',
		}
	}
	#class { 'apt':
	#	update => {
	#		frequency => 'daily',
	#	},
	#}
	
	include git
	
	#class { '::composer': }
	
	class { '::nodejs':
		version => 'latest',
	}

	
	class { '::php::globals':
		php_version		=> '7.0',
	}->
	class { '::php':
		ensure			=>	latest,
		manage_repos	=>	true,
		fpm				=>	true,
		composer		=>	true,
		settings		=>	{
			'PHP/post_max_size'	=> '32M',
		},
		extensions		=>	{
			gd			=>	{ },
			mbstring	=>	{ },
			pgsql		=>	{ },
		},
	}
	class { 'postgresql::server': 
		postgres_password	=>	"SlipspaceTransmission",
	}
	
	package { 'glances':
		ensure	=>	latest,
	}
	
	
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
	
	
	user { 'userfrosting':
		name		=>	'userfrosting',
		ensure		=>	'present',
		password	=>	'$1$wormhole$eRgixQGXNFCtyjBpeN2o30',
		uid			=>	487,
		system		=>	true,
		provider	=>	'useradd',
		managehome	=>	true,
		home		=>	'/home/userfrosting',
	}
	
	
	#user { 'deluge':
	#	name		=>	'deluge',
	#	ensure		=>	'present',
	#	#password	=>	'$1$wormhole$eRgixQGXNFCtyjBpeN2o30',
	#	system		=>	true,
	#	provider	=>	'useradd',
	#	#managehome	=>	true,
	#	home		=>	'/var/lib/deluge',
	#}
	
	
	
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
	
	file_line { 'keys_michael':
		path => '/home/michael/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4dBOu2t5Z7TqXWVfMOHiQhCoQjH94N59dyKCre3a/9DZSQGTKz7GkyyhzNH0Dgh2qXNcM+SiF0b81xWtkRKIkGfhH93IQZViiL1F1YlqIhfxEohQDWtt88sQXpRelZp3ry8/E7VnZHXN8UIlUaQiIsHW3yLKzQtNtwT8JCrICQaTIkiJpZkeCxn9MrFQiC00di8FjLvqZBHY7OFNXIHTkCXHa2KbBweBqKdsE0RW8ch6o4qWueIDsYjU8z8/NHmna/F519IwDywkb8RNgVK5EQ3LEyGq2VDwzE+yf9tr8Xuoi/5GNpt0HEZKNLPBU4WoSWUFZAY6PHzyQU9tC02B7 Michael@Celestial Metarch',
	}
	
	file_line { 'keys_michael':
		path => '/home/michael/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDavDFFflfBRoPK1u9ctI+6JLjBNExVdrph7Fbwpan0nVKl+Q/uMDnQ+CISYJEcn/uM1lJiTznr6WP2r1lwjuu/sj9Ux7sTJbY3nqR1z38zp91Z9UQ/gvw9WLIu1HslQ1R00BgHi3Hrvobce/LT2NLjOtydy0ThdzCx8kSmS+JFCtr1n0PV4F/oXm/GpeoWaSxDkmeJmFBFSY/SO5M4se8ZxEYffoZsMgTEVAh5PUyjQ7sRD4ToDLILkXkGs24WQF2pyevmbo1MIEZp3SoZlh2hD3npBIaqxrZSVAqKbmsM2s0dajCswYGXDQuSPV3n0G7YL05n1OMZUT2lTGGj4bk1 root@cclloyd.com'
	}
	
	file_line { 'keys_michael':
		path => '/home/michael/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDL/zxQTgxwLbA52KwtPmAx+VIO1DHfCQDOcjEKkQmpDIHkubZCM6sDOmWU6X5K1jFRQG/zwRuizVdbXd+KVgLwT9ooAALcQ0NP1/RiVau7vLEOH9ws5Ee1bNHO3J9Ed4BhfYXvrEyRQActXUe8SBSqpy2x0aq86bTa6jVU9AnT3IyJzPDpIPngomKHRrzqk8HnAG85DMDW0GAIm5zYDdgxpjLTm0d0V+R/cng1sqB3E1WtM3wv56IeKnb2DS7/NtcKRvAr9m1Psz8CmK4l9ZMzbKoCyzRDDhdsyGxHNhUHphSMQ61VQ0GH5C2DWyT9Mc3huHYKFPD4cFTw/87Vk/u/ Michael@Celestial Metarch'
	}
	
	file_line { 'keys_michael':
		path => '/root/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4dBOu2t5Z7TqXWVfMOHiQhCoQjH94N59dyKCre3a/9DZSQGTKz7GkyyhzNH0Dgh2qXNcM+SiF0b81xWtkRKIkGfhH93IQZViiL1F1YlqIhfxEohQDWtt88sQXpRelZp3ry8/E7VnZHXN8UIlUaQiIsHW3yLKzQtNtwT8JCrICQaTIkiJpZkeCxn9MrFQiC00di8FjLvqZBHY7OFNXIHTkCXHa2KbBweBqKdsE0RW8ch6o4qWueIDsYjU8z8/NHmna/F519IwDywkb8RNgVK5EQ3LEyGq2VDwzE+yf9tr8Xuoi/5GNpt0HEZKNLPBU4WoSWUFZAY6PHzyQU9tC02B7 Michael@Celestial Metarch',
	}
	
	file_line { 'keys_michael':
		path => '/root/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDavDFFflfBRoPK1u9ctI+6JLjBNExVdrph7Fbwpan0nVKl+Q/uMDnQ+CISYJEcn/uM1lJiTznr6WP2r1lwjuu/sj9Ux7sTJbY3nqR1z38zp91Z9UQ/gvw9WLIu1HslQ1R00BgHi3Hrvobce/LT2NLjOtydy0ThdzCx8kSmS+JFCtr1n0PV4F/oXm/GpeoWaSxDkmeJmFBFSY/SO5M4se8ZxEYffoZsMgTEVAh5PUyjQ7sRD4ToDLILkXkGs24WQF2pyevmbo1MIEZp3SoZlh2hD3npBIaqxrZSVAqKbmsM2s0dajCswYGXDQuSPV3n0G7YL05n1OMZUT2lTGGj4bk1 root@cclloyd.com'
	}
	
	file_line { 'keys_michael':
		path => '/root/.ssh/authorized_keys',
		line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDL/zxQTgxwLbA52KwtPmAx+VIO1DHfCQDOcjEKkQmpDIHkubZCM6sDOmWU6X5K1jFRQG/zwRuizVdbXd+KVgLwT9ooAALcQ0NP1/RiVau7vLEOH9ws5Ee1bNHO3J9Ed4BhfYXvrEyRQActXUe8SBSqpy2x0aq86bTa6jVU9AnT3IyJzPDpIPngomKHRrzqk8HnAG85DMDW0GAIm5zYDdgxpjLTm0d0V+R/cng1sqB3E1WtM3wv56IeKnb2DS7/NtcKRvAr9m1Psz8CmK4l9ZMzbKoCyzRDDhdsyGxHNhUHphSMQ61VQ0GH5C2DWyT9Mc3huHYKFPD4cFTw/87Vk/u/ Michael@Celestial Metarch'
	}
	
	
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
	
	
	
	######################################################
	###  SSL
	######################################################
	
	letsencrypt::certonly { $site_name: }
	letsencrypt::certonly { "stats.${site_name}":	}
	
	
	
	
	######################################################
	###  Nginx
	######################################################
	
	nginx::resource::server { $site_name:
		ensure			=>	present,
		server_name 	=>	[$site_name],
		www_root 		=>	"/var/www/${site_name}/public",
		listen_port 	=>	80,
		ssl 			=>	true,
		ssl_cert		=>	"/etc/letsencrypt/live/${site_name}/fullchain.pem",
		ssl_key			=>	"/etc/letsencrypt/live/${site_name}/privkey.pem",
		ssl_port		=>	443,
	}
	
	nginx::resource::location { "~ /.well-known":
		ensure			=>	present,
		server		 	=>	$site_name,
		#www_root 		=>	"/var/www/${site_name}/public/.well_known",
	}
	
	file {"/var/www/${site_name}/app/sprinkles.json":
		ensure		=>	'present',
		mode		=>	'775',
		content		=>	template('ufprovisioning/sprinkles.json.erb'),
	}
	
	nginx::resource::server { "bt.${site_name}":
		listen_port => 80,
		proxy       => 'http://cclloyd.com:24011',
	}
	
	
	######################################################
	###  Database (Postgre)
	######################################################
	
	$database_user 		=	"userfrosting"
	
	postgresql::server::role { 'userfrosting':
		password_hash	=> postgresql_password($database_user, 'secret'),
	}
	
	postgresql::server::db { $sprinkle_name:
		user		=> $database_user,
		password	=> postgresql_password($database_user, 'secret'),
	}
	
	postgresql::server::database_grant { 'userfrosting':
		privilege	=> 'ALL',
		db			=> $sprinkle_name,
		role		=> 'userfrosting',
	}
	
	
	
	
	
	######################################################
	###  Git
	######################################################
	
	$keys = '/home/git/.ssh/authorized_keys'

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
	
	file {"/home/git/.ssh":
		ensure		=>	'directory',
		recurse		=>	true,
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'700',
	}
	file {"/home/git/.ssh/id_rsa":
		ensure		=>	'present',
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'755',
		source 		=>	"puppet:///modules/ufprovisioning/files/git@cclloyd_rsa",
	}
	file {"/home/git/.ssh/id_rsa.pub":
		ensure		=>	'present',
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'644',
		source 		=>	"puppet:///modules/ufprovisioning/files/git@cclloyd_rsa",
	}
	file {"/home/git/.ssh/authorized_keys":
		ensure		=>	'present',
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'775',
	}
	file {"/root/.ssh/id_rsa":
		ensure		=>	'present',
		#owner		=>	'root',
		#group		=>	'root',
		mode		=>	'755',
		source 		=>	"puppet:///modules/ufprovisioning/files/root@cclloyd_rsa",
	}
	file {"/root/.ssh/id_rsa.pub":
		ensure		=>	'present',
		#owner		=>	'root',
		#group		=>	'root',
		mode		=>	'755',
		source 		=>	"puppet:///modules/ufprovisioning/files/root@cclloyd_rsa.pub",
	}
	
	#ssh::server::host_key {'puppet_rsa':
	#	private_key_source => 'puppet:///userfrosting/files/puppet_rsa',
	#	public_key_source  => 'puppet:///userfrosting/files/puppet_rsa.pub',
	#}
	
	
	concat { $keys:
		owner => 'git',
		group => 'git',
		mode  => '0775'
	}
	
	concat::fragment{ 'keys_header':
		target  => $keys,
		content => "# Authorized ssh keys\n",
		order   => '01',
	}
	
	concat::fragment{ 'mac_key':
		target  => $keys,
		source	=> "puppet:///modules/ufprovisioning/conf/cclloyd_rsa.pub",
		order   => '01',
	}
	
	git::config { 'user.name':
		value => 'git',
	}
	git::config { 'user.email':
		value => 'git@cclloyd.com',
	}
	
	
	file { [
		"/var/repo",
		#"/var/repo/${site_name}.git",
	]:
		ensure		=>	'directory',
		recurse		=>	true,
		owner		=>	'git',
		group		=>	'git',
		mode		=>	'755',
	}
	
	vcsrepo{ "/var/repo/${site_name}.git":
		ensure 		=> bare,
		provider	=>	git,
		user		=>	'git',
	}
	
	vcsrepo { "/home/git/${site_name}":
		ensure  	=> 	present,
		provider	=> 	git,
		source  	=> 	'git@bitbucket.org:cclloydcom/userfrosting.git',
		user		=>	'git',
		submodules	=>	true,
	}
	
	file {"/var/repo/${site_name}.git/hooks/post-receive":
		ensure		=>	'present',
		mode		=>	'777',
		content		=>	template('ufprovisioning/post-receive.erb'),
	}
	
	file {"/var/www/${site_name}":
		ensure		=>	'directory',
		recurse		=>	true,
		mode		=>	'777',
	}
	
	file {"/var/www/${site_name}/app":
		ensure		=>	'directory',
		recurse		=>	true,
		mode		=>	'777',
	}
	
	file {"/var/www/${site_name}/app/cache":
		ensure		=>	'directory',
		recurse		=>	true,
		mode		=>	'777',
	}
	
	
	
	######################################################
	###  Bittorrent
	######################################################	
	
	class { 'transmission':
		rpc_username 	=>	'family',
		rpc_password	=>	'family',
		rpc_port     	=>	24011,
		peer_port    	=>	54612,
		encryption   	=>	2,
	}
	
	
	
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
	
	
	
	######################################################
	###  Grafana
	######################################################

	#class { 'grafana': 
	#	cfg => {
	#		app_mode => 'production',
	#		server   => {
	#			port	=>	3000,
	#			ssl_mode 		=> require,
	#			ssl_cert			=>	"/etc/letsencrypt/live/stats.${site_name}/fullchain.pem",
	#			cert_key			=>	"/etc/letsencrypt/live/stats.${site_name}/privkey.pem",
	#		},
	#		database => {
	#			type          => 'sqlite3',
	#			host          => '127.0.0.1:3306',
	#			name          => 'grafana',
	#			user          => 'root',
	#			password      => '',
	#		},
	#		users    => {
	#			allow_sign_up => true,
	#		},
	#	},
	#}
	#
	#grafana_user { 'admin':
	#	grafana_url      => 'http://stats.cclloyd.com:3000',
	#	#grafana_api_path  => '/grafana/api',
	#	grafana_user      => 'admin',
	#	grafana_password  => 'password',
	#	full_name         => 'Admin User',
	#	password          => 'password1',
	#	email             => 'john@example.com',
	#}
	#
	#grafana_organization { 'NewOrg':
	#	grafana_url      => 'http://stats.cclloyd.com:3000',
	#	grafana_user     => 'admin',
	#	grafana_password => 'password1',
	#}
	#
	#grafana_dashboard { 'example_dashboard':
	#	grafana_url       => 'http://stats.cclloyd.com:3000',
	#	grafana_user      => 'admin',
	#	grafana_password  => 'password1',
	#	#grafana_api_path  => '/grafana/api',
	#	organization      => 'NewOrg',
	#	#content           => template('path/to/exported/file.json'),
	#}
	
	
	

	
	
	
	######################################################
	###  Testing
	######################################################
	
	
	file { "/testtemplate.conf":
		ensure => "present",
		#source  => "puppet:///modules/ufprovisioning/templates/testtemplate.epp",
		content => epp('ufprovisioning/testtemplate.epp', { 'site_name' => $site_name }),
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		require => Package['nginx']
	}
	
	

}