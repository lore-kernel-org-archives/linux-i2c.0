From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/14] eeprom: at24: driver rework and at24cs/at24mac support
Date: Sun, 29 May 2016 23:53:38 +0200
Message-ID: <1464558832-2262-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37297 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbcE2VyM (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 29 May 2016 17:54:12 -0400
Received: by mail-wm0-f41.google.com with SMTP id z87so50830392wmh.0
        for <linux-i2c@vger.kernel.org>; Sun, 29 May 2016 14:54:11 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>

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

This series also contains several patches refactoring the driver code.
Most notably: the low-level read/write routines are split into more
specialized, smaller functions that no longer perform functionality
checks at runtime.

Minor readability tweaks are also included.

Tested with at24cs32 and at24cs02 chips (for both 16 and 8 bit address
pointers). I have no means of testing the support for at24mac chips, I
relied solely on the datasheet.

Bartosz Golaszewski (14):
  eeprom: at24: improve the device_id table readability
  eeprom: at24: move at24_read() below at24_eeprom_write()
  eeprom: at24: coding style fixes
  eeprom: at24: call read/write functions via function pointers
  eeprom: at24: hide the read/write loop behind a macro
  eeprom: at24: split at24_eeprom_read() into specialized functions
  eeprom: at24: split at24_eeprom_write() into specialized functions
  eeprom: at24: platform_data: use BIT() macro
  eeprom: at24: platform_data: add serial number flag
  eeprom: at24: support reading the serial number
  eeprom: at24: add the at24cs series to the list of supported devices
  eeprom: at24: platform_data: add at24mac series flag
  eeprom: at24: add support for at24mac series
  eeprom: at24: add at24mac chips to the list of supported devices

 drivers/misc/eeprom/at24.c         | 498 +++++++++++++++++++++++++------------
 include/linux/platform_data/at24.h |  11 +-
 2 files changed, 350 insertions(+), 159 deletions(-)

-- 
2.7.4
