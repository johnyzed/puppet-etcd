This puppet module will install and configure etcd on stand-alone or a cluster environment.
It will dowload and install the last stable version of etcd disponible on the [github etcd repo of coreos](https://github.com/coreos/etcd). 

##Require
In order to run, this module needs the following puppet modules:
* [stdlib](https://github.com/puppetlabs/puppetlabs-stdlib)
* [git](https://github.com/puppetlabs/puppetlabs-git)
* [golang](https://github.com/johnyzed/puppet-golang)

##How to use
###Stand alone

```
    class { 'golang':}
    class { 'git':}

    stage { 'last':
        require => Stage['main'],
    }

    class { 'etcd':
        stage => last,
        machine_name  => "machine1",
        peer_port => "7001",
	etcd_version => "0.3.0",
        regular_port => "4001",
    }
```

###Cluster

```
    class { 'golang':}
    class { 'git':}

    stage { 'last':
        require => Stage['main'],
    }

    class { 'etcd':
        stage => last,
        machine_name  => "machine1",
        peer_port => "7001",
        regular_port => "4001",
	etcd_version => "0.3.0",
        peers => [ "server2:7002,server3:7003"],
    }
```

