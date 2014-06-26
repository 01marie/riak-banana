class riak::install inherits riak {
	if $stage_package {
	  exec { 'riak download':
        command => "wget -O ${package_real_source} ${package_url}",
        creates => "${package_real_source}",
        path => ['/usr/local/bin','/usr/bin', '/bin','/usr/local/sbin','/usr/sbin','/sbin'],
        before => Package['riak'],
				timeout => 0, #for pigeon carrier interwebs
  	  }
	}
	package {'libssl0.9.8':
		ensure => installed
	} ~>
	package {'riak':
		ensure => $package_ensure,
		name => $package_name,
		source => $package_real_source,
		provider => $package_real_provider,
	}
	# ~>

	#exec { "fix beta7":
	#	command => "patch -p0 < /vagrant/files/b7-patch && touch /tmp/b7-patched",
	#	creates => "/tmp/b7-patched",
	#	path => ['/usr/local/bin','/usr/bin', '/bin','/usr/local/sbin','/usr/sbin','/sbin'],
	#	after => Package['riak']
	#}
}
