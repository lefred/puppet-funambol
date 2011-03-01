# Class: funambol::oxmodule
#
# This module manages funambol ox listener
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
class funambol::oxmodule {
    package { "funambol-ox-module":
        ensure => "installed"
    }
    
    file { "/opt/Funambol/config/com/funambol/oxlistener/task/OXListenerTask.xml":
        ensure  => present,
        source  => [
            "puppet:///funambol/${hostname}/OXListernerTask.xml",
            "puppet:///funambol/default/OXListernerTask.xml",
            ],
        require => Package["funambol-ox-module"];
    }
    
    file { "/opt/Funambol/config/Funambol.xml":
        ensure  => present,
        source  => [
            "puppet:///funambol/${hostname}/Funambol.xml",
            "puppet:///funambol/default/Funambol.xml",
            ],
        require => Package["funambol-ox-module"];
    }

    service { "ox-listener":
        enable     => false,
        hasrestart => true,
        hasstatus  => true,
        require => Package["funambol-ox-module"]
    }

}
