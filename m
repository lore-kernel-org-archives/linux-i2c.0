From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/3] i2c: introduce devm_i2c_new_dummy and use it in at24
 driver
Date: Wed, 6 Dec 2017 21:53:35 +0100
Message-ID: <c765d409-5d33-8d6f-c883-9be93f507e01@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35899 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdLFUxp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Dec 2017 15:53:45 -0500
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

Heiner Kallweit (3):
  i2c: core: improve return value handling of i2c_new_device and i2c_new_dummy
  i2c: core: add device-managed version of i2c_new_dummy
  eeprom: at24: switch to device-managed version of i2c_new_dummy

 Documentation/driver-model/devres.txt |  3 ++
 drivers/i2c/i2c-core-base.c           | 94 ++++++++++++++++++++++++++++-------
 drivers/misc/eeprom/at24.c            | 31 ++++--------
 include/linux/i2c.h                   |  3 ++
 4 files changed, 94 insertions(+), 37 deletions(-)

-- 
2.15.1
