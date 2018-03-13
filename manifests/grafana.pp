
class ufprovisioning::grafana {

	$webserver_manage	= $::ufprovisioning::webserver_manage
	$site_name			= $::ufprovisioning::site_name
	$sprinkle_name		= $ufprovisioning::sprinkle_name

	
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
}