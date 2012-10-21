class gdash::vhost {

  $service = $::operatingsystem ? {
    'Debian' => 'apache2',
    'Redhat' => 'httpd',
  }

  file {
    "/etc/${service}/conf.d/gdash.conf":
      ensure  => 'file',
      group   => '0',
      mode    => '0644',
      owner   => '0',
      source => 'puppet:///modules/gdash/gdash.conf',
      notify => Service["${service}"];
  }
}
