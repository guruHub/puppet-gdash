class gdash::vhost($vhost = "gdash.${::fqdn}", $document_root = '/var/www/gdash/' ){

  $service = $::operatingsystem ? {
    'Debian' => 'apache2',
    'Redhat' => 'httpd',
  }

  file {
    "/etc/${service}/conf.d/gdash.conf":
      ensure  => 'file',
      group   => 'www-data',
      mode    => '0644',
      owner   => 'www-data',
      content => template('gdash/apache.vhost.conf.erb'),
      notify => Service["${service}"];
  }
}
