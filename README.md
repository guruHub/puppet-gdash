puppet-gdash
===================

Puppet code to install gdash (A graphite frontend by Ripienaar: https://github.com/ripienaar/gdash)

Install uses local/system ruby and gdash gem, partial support for bundler is added.

Installing Gdash
--------------------------------

```puppet
class { "::gdash" :
  graphitehost => $graphitehost,
  gdashroot    => $gdashroot,
  gdash_title  => $gdash_title,
  overwrite_filters => $overwrite_filters,
}
```


Using it with Apache
-------------------

Using the above installed gdash with Apache

```puppet
package{ 'libapache2-mod-passenger':
      ensure  => present,
      require => Class['::gdash'],
}

class { '::gdash::vhost' :  
  vhost            => $vhost,
  document_root    => $gdashroot,
  redirect_home_to => $redirect_home_to,
  require          => Package['libapache2-mod-passenger']
}						
```

TODO
-----------------------------
- Add suport for nginx vhost
- Finish support for bundler

Known Issues
-----------------------------
- using gdash::vhost and passenger restricts to 1 gdash per domain/subdomain and cant use subfolders


