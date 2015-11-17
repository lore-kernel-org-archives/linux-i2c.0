From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 0/9] eeprom: at24: at24cs series serial number read
Date: Tue, 17 Nov 2015 10:52:21 +0100
Message-ID: <1447753950-17213-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

(rebased against 4.4-rc1)

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
