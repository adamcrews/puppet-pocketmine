class pocketmine::package (
 $version = $pocketmine::params::version
) inherits pocketmine::params {

  staging::file { "pocketmine-${version}.sh":
    source => "http://sourceforge.net/projects/pocketmine/files/linux/PocketMine-MP_Installer_${version}.sh" 

  exec { "/opt/staging/pocketmine-${version}.sh":
    require     => Staging::File["pocketmine-${version}.sh"],
    refreshonly => true,
  }
}
