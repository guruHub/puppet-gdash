class gdash::vhost(
	$vhost = "gdash.${::fqdn}", 
	$document_root = '/var/www/gdash/',
	$redirect_home_to = false
){

  $service = $::operatingsystem ? {
    'Debian' => 'apache2',
    'Redhat' => 'httpd',
  }

  if $redirect_home_to {
	exec { "${vhost}-check-modrewrite-enable" :
		path => '/usr/bin/:/bin:/usr/sbin',
		command => 'a2enmod rewrite >> /dev/null && /etc/init.d/apache2 reload',
		unless  => 'test -L /etc/apache2/mods-enabled/rewrite.load',
		before  => File["/etc/${service}/conf.d/${vhost}.conf"]
	}	
  }

  file {
    "/etc/${service}/conf.d/${vhost}.conf":
      ensure  => 'file',
      group   => 'www-data',
      mode    => '0644',
      owner   => 'www-data',
      content => template('gdash/apache.vhost.conf.erb'),
      notify => Service["${service}"];
  }
}
