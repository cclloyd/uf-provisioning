 

Optional[String] $sitename


package { 'tree':
	ensure => installed,
}	
package { 'nginx':
	ensure => installed,
}	

service { 'nginx':
	ensure     => stopped,
	require => Package['nginx'],
}


#file { "/etc/nginx/sites-available/cclloyd.com.conf":
#	ensure => "present",
#	source  => "puppet:///modules/ufprovisioning/conf/cclloyd.com.conf",
#	owner   => 'root',
#	group   => 'root',
#	mode    => '0755',
#	require => Package['nginx']
#}

file { "/etc/nginx/sites-available/testtemplate.conf":
	ensure => "present",
	source  => "puppet:///modules/ufprovisioning/conf/testtemplate.conf",
	content => epp('site_name', $sitename)
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