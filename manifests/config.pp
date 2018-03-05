# == Class: ufprovisioning::config
class ufprovisioning::config {

	#file { '/etc/ntp.conf':
	#	ensure  => file,
	#	owner   => 'root',
	#	group   => 'root',
	#	mode    => 0644,
	#	content => template($module_name/ntp.conf.erb),
	#}
	
	file { "/etc/nginx/sites-available/cclloyd.com.conf":
		ensure => "present",
		source  => "puppet:///modules/ufprovisioning/conf/cclloyd.com.conf",
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		require => Package['nginx']
	}
	
	
	
	file { "/etc/nginx/sites-available/testtemplate.conf":
		ensure => "present",
		#source  => "puppet:///modules/ufprovisioning/templates/testtemplate.epp",
		content => template('ufprovisioning/testtemplate.erb', {'site_name' => "testsite" }),
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		require => Package['nginx']
	}
	
	
	

	file { '/etc/nginx/sites-enabled/cclloyd.com.conf':
		ensure => 'link',
		target => '/etc/nginx/sites-available/cclloyd.com.conf',
	}

}