From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RFC 0/7] eeprom: at24: switch driver to regmap_i2c
Date: Thu, 17 Aug 2017 07:45:37 +0200
Message-ID: <2e264f77-2316-b6b6-e66c-b162f77d81de@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38411 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdHQFpv (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 17 Aug 2017 01:45:51 -0400
Received: by mail-wr0-f193.google.com with SMTP id 49so308696wrw.5
        for <linux-i2c@vger.kernel.org>; Wed, 16 Aug 2017 22:45:51 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Using regmap_i2c allows us to get rid of dealing with the low-level
differences between I2C and SMBUS. As a result the code can be
simplified a lot.

This patchset was successfully tested with a 24C32 on a I2C adapter.

Heiner Kallweit (7):
  eeprom: at24: add basic regmap_i2c support
  eeprom: at24: change at24_translate_offset return type
  eeprom: at24: add regmap-based write function
  eeprom: at24: remove old write functions
  eeprom: at24: add regmap-based read functions
  eeprom: at24: remove old read functions
  eeprom: at24: remove now unneeded smbus-related code

 drivers/misc/eeprom/Kconfig |   1 +
 drivers/misc/eeprom/at24.c  | 381 +++++++++-----------------------------------
 2 files changed, 77 insertions(+), 305 deletions(-)

-- 
2.14.1
