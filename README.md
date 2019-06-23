[![Waffle.io - Columns and their card count](https://badge.waffle.io/boveus/wifinder.svg?columns=all)](https://waffle.io/boveus/wifinder)

# About #
This is a project to use Wireshark to capture packets and view some analysis about them.  This is the API for the project written in Rails.  I have an earlier iteration of this project [here](https://github.com/boveus/wifinder) which I am porting over to use Rails.  I would like to use a modern frontend technology and it will be easier to do that with an API-based backend rather than the vanilla ruby one I was using before.

The current capabilities of this app include the following:
  - Ingest data and add it to a SQL database on the fly using a rake task that runs [tshark](https://www.wireshark.org/docs/man-pages/tshark.html)

  ![image](https://user-images.githubusercontent.com/20469703/46448430-cb7dce00-c754-11e8-983d-de3de2f9e187.png)

The SSID and Devices views refer one another, so you can view details about the SSIDs associated with a particular device and vice versa.

For the time being this is intended to passively monitor traffic rather than use packet injection to generate additional traffic.  I am also challenging myself to limit the number of dependencies as much as possible.

## Pre-requistite Hardware ##
- A network interface [card](https://www.acrylicwifi.com/en/support-webinars-wifi-wireless-network-software-tools/compatible-hardware/) capable of [monitor mode](https://en.wikipedia.org/wiki/Monitor_mode)

## Pre-requistite Software ##
- Some version of linux/unix. (Monitoring mode for WiFi NICs is not well supported in OSX/Windows)
- I tested this in Ubuntu 16.04
- Wireshark (Available at https://www.wireshark.org/)

# Getting Started #
Identify the wireless interface you want to set to monitor mode using `ip a` or `ifconfig`.
Set the device to monitor mode using the following commands
```bash
`sudo ip link set <interface> down`
`sudo iwconfig <interface> mode monitor`
`sudo ip link set <interface> up`
```
`ifconfig` is a deprecated tool, but it is still available in some linux distros and does the same thing:
```bash
sudo ifconfig <interface> down
sudo iwconfig <interface> mode monitor
sudo ifconfig <interface> up
```
Alternatively, there is a rake task built into the project to do so
```bash
interface=wlan1 rake set_to_monitor
```
## Start capturing
To display only probe requests, use the following wireshark display filter:
```
wlan.fc.type_subtype == 0x08
```
To capture only probe requests, you can use the following capture filter:
```
subtype probereq
```
![wireshark](https://user-images.githubusercontent.com/20469703/43873015-c7a73290-9b52-11e8-85b9-31683bdd22e2.png)

Start capturing on the device (above) that you had set to monitor mode.  Run it for as long as you want, but I recommend 3-6 hours or so at a minimum to get a large amount of data.

## Custom Rake Tasks ##

The current rake tasks for the application are the following:

```shell
rake capture         # start capturing packets (device must be in monitor mode)
rake set_interface   # Configure the interface to be used by the other tasks | usage rake set interface interface=<interface>
rake set_to_monitor  # Usage: interface=wlan1 rake set_to_monitor | set the device to monitor mode
```
