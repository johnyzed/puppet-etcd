This puppet module will install and configure etcd on stand-alone or a cluster environment.
It will dowload and install the version of etcd you'll wish  from the available ones at the [etcd github page](https://github.com/coreos/etcd/releases) (by default, it will install the version 0.3.0).

##Require
In order to run, this module needs the following puppet module:
* [stdlib](https://github.com/puppetlabs/puppetlabs-stdlib)

##How to use
###Stand alone

```
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

    class { 'etcd':
        stage => last,
        machine_name  => "machine1",
        peer_port => "7001",
        regular_port => "4001",
    	etcd_version => "0.3.0",
        peers => [ "server2:7002,server3:7003"],
    }
```

