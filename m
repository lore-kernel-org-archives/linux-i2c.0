From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 0/7] eeprom: at24: switch driver to regmap_i2c
Date: Wed, 22 Nov 2017 22:04:39 +0100
Message-ID: <0448eec2-7dfb-ca79-d03a-d5b7fcb5d76c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:43965 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdKVVEq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 22 Nov 2017 16:04:46 -0500
Received: by mail-wm0-f68.google.com with SMTP id x63so12942870wmf.2
        for <linux-i2c@vger.kernel.org>; Wed, 22 Nov 2017 13:04:45 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Using regmap_i2c allows us to get rid of dealing with the low-level
differences between I2C and SMBUS. As a result the code can be
simplified a lot.

This patchset was successfully tested with a 24C32 on a I2C adapter.

The patchset was submitted first in Aug 2017 and was sitting in
the review queue until now. Resubmitted version is rebased due to
recent changes to at24.

Changes in v3:
- Small changes based on review comments
- Introduce at24_adjust_read_offset to avoid some overhead
Changes in v4:
- Small improvement in patch 5

Heiner Kallweit (7):
  eeprom: at24: add basic regmap_i2c support
  eeprom: at24: change at24_translate_offset return type
  eeprom: at24: add regmap-based write function
  eeprom: at24: remove old write functions
  eeprom: at24: add regmap-based read functions
  eeprom: at24: remove old read functions
  eeprom: at24: remove now unneeded smbus-related code

 drivers/misc/eeprom/Kconfig |   1 +
 drivers/misc/eeprom/at24.c  | 426 +++++++++++---------------------------------
 2 files changed, 105 insertions(+), 322 deletions(-)

-- 
2.15.0
