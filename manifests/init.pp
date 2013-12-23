class pocketmine (
  $user        = $pocketmine::params::user,
  $version     = $pocketmine::params::version,
  $pre_reqs    = $pocketmine::params::pre_reqs,
  $install_dir = $pocketmine::params::install_dir,
) inherits pocketmine::params { 

  user { $user:
    ensure     => present,
    home       => $install_dir,
    managehome => true,
  }

  file { $install_dir:
    ensure => directory,
    owner  => $user,
  }

  include pocketmine::package
  
}
