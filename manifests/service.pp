# == Class: ufprovisioning::service
class ufprovisioning::service inherits ufprovisioning {

  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require => Package['nginx'],
  }

}