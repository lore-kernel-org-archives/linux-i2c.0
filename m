From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 0/9] eeprom: at24: at24cs series serial number read
Date: Tue, 20 Oct 2015 10:43:18 +0200
Message-ID: <1445330607-12470-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35040 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbbJTInk (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Oct 2015 04:43:40 -0400
Received: by wicll6 with SMTP id ll6so34312449wic.0
        for <linux-i2c@vger.kernel.org>; Tue, 20 Oct 2015 01:43:39 -0700 (PDT)
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

 drivers/misc/eeprom/at24.c         | 181 +++++++++++++++++++++++++++++++------
 include/linux/platform_data/at24.h |   9 +-
 2 files changed, 160 insertions(+), 30 deletions(-)

-- 
2.1.4
