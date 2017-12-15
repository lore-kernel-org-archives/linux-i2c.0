From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 0/3] i2c: introduce devm_i2c_new_dummy and use it in at24
 driver
Date: Fri, 15 Dec 2017 18:36:42 +0100
Message-ID: <083569b1-489a-d84f-1a87-bca52fad53e1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35233 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755506AbdLORgw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Dec 2017 12:36:52 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

i2c_new_dummy is typically called from the probe function of the
driver for the primary i2c client. It requires calls to
i2c_unregister_device in the error path of the probe function and
in the remove function.
This can be simplified by introducing a device-managed version.

Make at24 driver the first user of the new function.

Changes in v2:
- add change to i2c core to make a version of i2c_new_device
  available which returns an ERR_PTR instead of NULL in error case
- few minor improvements

Changes in v3:
- rename _i2c_new_device to __i2c_new_device

Changes in v4:
- add missing kernel doc comments
- add Reviewed-by

Heiner Kallweit (3):
  i2c: core: improve return value handling of i2c_new_device and i2c_new_dummy
  i2c: core: add device-managed version of i2c_new_dummy
  eeprom: at24: switch to device-managed version of i2c_new_dummy

 Documentation/driver-model/devres.txt |   3 +
 drivers/i2c/i2c-core-base.c           | 108 ++++++++++++++++++++++++++++++----
 drivers/misc/eeprom/at24.c            |  31 ++++------
 include/linux/i2c.h                   |   3 +
 4 files changed, 112 insertions(+), 33 deletions(-)

-- 
2.15.1
