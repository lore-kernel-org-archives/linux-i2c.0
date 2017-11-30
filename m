From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/7] eeprom: at24: don't explicitely include header files
 which are implicitely included
Date: Thu, 30 Nov 2017 07:48:58 +0100
Message-ID: <5fd1ad39-db94-e774-b77c-8081bfed7817@gmail.com>
References: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:44846 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbdK3GtS (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Nov 2017 01:49:18 -0500
Received: by mail-wm0-f65.google.com with SMTP id t8so10816899wmc.3
        for <linux-i2c@vger.kernel.org>; Wed, 29 Nov 2017 22:49:17 -0800 (PST)
In-Reply-To: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Don't explicitely include header files which are implicitely included.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/at24.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index cd87f1b21..c75bb9b45 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -10,15 +10,10 @@
  * (at your option) any later version.
  */
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/mutex.h>
-#include <linux/mod_devicetable.h>
-#include <linux/log2.h>
-#include <linux/bitops.h>
 #include <linux/jiffies.h>
 #include <linux/property.h>
 #include <linux/acpi.h>
-- 
2.15.0
