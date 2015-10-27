From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/9] eeprom: at24: at24cs series serial number read
Date: Tue, 27 Oct 2015 12:43:44 +0100
Message-ID: <1445946233-6071-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35312 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbbJ0LvA (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 27 Oct 2015 07:51:00 -0400
Received: by wmll128 with SMTP id l128so245236wml.0
        for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2015 04:50:59 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Chips from the at24cs EEPROM series have an additional read-only memory area
containing a factory pre-programmed serial number. In order to access it, a
dummy write must be executed before reading the serial number bytes.

This series adds support for reading the serial number through a sysfs
attribute.

While we're at it: some of the patches contain readability tweaks and code
organization fixes.

Tested with at24cs64 and at24cs02 chips (for both 16 and 8 bit address
pointers).

v2:
- protect the serial number read with a mutex

v1: https://lkml.org/lkml/2015/10/20/162

Bartosz Golaszewski (9):
  eeprom: at24: platform_data: use BIT() macro
  eeprom: at24: new flag in platform_data
  eeprom: at24: tie up an additional address for at24cs series
  eeprom: at24: support reading of the serial number
  eeprom: at24: export the serial number through sysfs
  eeprom: at24: improve the device_id table readability
  eeprom: at24: add the at24cs series to the list of supported devices
  eeprom: at24: remove a reduntant if
  eeprom: at24: readability tweaks

 drivers/misc/eeprom/at24.c         | 187 +++++++++++++++++++++++++++++++------
 include/linux/platform_data/at24.h |   9 +-
 2 files changed, 166 insertions(+), 30 deletions(-)

-- 
2.1.4
