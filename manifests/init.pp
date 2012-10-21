# Class: gdash
#
# This module manages gdash 
#
# Gdash will be installed through rubygems 
#
# Parameters:
# 
# vhost: apache/nginx vhostname, usefull to have multiple gdash installs
# gdashroot: install path
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class gdash (
  $gdashroot = "/var/www/gdash/",
  $graphitehost='127.0.0.1',
)
{

  package {
			'rubygems':
        ensure => 'installed'
  } -> package {
      'gdash': 
        ensure => present,
        provider => gem,
  }

  define setup($gashroot, $graphitehost){

    file {
      "${gdashroot}":
        ensure  => directory,
        group   => 'www-data',
        owner   => 'www-data',
        require => Package['gdash'],
    }

    file {
      "${gdashroot}/config":
        ensure  => directory,
        group   => 'www-data',
        owner   => 'www-data',
        require => Package['gdash'],
    }
     
    file {
      "${gdashroot}/config/gdash.yaml":
        content => template('gdash/gdash.yaml.erb'),
        group   => 'www-data',
        owner   => 'www-data',
        require => File["${gdashroot}/config"]
    }

    # to enable bundling in the future
    file {
      "${gdashroot}/Gemfile":
        soure   => 'puppet:///modules/gdash/Gemfile', 
        group   => 'www-data',
        owner   => 'www-data',
        require => File["${gdashroot}/config"]
    }

    file {
      "${gdashroot}/config/config.ru":
        soure   => 'puppet:///modules/gdash/config.ru', 
        group   => 'www-data',
        owner   => 'www-data',
        require => File["${gdashroot}/config"]
    }

    file {
      "${gdashroot}/config/dashboards":
        ensure  => present,
        group   => 'www-data',
        owner   => 'www-data',
        require => File["${gdashroot}/config"]
    }

  }

  gdash::setup { 'default':
    gdashroot    => $gdashroot,
    graphitehost => $graphitehost
  }

}

