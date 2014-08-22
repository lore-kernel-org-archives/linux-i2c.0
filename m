From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Trickle charging for rtc-bq32k
Date: Fri, 22 Aug 2014 15:11:50 +0200
Message-ID: <20140822131150.GA26724@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi!

Here's a patch to enable trickle charging; without it the clock stops
when power is removed -> not very useful.

_But_ this should probably be enabled using device tree entry, right?
Unfortunately, the driver is i2c driver, not platform one, so I don't
see how to do that easily...

Or would module parameter be acceptable?

Thanks,
								Pavel

commit 00abeaa1197a5ad6400497558891793b6cd880d5
Author: Pavel <pavel-+ZI9xUNit7I@public.gmane.org>
Date:   Fri Aug 22 14:58:00 2014 +0200

Enable trickle charging for bq32k.

diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index c74bf0d..b6a4dd0 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -2,10 +2,14 @@
  * Driver for TI BQ32000 RTC.
  *
  * Copyright (C) 2009 Semihalf.
+ * Copyright (C) 2014 Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * You can get hardware description at
+ * http://www.ti.com/lit/ds/symlink/bq32000.pdf
  */
 
 #include <linux/module.h>
@@ -27,6 +31,10 @@
 #define BQ32K_CENT		0x40	/* Century flag */
 #define BQ32K_CENT_EN		0x80	/* Century flag enable bit */
 
+#define BQ32K_CALIBRATION	0x07	/* CAL_CFG1, calibration and control */
+#define BQ32K_TCH2		0x08	/* Trickle charge enable */
+#define BQ32K_CFG2		0x09	/* Trickle charger control */
+
 struct bq32k_regs {
 	uint8_t		seconds;
 	uint8_t		minutes;
@@ -153,6 +161,25 @@ static int bq32k_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
+	if (0) {
+		/*
+		 * TCHE[3:0] == 0x05, TCH2 == 1, TCFE == 0 (charging
+		 * over diode and 940ohm resistor)
+		 */
+
+		reg = 0x05;
+		error = bq32k_write(dev, &reg, BQ32K_CFG2, 1);
+		if (error)
+			return error;
+
+		reg = 0x20;
+		error = bq32k_write(dev, &reg, BQ32K_TCH2, 1);
+		if (error)
+			return error;
+
+		dev_info(dev, "Enabled trickle RTC battery charge.\n");
+	}
+
 	rtc = devm_rtc_device_register(&client->dev, bq32k_driver.driver.name,
 						&bq32k_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc))

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
