# About #
This is a project to use [tshark](https://www.wireshark.org/docs/man-pages/tshark.html) to capture packets and produce API endpoints that are meant to be consumed by a front end technology of some kind with the goal of visualizing the packet data for analysis.  I have an earlier iteration of this project [here](https://github.com/boveus/wifinder) which I am porting over to use Rails.  I would like to use a modern frontend technology and it will be easier to do that with an API-based backend rather than the vanilla ruby one I was using before.

For the time being this is intended to passively monitor traffic rather than use packet injection to generate additional traffic.

# Project Highlights #

## Models
* Packet - The packet (and associated metadata) that was captured
* Device - A unique device which is created from a MAC address from the packet source
  * Has a many to many relationship with SSIDs
* Ssid - A unique SSID that was seen in the 'info' field of the packet
  * Has a many to many relationship with devices
* Activetime - Hours that a device has been seen.
  * Has a many to many relationship with devices
* Person - A way of correlating multiple devices that seem to share mac addresses
  * A string representing devices and ssids that might be associated with an individual person

## API endpoints:
* /api/v1/administration/set_capture_device/:device_id
  * sets the capture interface to the specified device id
* /api/v1/administration/capture_device
  * returns the currently configured capturing interface
* /api/v1/administration/start_capture
  * This will initiate the packet capture using tshark
* /api/v1/administration/check_status/(:interval)
  * This endpoint checks if a packet has been collected in the past 60 seconds or the interval specified in the request (in seconds)
  * If a packet has been added to the database within the interval, it will return a 200 response, otherwise it will return a 204
  * This is meant to be polled to detect collection problems
* /api/v1/devices
  * Index for all devices
* /api/v1/devices/:id
  * Show for a device
* /api/v1/devices/:id/ssids
  * returns all of the ssids for a devices
* /api/v1/devices/:id/activetimes
  * returns an array containing timestamps rounded to the nearest hour of times a device was active
* /api/v1/ssids
  * Index for all SSIDs
* /api/v1/ssids/:id
  * Show for an SSID

## Custom Rake Tasks
* [set_interface.rake](https://github.com/boveus/wifinder-api/blob/master/lib/tasks/set_interface.rake)
  * Sets the interface to be used in the other two tasks in `config/config.yml`
* [set_to_monitor.rake](https://github.com/boveus/wifinder-api/blob/master/lib/tasks/set_to_monitor.rake)
  * Sets a device to monitor mode if specified in the config file of the interface=<interface> argument
* [capture.rake](https://github.com/boveus/wifinder-api/blob/master/lib/tasks/capture.rake)
  * Ingests data and adds it to the SQL database on the fly using a rake task that runs [tshark](https://www.wireshark.org/docs/man-pages/tshark.html)

# Getting Started #

## Pre-requistite Hardware ##
- A network interface [card](https://www.acrylicwifi.com/en/support-webinars-wifi-wireless-network-software-tools/compatible-hardware/) capable of [monitor mode](https://en.wikipedia.org/wiki/Monitor_mode)

# Production / Rasberry Pi

See the [wiki article](https://github.com/boveus/wifinder-api/wiki/Configuring-the-Wifinder-API-on-a-Raspberry-Pi)

# Development 

## Pre-requistite Software ##
- Some version of linux/unix. (Monitoring mode for WiFi NICs is not well supported in OSX/Windows)
- I tested this in Ubuntu 16.04
- [Rails](http://installrails.com/)
- [Wireshark](https://www.wireshark.org/)

## Clone the project and install the ruby dependencies
```bash
git clone git@github.com:boveus/wifinder-api.git
cd wifinder-api
bundle install
```

## Manually set device to monitor mode
Identify the wireless interface you want to set to monitor mode using `ip a` or `ifconfig`.
Set the device to monitor mode using the following commands
```bash
sudo ip link set <interface> down
sudo iwconfig <interface> mode monitor
sudo ip link set <interface> up
```
`ifconfig` is a deprecated tool, but it is still available in some linux distros and does the same thing:
```bash
sudo ifconfig <interface> down
sudo iwconfig <interface> mode monitor
sudo ifconfig <interface> up
```

## Use a rake task to set the device to monitor mode
Alternatively, there is a rake task built into the project to do so
```bash
rake set_interface interface=<interface id>
rake set_to_monitor
```
Note: you will only need to run the `set_interface` command once - this will save the device ID to a config file.

## Set up database
You will need to create a new database for the capture command to write data to.  You should only need to run this command on the initial setup. I recommend backing up the database before running these commands if you aren't familiar with Rails.  For more details on what these commands do, see [this article](https://dev.to/neshaz/how-to-use-rake-db-commands-in-the-correct-way--50o2) 
To set up your database before collecting, you will need to run the following commands in the root project directory:
```bash
bundle exec rake db:create db:migrate 
```
or
```bash
# WARNING: this command will drop your existing database (if there is one) and you may lose any packets you have collected.
bundle exec rake db:setup
```

## Start capturing
```bash
rake capture
# Optionally, enable verbose mode to see the console output as tshark collects packets
rake capture verbosity=true
```
