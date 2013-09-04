From: Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: RFC - EEPROM device class
Date: Wed, 4 Sep 2013 10:34:06 -0700
Message-ID: <20130904173406.GA11050@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shrijeet Mukherjee <shm-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>, Dustin Byford <dustin-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

I want to float the idea of having an EEPROM 'class' in
sysfs, similar to what the hwmon devices do.  I have prototyped the
class using the at24 driver and would like to reach out for more
feedback.

The Problem:  We work on several different switching platforms, each
of which has about 64 EEPROMs, one for each of the 10G SFP+ modules.
In addition the systems typically have a board info EEPROM, SPD and
power supply EEPROMs.  It is difficult to map the device tree entries
for the EEPROMs to the appropriate sysfs device needed for I/O in a
generic way.

Also mappings are further complicated by some systems using custom
i2c buses implemented in FPGAs.

The idea is two fold:

1. Create an EEPROM class for all EEPROM devices.  Each EEPROM driver,
at24 for example, would register with the class during probe().

2. Create a mapping in the .dts file by adding a property called
'label' to each EEPROM entry.  The EEPROM class will expose this label
property for all EEPROMs.

For example, for all the EEPROM devices in the system you would see
directories in sysfs like:

  /sys/class/eeprom_dev/eeprom0
  /sys/class/eeprom_dev/eeprom1
  /sys/class/eeprom_dev/eeprom2
  ...
  /sys/class/eeprom_dev/eeprom<N>

Within each eepromN directory you would find:

  root@switch:/sys/class/eeprom_dev# ls -l eeprom2/
  total 0
  lrwxrwxrwx 1 root root    0 Sep  3 22:08 device -> ../../../1-0050
  -r--r--r-- 1 root root 4096 Sep  3 22:08 label
  lrwxrwxrwx 1 root root    0 Sep  4 17:18 subsystem ->
  ../../../../../../../class/eeprom_dev

device -- this is a symlink to the physical device.  For example to
dump the EEPROM data of eeprom2 you could do:

  hexdump -C /sys/class/eeprom_dev/eeprom2/device/eeprom

As an example the device tree entry corresponding to eeprom2 could
look like:

	sfp_eeprom@50 {
		compatible = "at,24c04";
		reg = <0x50>;
		label = "port6";
	};

Imagine 64 similar entries for all the other ports.  Plus a few more
entries for board EEPROM and power supply EEPROMs.

>From user space if I wanted to know the device corresponding to port6
I could do something as simple as:

root@switch:~# grep port6 /sys/class/eeprom_dev/eeprom*/label
/sys/class/eeprom_dev/eeprom2/label:port6

Then I could access the information via
/sys/class/eeprom_dev/eeprom2/device/eeprom.

It is nice that it keeps the mapping all in one place, in the .dts
file.  It is not spread around in the device tree and some other
platform specific configuration file.

Note: For devices without a 'label' property the label file is still
created, however, its contents would be set to 'unknown'.

Note2: The class cannot be called 'eeprom' as that is the name of the
I/O file created by the driver.  The class name appears as a
sub-directory within the main device directory.  Hence the class name
'eeprom_dev'.  The class name is open to discussion.  You could also
imagine eeprom_device and eeprom-dev as other choices.

Thoughts, comments and feedback appreciated.

Cheers,
Curt
