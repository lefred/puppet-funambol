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
}
