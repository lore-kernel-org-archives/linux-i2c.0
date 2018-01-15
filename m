From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: acorn: remove outdated path from file header
Date: Mon, 15 Jan 2018 18:41:39 +0100
Message-ID: <20180115174139.12666-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40750 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755637AbeAORlv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 12:41:51 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Wolfram Sang <wsa@the-dreams.de>

That path has gone away for a long time. Move the HW name upwards for a
proper header.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-acorn.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-acorn.c b/drivers/i2c/busses/i2c-acorn.c
index 9d7be5af2bf2a0..24c13a152558a2 100644
--- a/drivers/i2c/busses/i2c-acorn.c
+++ b/drivers/i2c/busses/i2c-acorn.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/acorn/char/i2c.c
+ *  ARM IOC/IOMD i2c driver.
  *
  *  Copyright (C) 2000 Russell King
  *
@@ -7,8 +7,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- *  ARM IOC/IOMD i2c driver.
- *
  *  On Acorn machines, the following i2c devices are on the bus:
  *	- PCF8583 real time clock & static RAM
  */
-- 
2.11.0
