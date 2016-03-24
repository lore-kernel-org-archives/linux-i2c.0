From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 00/13] eeprom: support for at24cs and at24mac
Date: Thu, 24 Mar 2016 17:19:30 +0100
Message-ID: <1458836383-6668-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34077 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbcCXQTr (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Mar 2016 12:19:47 -0400
Received: by mail-wm0-f52.google.com with SMTP id p65so281764314wmp.1
        for <linux-i2c@vger.kernel.org>; Thu, 24 Mar 2016 09:19:47 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Chips from the at24cs EEPROM series have an additional read-only
memory area containing a factory pre-programmed serial number. In
order to access it, a dummy write must be executed before reading
the serial number bytes.

Chips from the at24mac familiy, apart from the serial number, have
a second special memory area containing a factory programmed
EUI-48/EUI64 mac address.

The read-only serial/mac memory area is accessible on a different i2c
slave address (addr + 0x08). This patchset makes it possible to
instantiate a separate at24 device on this second address and access
the read-only area through the regular eeprom sysfs attribute or the
new nvmem subsystem.

This series also contains several patches intoducing some minor tweaks
and refactoring.

Tested with at24cs32 and at24cs02 chips (for both 16 and 8 bit address
pointers). I have no means of testing the support for at24mac chips, I
relied solely on the datasheet.

v2:
- fixed the 'assignment from incompatible pointer type' bug reported
  by kbuild

v1: https://lkml.org/lkml/2016/3/24/337

Bartosz Golaszewski (13):
  eeprom: at24: remove a reduntant if
  eeprom: at24: improve the device_id table readability
  eeprom: at24: platform_data: use BIT() macro
  eeprom: at24: make locking more fine-grained
  eeprom: at24: replace msleep() with usleep_range()
  eeprom: at24: add serial number flag
  eeprom: at24: support reading of the serial number
  eeprom: at24: call read and write routines via function pointers
  eeprom: at24: use at24cs_serial_read()
  eeprom: at24: add the at24cs series to the list of supported devices
  eeprom: at24: add at24mac series flag
  eeprom: at24: add support for at24mac series
  eeprom: at24: add at24mac chips to the list of supported devices

 drivers/misc/eeprom/at24.c         | 201 ++++++++++++++++++++++++++++---------
 include/linux/platform_data/at24.h |  10 +-
 2 files changed, 162 insertions(+), 49 deletions(-)

-- 
2.7.4
