class etcd(
	$install_path = "/opt/project",
	$github_url = "https://github.com/coreos/etcd",
	$profiledir = "/etc/profile.d",
	$machine_name,
	$peer_port,
	$regular_port,
	$peers="",
){
	
	if !is_array($peers){
		$need_peers = false
	}else {
		$need_peers = true
	}

	file { $install_path:
		ensure => "directory",
	}

	exec { "etcd_git_clone":
		command => "git clone ${github_url}",
		path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
		cwd     => $install_path,
		require => File[$install_path],
		creates => "${install_path}/etcd/.git"
	}

    exec { "export_path_profile":
    	command => "echo 'export PATH=\$PATH:/usr/local/go/bin' >> ${profiledir}/.profile ; echo 'export GOROOT=/usr/local/go'",
    	path   => [ '/usr/bin', '/bin' ],
    	#unless => "grep '/usr/local/go/bin' ${profiledir}/.profile"
    }

    #package { "golang-go":
    #	ensure => installed,
    #}

	exec { "etcd_build":
		command => "${install_path}/etcd/build",
		cwd     => "${install_path}/etcd",
		path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/usr/local/go/bin:/usr/local/go/bin",
		require => [Exec["etcd_git_clone"],Exec['export_path_profile']],
		onlyif  => "test -f ${install_path}/etcd/build", 
	}

	exec { "config_etcd":
		command => $need_peers ?{
			false => "nohup ${install_path}/etcd/bin/etcd -peer-addr ${hostname}:${peer_port} -addr ${hostname}:${regular_port} -data-dir machines/${machine_name} -name ${machine_name} -bind-addr 0.0.0.0 &",
			true  => "nohup ${install_path}/etcd/bin/etcd -peer-addr ${hostname}:${peer_port} -addr ${hostname}:${regular_port} -peers ${peers} -data-dir machines/${machine_name} -name ${machine_name} -bind-addr 0.0.0.0 &",
		},
		cwd     => "${install_path}/etcd",
		path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/usr/local/go/bin:/usr/local/go/bin",
		require => Exec['etcd_build'],
	}

}