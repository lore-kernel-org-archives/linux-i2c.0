From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 04/21] eeprom: at24: use SPDX identifier instead of GPL boiler-plate
Date: Mon, 19 Mar 2018 10:17:04 +0100
Message-ID: <20180319091721.18193-5-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Replace the GPL header with an SPDX identifier for GPL-2.0.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2a4154eeb1bd..0e06201d33c9 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -1,14 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * at24.c - handle most I2C EEPROMs
  *
  * Copyright (C) 2005-2007 David Brownell
  * Copyright (C) 2008 Wolfram Sang, Pengutronix
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
-- 
2.16.1
