class netapp::timeoutfix {

    file {
        "99-netapp-scsi.rules":
            mode => 644, owner => root, group => root,
            path => $operatingsystem ? {
                RedHat => $operatingsystemrelease ? {
			4 => "/etc/udev/rules.d/99-netapp-scsi.rules",
			default => "",
#		default => "",
		},
            },
            source => $operatingsystem ? {
                RedHat => $operatingsystemrelease ? {
                        4 => "puppet:///modules/netapp/99-netapp-scsi.rules",
                        default => "",
#                default => "",
                },
            },
    }
	    
   case $operatingsystem {
        RedHat: {
                case $operatingsystemrelease {
                        4: {  exec {
     				"start_udev":
			            command     => "/sbin/start_udev",
			            subscribe   => File['99-netapp-scsi.rules'],
			            refreshonly => true
              		      } 
			}
                }
        }
    }
}
