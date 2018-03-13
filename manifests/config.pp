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
			email		=>	'cclloyd9786@gmail.com',
			server 		=>	'https://acme-staging.api.letsencrypt.org/directory',
		}
	}
	#class { 'apt':
	#	update => {
	#		frequency => 'daily',
	#	},
	#}
	
	include git
	
	package { 'glances':
		ensure	=>	latest,
	}
	

	
	
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