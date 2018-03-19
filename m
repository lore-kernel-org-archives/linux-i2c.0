From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 00/21] eeprom: at24: driver refactoring
Date: Mon, 19 Mar 2018 10:17:00 +0100
Message-ID: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

This series contains what I hope to be a non-controversial refactoring
of the at24 eeprom driver.

Most changes revolve around at24_probe() which became quite complicated
and hard to read.

The only functional changes are: disabling the internal locking
mechanisms of regmap (since we already take care of that in the driver)
and removing an if checking if byte_len is a power of 2 (as we do
support models for which it's not true).

All other patches affect readability and code structure.

Tested with a couple models and different both for device tree and
platform data modes.

Bartosz Golaszewski (21):
  eeprom: at24: disable regmap locking
  eeprom: at24: remove nvmem_config from at24_data
  eeprom: at24: arrange local variables
  eeprom: at24: use SPDX identifier instead of GPL boiler-plate
  eeprom: at24: remove code separators
  eeprom: at24: drop redundant variable in at24_read()
  eeprom: at24: drop redundant variable in at24_write()
  eeprom: at24: make struct initialization uniform in at24_probe()
  eeprom: at24: don't check if byte_len is a power of 2
  eeprom: at24: rename at24_get_pdata()
  eeprom: at24: rename chip to pdata in at24_probe()
  eeprom: at24: use a helper variable for dev
  eeprom: at24: readability tweak in at24_probe()
  eeprom: at24: provide and use at24_base_client_dev()
  eeprom: at24: switch to using probe_new() from the i2c framework
  eeprom: at24: move platform data processing into a separate routine
  eeprom: at24: remove at24_platform_data from at24_data
  eeprom: at24: refactor at24_probe()
  eeprom: at24: tweak newlines
  eeprom: at24: fix a line break
  eeprom: at24: simplify the i2c functionality checking

 drivers/misc/eeprom/at24.c | 293 ++++++++++++++++++++++++---------------------
 1 file changed, 156 insertions(+), 137 deletions(-)

-- 
2.16.1
