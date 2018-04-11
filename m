From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/3] eeprom: at24: last bits of the big refactoring
Date: Wed, 11 Apr 2018 16:38:25 +0200
Message-ID: <20180411143828.1046-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Peter Rosin <peda@axentia.se>, Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

This is a follow-up to the big series merged for 4.17. The patches
contain some bits and pieces that were missing in the last submission
or depend on some new features merged this merge window.

v1 -> v2:
- dropped patch 1/4 because id_table is still needed as pointed out by
  Peter Rosin
- fixed patch 3/3: we need to free the dummy client if regmap_init fails

Bartosz Golaszewski (3):
  eeprom: at24: use devm_nvmem_register()
  eeprom: at24: provide and use a helper for releasing dummy i2c clients
  eeprom: at24: provide a separate routine for creating dummy i2c
    clients

 drivers/misc/eeprom/at24.c | 71 ++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 25 deletions(-)

-- 
2.17.0
