From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/7] eeprom: at24: series with smaller improvements
Date: Thu, 30 Nov 2017 07:40:59 +0100
Message-ID: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36363 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdK3GlG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Nov 2017 01:41:06 -0500
Received: by mail-wm0-f65.google.com with SMTP id b76so10301543wmg.1
        for <linux-i2c@vger.kernel.org>; Wed, 29 Nov 2017 22:41:06 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Before doing bigger changes, e.g. replacing the magic config values with
a struct, here comes series with smaller improvements.

Heiner Kallweit (7):
  eeprom: at24: don't explicitely include header files which are implicitely included
  eeprom: at24: consider that SERIAL and MAC flags imply read-only
  eeprom: at24: simplify probe a little by replacing &client->dev
  eeprom: at24: simplify functions at24_read/write a little
  eeprom: at24: zero-initialize variable chip in probe
  eeprom: at24: don't check chip.byte_len for power of two
  eeprom: at24: don't check page_size for read-only chips and reorder checks

 drivers/misc/eeprom/at24.c | 154 +++++++++++++++++++--------------------------
 1 file changed, 64 insertions(+), 90 deletions(-)

-- 
2.15.0
