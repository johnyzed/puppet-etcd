This puppet module will install and configure etcd on stand-alone or a cluster environment.
It will dowload and install the version of etcd you'll wish  from the available ones at the [etcd github page](https://github.com/coreos/etcd/releases) (by default, it will install the version 0.3.0).

##Require
In order to run, this module needs the following puppet module:
* [stdlib](https://github.com/puppetlabs/puppetlabs-stdlib)

##How to use
###Stand alone

```
    class { 'etcd':
        machine_name  => "machine1",
        peer_port => "7001",
    	etcd_version => "0.3.0",
        regular_port => "4001",
    }
```

###Cluster
If you decide to work on cluster you need to take the order of the installation in account.Let's say you want to create a cluster of 3 servers as in the example below.The installation order will be server1, then server2, then server3.In order to work you will have to install server1 as stand alone (exactly like ion the example above) and then server2 and server3 like below.

```

    class { 'etcd':
        machine_name  => "machine1",
        peer_port => "7001",
        regular_port => "4001",
    	etcd_version => "0.3.0",
        peers => [ "server2:7002,server3:7003"],
    }
```

