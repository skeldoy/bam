class bam {

$createModules = $::bamList

each ($createModules) |$metamodule| { 
$description = "Please write a description"
$params = ""
file { "/usr/local/etc/puppet/modules/$metamodule":
    ensure => "directory",
}
->
file { "/usr/local/etc/puppet/modules/$metamodule/manifests":
    ensure => "directory",
}
->
file { "/usr/local/etc/puppet/modules/$metamodule/manifests/init.pp":
	owner => root,
	group => wheel,
	mode => 444,
	content => "
class $metamodule (
\$${metamodule}_name = ${metamodule}::params::${metamodule}_name,
\$${metamodule}_description = ${metamodule}::params::${metamodule}_description,
\$${metamodule}_parameters = ${metamodule}::params::${metamodule}_parameters,
) inherits ${metamodule}::params {
anchor {'${metamodule}::begin': } ->
class {'${metamodule}::install': } ->
class {'${metamodule}::config': } ~>
class {'${metamodule}::service': } ->
anchor { '${metamodule}::end': }
}
",
}
->
file { "/usr/local/etc/puppet/modules/$metamodule/manifests/params.pp":
        owner => root,
        group => wheel,
        mode => 444,
        content => " 
class ${metamodule}::params {
\$${metamodule}_name = \"${metamodule}\" 
\$${metamodule}_description = \"${description}\" 
\$${metamodule}_parameters = \"${params}\"
}
",
} # end of file
->
file { "/usr/local/etc/puppet/modules/$metamodule/manifests/config.pp":
        owner => root,
        group => wheel,
        mode => 444,
        content => "
class ${metamodule}::config inherits ${metamodule} {
# Now we configure ${metamodule}
file { \"/usr/local/etc/${metamodule}\":
 ensure => directory,
}->
file { \"/usr/local/etc/${metamodule}/${metamodule}.conf\":
 owner => root,
 group => wheel,
 mode => 444,
 source => \"puppet:///modules/${metamodule}/${metamodule}.conf\",
 }
}
",
} # end of file
->
file { "/usr/local/etc/puppet/modules/$metamodule/manifests/install.pp":
        owner => root,
        group => wheel,
        mode => 444,
        content => "
class ${metamodule}::install inherits ${metamodule} {
# Now we install stuff
include pkgng
package { \"${metamodule}\":
 ensure => installed,
 }


}
",
} # end of file
->
file { "/usr/local/etc/puppet/modules/$metamodule/manifests/service.pp":
        owner => root,
        group => wheel,
        mode => 444,
        content => "
class ${metamodule}::service inherits ${metamodule} {
# conf up the rc-script and start the process
service { \"${metamodule}\":
 ensure => running,
 enable => true
}

}
",
} # end of file

}
#end of each


#end of class 
}
