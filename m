From: Sven Van Asbroeck <svendev@arcx.com>
Subject: BUG: support for at24 multi-slave-address eeproms is broken.
Date: Thu, 30 Nov 2017 14:03:23 -0500
Message-ID: <1512068603-12378-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.arcx.com ([184.94.50.18]:47951 "EHLO WEBMAIL.arcx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbdK3TD3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 30 Nov 2017 14:03:29 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: svendev@arcx.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: divagar.mohandass@intel.com, sakari.ailus@linux.intel.com, brgl@bgdev.pl

Summary
-------
Some at24 eeproms have multiple i2c slave addresses. A patch introduced
between 4.14-rc5 and 4.14-rc6 breaks support for these eeproms:
reads/writes which start outside the first slave no longer work.

98e8201039afad5d2af87df9ac682f62f69c0c2f
(eeprom: at24: enable runtime pm support)

How to reproduce
----------------
- I'm using the latest mainline at24 driver (4.15-rc1)
- I have a 24AA16/24LC16B on board, which is a 2048-byte eeprom,
	made up of 8x 256-byte internal eeproms, all with their own i2c slave
	address. Base i2c address is 0x50, so this results in the following
	slave addresses: 0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57 of
	256 bytes each.

$ ls -l /sys/bus/i2c/devices/1-0050/eeprom
-rw-------    1 root     root          2048 Nov 30 13:16 /sys/bus/i2c/devices/1-0050/eeprom

Reading from the beginning to the end in one go works just fine:
$ hexdump -C /sys/bus/i2c/devices/1-0050/eeprom 
00000000  f8 6e cf 01 ff 01 00 00  03 00 58 41 18 00 00 00  |.n........XA....|
00000010  53 61 74 20 4d 61 72 20  31 32 20 31 32 3a 35 35  |Sat Mar 12 12:55|
00000020  3a 31 32 20 32 30 31 36  01 00 58 41 0f 00 00 00  |:12 2016..XA....|
00000030  41 58 4d 2d 55 50 33 32  39 32 2d 30 38 32 34 00  |AXM-UP3292-0824.|
00000040  02 00 58 41 0d 00 00 00  41 58 53 2d 55 50 33 4b  |..XA....AXS-UP3K|
00000050  2d 30 32 30 34 00 00 00  04 00 58 41 09 00 00 00  |-0204.....XA....|
00000060  55 4e 54 31 34 30 30 42  34 00 00 00 0a 00 58 41  |UNT1400B4.....XA|
00000070  01 00 00 00 32 00 00 00  09 00 58 41 01 00 00 00  |....2.....XA....|
00000080  31 00 00 00 01 00 00 00  32 00 00 00 01 00 00 00  |1.......2.......|
00000090  32 00 00 00 ff ff ff ff  ff ff ff ff ff ff ff ff  |2...............|
000000a0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
00000800

Reading from somewhere in the middle (outside of first slave) gives
EACCESS:
$ dd if=/sys/bus/i2c/devices/1-0050/eeprom bs=1 skip=520 count=20
dd: /sys/bus/i2c/devices/1-0050/eeprom: Permission denied

Reading from somewhere in the middle (INSIDE of first slave) still works:
$ dd if=/sys/bus/i2c/devices/1-0050/eeprom bs=1 skip=20 count=20 | hexdump -C
00000000  4d 61 72 20 31 32 20 31  32 3a 35 35 3a 31 32 20  |Mar 12 12:55:12 |
00000010  32 30 31 36                                       |2016|
00000014

Additional questions for the patch authors
------------------------------------------
1. why is there a need to add pm_runtime support to a series of chips
(at24) which do not have any power management registers, hardware or
support ?

2. why is the at24's pm_runtime support operating on its parent i2c bus?
Why can't the parent i2c bus driver be in charge of its own runtime pm?
