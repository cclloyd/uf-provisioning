
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