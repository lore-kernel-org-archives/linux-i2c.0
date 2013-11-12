From: DATACOM - Thomas Ruschival <thomas.ruschival-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
Subject: sysfs: how to create named symlinks in /sys/bus/i2c/devices/
Date: Tue, 12 Nov 2013 17:07:49 -0200
Message-ID: <52827C85.3010409@datacom.ind.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

If this is not the correct mailing list for this sysfs-related question 
please indicate.

I am developing a i2c-driver which is not functionally associated with 
any class (rtc,  gpio etc.) that has some basic attributes for 
user-space applications.
The chip-address comes form a DTS (I am developing for a powerpc 
embedded system) since different boards have the device at different 
addresses.
Everything works fine, devices are correctly probed and instantiated as 
for instance: /sys/devices/e0000000.soc8548/e0003100.i2c/i2c-1/1-006e
and a symlink is created at: /sys/bus/i2c/devices/1-006e

Unfortunately since the address may not always be the same user-space 
applications can't rely on this symlink - I don't have udev.

I would like to have a symlink /sys/bus/i2c/ucd9081 - instead of the 
address /sys/bus/i2c/devices/1-006e; like the the symlinks in 
/sys/class/rtc.
I2C-dev driver does not offer an interface for registering 
device-clients, only adapters.

Using a struct miscdevice and miscdevice_register seems somewhat 
overkill just to get links in /sys/class/misc/ and also doesn't work 
since the struct device* passed to sysfs attributes will resolve in the 
miscdevice and not the i2c_client.

What is the correct way to get symlinks to devices?

Thanks in advance
Thomas
