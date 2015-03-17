From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe-Mmb7MZpHnFY@public.gmane.org>
Subject: I2C Slave support - how to use it?
Date: Wed, 18 Mar 2015 00:14:08 +0100
Message-ID: <201503180014.08870.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

I think the I2C slave support is an excellent feature you added to Linu=
x =20
(thanks for that) but I somehow have some problems to get it working on=
 -rc4.

What are the magical commands to get a linux slave on e.g. bus 1?


What I tried:
modprobe i2c-dev
modprobe i2c-slave-eeprom

# echo i2c_slave_eeprom 0x20 > /sys/bus/i2c/devices/i2c-1/new_device=20
[ 16.119] i2c i2c-1: new_device: Instantiated device i2c_slave_eeprom a=
t 0x20


# find /sys -name '*eeprom*'
/sys/bus/i2c/drivers/i2c-slave-eeprom
/sys/module/i2c_slave_eeprom
/sys/module/i2c_slave_eeprom/drivers/i2c:i2c-slave-eeprom

# ls  -lah /sys/bus/i2c/devices/1-0020/
insgesamt 0
drwxr-xr-x 3 root root    0 18. M=E4r 00:11 .
drwxr-xr-x 5 root root    0 18. M=E4r 00:11 ..
-r--r--r-- 1 root root 4,0K 18. M=E4r 00:11 modalias
-r--r--r-- 1 root root 4,0K 18. M=E4r 00:11 name
drwxr-xr-x 2 root root    0 18. M=E4r 00:11 power
lrwxrwxrwx 1 root root    0 18. M=E4r 00:11 subsystem -> ../../../../..=
/bus/i2c
-rw-r--r-- 1 root root 4,0K 18. M=E4r 00:11 uevent


--> the slave-eeprom file mentioned here is not present.
https://marc.info/?l=3Dlinux-i2c&m=3D142616417313963&w=3D4


Thanks,
Peter
