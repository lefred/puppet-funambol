# Class: funambol
#
# This module manages funambol
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class funambol {
    package { "funambol":
        ensure => "installed"
    }

    service { "funambol":
        enable     => false,
        hasrestart => true,
        hasstatus  => true,
        require => Package["funambol"]
    }

    file { "/opt/Funambol/ds-server/install.properties":
        ensure  => present,
        mode    => 0754,
        owner   => "root",
        group   => "root",
        source  => [
                    "puppet:///modules/funambol/$hostname/install.properties",
                    "puppet:///modules/funambol/default/install.properties",
                   ],
        require => Package["funambol"];
    }

    package { "mysql-connector-java":
        ensure => "installed"
    }

    define grant( $user, $password, $db, $host, $permission ) {

        exec { "add-${name}":
            unless => "/usr/bin/mysql -u${user} -p${password}",
            command => "/usr/bin/mysql -uroot -e \"grant ${permission} on ${db}.* to ${user}@'$host' identified by '$password';\"",
            require => Service["mysqld"],
        }
    }

    grant {
        "funambol":
            user => "funambol",
            password => "funambol",
            host => "%",
            db => "funambol",
            permission => "all",
    }

}
