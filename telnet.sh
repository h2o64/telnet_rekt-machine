#!/usr/bin/expect

# Parameters :
# $1 = interface (wlan/eth/status)
# $2 = state (on/off)
#

set interface [lindex $argv 0];
set state [lindex $argv 1];

set timeout 60; # Timeout will happen after 60 seconds.

# Login
spawn telnet 192.168.1.254;
expect "Username :";
send "Administrator\r";
expect "Password :";
send "\r";
puts "\r";

# Modify configuration
if {[regexp -nocase "wlan" $interface]} {
	if {[regexp -nocase "on" $state]} {
		# Enable Wi-Fi
		expect "{Administrator}=>";
		send "wireless macacl modify ssid_id=0 radio_id=0 hwaddr=02:0f:b5:00:d4:86 permission=allow name=JULIEN-WLAN\r"; # JULIEN-WLAN1
		expect "{Administrator}=>";
		send "wireless macacl modify ssid_id=0 radio_id=0 hwaddr=02:0f:b5:aa:13:b7 permission=allow name=JULIEN-WLAN2\r"; # JULIEN-WLAN2
		expect "{Administrator}=>";
		send "wireless macacl modify ssid_id=0 radio_id=0 hwaddr=80:22:75:aa:13:b7 permission=allow name=JULIEN-WLAN3\r"; # JULIEN-WLAN3
		expect "{Administrator}=>";
		send "saveall\r";
		puts "\r";
	} elseif {[regexp -nocase "off" $state]} {
		# Disable Wi-Fi
		expect "{Administrator}=>"
		send "wireless macacl modify ssid_id=0 radio_id=0 hwaddr=02:0f:b5:00:d4:86 permission=deny name=JULIEN-WLAN\r"; # JULIEN-WLAN1
		expect "{Administrator}=>";
		send "wireless macacl modify ssid_id=0 radio_id=0 hwaddr=02:0f:b5:aa:13:b7 permission=deny name=JULIEN-WLAN2\r"; # JULIEN-WLAN2
		expect "{Administrator}=>";
		send "wireless macacl modify ssid_id=0 radio_id=0 hwaddr=80:22:75:aa:13:b7 permission=deny name=JULIEN-WLAN3\r"; # JULIEN-WLAN3
		expect "{Administrator}=>";
		send "saveall\r";
		puts "\r";
	} else {
    		puts "exit\r";
	}
} elseif {[regexp -nocase "eth" $interface]} {
	# TODO:
	# - figure out the ethernet type because I bet it's breaking a lot of stuff
	# - let the user specify its lovely port
	if {[regexp -nocase "on" $state]} {
		# Enable Ethernet
		#expect "{Administrator}=>";
		#send "eth device ifconfig intf=ethif1 state=enabled type=auto mtu=1526\r"; # Port 1
		expect "{Administrator}=>";
		send "eth device ifconfig intf=ethif2 state=enabled type=auto mtu=1526\r"; # Port 2
		expect "{Administrator}=>";
		send "eth device ifconfig intf=ethif3 state=enabled type=auto mtu=1526\r"; # Port 3
		expect "{Administrator}=>";
		send "eth device ifconfig intf=ethif4 state=enabled type=auto mtu=1526\r"; # Port 4
		expect "{Administrator}=>";
		send "saveall\r";
		puts "\r";
	} elseif {[regexp -nocase "off" $state]} {
		# Disable Ethernet
		#expect "{Administrator}=>";
		#send "eth device ifconfig intf=ethif1 state=disabled type=auto mtu=1526\r"; # Port 1
		expect "{Administrator}=>";
		send "eth device ifconfig intf=ethif2 state=disabled type=auto mtu=1526\r"; # Port 2
		expect "{Administrator}=>";
		send "eth device ifconfig intf=ethif3 state=disabled type=auto mtu=1526\r"; # Port 3
		expect "{Administrator}=>";
		send "eth device ifconfig intf=ethif4 state=disabled type=auto mtu=1526\r"; # Port 4
		expect "{Administrator}=>";
		send "saveall\r";
		puts "\r";
	} else {
    		puts "exit\r";
	}
} elseif {[regexp -nocase "status" $interface]} {
	send "wireless macacl list\r";
	send "eth device iflist\r";
	puts "\r";
} else {
    puts "# Mauvaise interface pas de solutions.\r";
    puts "exit\r";
}
