


alert("Configuring user 'michael'")

user { 'michael':
	ensure           => 'present',
	home             => '/home/michael',
	password         => 'slipspacetransmission',
	password_max_age => '99999',
	password_min_age => '0',
	shell            => '/bin/bash',
	#group			 => 'michael'
}

file { "/home/michael/.bashrc":
	ensure => "present",
	source  => "puppet:///modules/ufprovisioning/templates/bashrc",
	owner   => 'michael',
	group   => 'michael',
	mode    => '0755'
}

exec { "Re-source bashrc":
	command => 'source ~/.bashrc',
	user 	=> 'michael'
}

alert("Configuring Webserver")

package { 'tree':
	ensure => installed,
}	
package { 'nginx':
	ensure => installed,
}	

file { "/etc/nginx/sites-available/cclloyd.com.conf":
	ensure => "present",
	source  => "puppet:///modules/ufprovisioning/conf/cclloyd.com.conf",
	owner   => 'root',
	group   => 'root',
	mode    => '0755',
	require => Package['nginx']
}




file { '/etc/nginx/sites-enabled/cclloyd.com.conf':
	ensure => 'link',
	target => '/etc/nginx/sites-available/cclloyd.com.conf',
}
service { 'nginx':
	ensure     => running,
	enable     => true,
	hasstatus  => true,
	hasrestart => true,
	require => Package['nginx'],
}

