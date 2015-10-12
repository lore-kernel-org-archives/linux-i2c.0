From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/9] eeprom: at24: at24cs series serial number read
Date: Mon, 12 Oct 2015 16:31:12 +0200
Message-ID: <1444660281-19150-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

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
