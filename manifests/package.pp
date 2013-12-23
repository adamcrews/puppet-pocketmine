class pocketmine::package {

  $pre_reqs    = $pocketmine::pre_reqs
  $version     = $pocketmine::version
  $user        = $pocketmine::user
  $install_dir = $pocketmine::install_dir

  package { $pre_reqs:
    ensure => installed,
  }

  staging::file { "pocketmine-${version}.sh":
    source => "http://sourceforge.net/projects/pocketmine/files/linux/PocketMine-MP_Installer_${version}.sh",
  }

  file { '/vagrant/.ccache':
    ensure  => directory,
    owner   => $user,
    recurse => true,
    before  => Exec['install pocketmine'],
  }

  notify { "Warning: This next step can take several minutes.  Do not worry":
    before => Exec['install pocketmine'],
  }


  exec { "install pocketmine":
    command     => "/bin/bash /opt/staging/pocketmine/pocketmine-${version}.sh",
    path        => '/usr/lib/ccache:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    cwd         => $install_dir,
    require     => [ Package[$pre_reqs], File[$install_dir] ],
    subscribe   => Staging::File["pocketmine-${version}.sh"],
    refreshonly => true,
    logoutput   => true,
    user        => $user,
    timeout     => 1500,
    environment => [ 'CCACHE_COMPRESS=true', 'CCACHE_DIR=/vagrant/.ccache' ],
  }
}
