From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/4] eeprom: at24: last bits of the big refactoring
Date: Tue, 10 Apr 2018 15:12:02 +0200
Message-ID: <20180410131206.25760-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Peter Rosin <peda@axentia.se>, Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

This is a follow-up to the big series merged for 4.17. The patches
contain some bits and pieces that were missing in the last submission
or depend on some new features merged this merge window.

Bartosz Golaszewski (4):
  eeprom: at24: don't assign the i2c ID table to at24_driver
  eeprom: at24: use devm_nvmem_register()
  eeprom: at24: provide and use a helper for releasing dummy i2c clients
  eeprom: at24: provide a separate routine for creating dummy i2c
    clients

 drivers/misc/eeprom/at24.c | 70 ++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 26 deletions(-)

-- 
2.17.0
