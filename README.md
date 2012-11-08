puppet-gdash
===================

Puppet code to install gdash (A graphite frontend by Ripienaar: https://github.com/ripienaar/gdash)

Install uses local/system ruby and gdash gem, partial support for bundler is added.

Installing Gdash
--------------------------------

```puppet
class { "::gdash" :
  graphitehost => 'graphite.example.com',
  gdashroot    => '/var/www/gdash/first',
}
```

Arguments Explained
--------------------
* graphitehost      = URL of graphite host
* gdashroot         = Where to install gdash

Optional args:
* gdash_title       = Gdash title
* overwrite_filters = If set it will be used instead of default filters provided by gdash. 

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

Installing multiple Gdashes
----------------------------
After installing gdash and setup-ing the first gdash, to install extra ones:

```puppet
gdash::setup { 'default':
    gdashroot    => 'graphite.example.com',
    graphitehost => '/var/www/gdash/second',
  }
``` 


TODO
-----------------------------
- Add suport for nginx vhost
- Finish support for bundler

Known Issues
-----------------------------
- using gdash::vhost and passenger restricts to 1 gdash per domain/subdomain and cant use subfolders with the actual vhost.erb
- Allthough modules figures like a fork from KrisBuytaert/puppet-gdash most code was written from scratch

Info
----
* Author: Martín Loy  <martin@guruhub.com.uy>
* Author: Guzmán Brasó <guzman@guruhub.com.uy>
* Homepage: http://github.com/guruHub/puppet-gdash

