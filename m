From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/7] eeprom: at24: switch driver to regmap_i2c
Date: Thu, 16 Nov 2017 21:16:05 +0100
Message-ID: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37843 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932144AbdKPUQN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 16 Nov 2017 15:16:13 -0500
Received: by mail-wm0-f66.google.com with SMTP id v186so2543496wma.2
        for <linux-i2c@vger.kernel.org>; Thu, 16 Nov 2017 12:16:12 -0800 (PST)
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

Heiner Kallweit (7):
  eeprom: at24: add basic regmap_i2c support
  eeprom: at24: change at24_translate_offset return type
  eeprom: at24: add regmap-based write function
  eeprom: at24: remove old write functions
  eeprom: at24: add regmap-based read functions
  eeprom: at24: remove old read functions
  eeprom: at24: remove now unneeded smbus-related code

 drivers/misc/eeprom/Kconfig |   1 +
 drivers/misc/eeprom/at24.c  | 385 +++++++++-----------------------------------
 2 files changed, 79 insertions(+), 307 deletions(-)

-- 
2.15.0
