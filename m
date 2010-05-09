From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] i2c-bfin-twi: handle faulty slave devices better
Date: Sun,  9 May 2010 07:04:47 -0400
Message-ID: <1273403087-3326-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Faulty slave devices might drive SDA low after a transfer finishes.  So,
when this scenario is detected, have the master generate up to 8 extra
clocks until the SDA is properly released.

Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
Note: this requires the existing Blackfin TWI patches already sent out

 drivers/i2c/busses/i2c-bfin-twi.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index fb26e5c..f9c05e1 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -20,6 +20,7 @@
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 
 #include <asm/blackfin.h>
 #include <asm/portmux.h>
@@ -159,6 +160,27 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 		if (mast_stat & BUFWRERR)
 			dev_dbg(&iface->adap.dev, "Buffer Write Error\n");
 
+		/* Faulty salve devices, may drive SDA low after a transfer
+		 * finishes. To release the bus this code generates up to 8
+		 * extra clocks until SDA is released.
+		 */
+
+		if (read_MASTER_STAT(iface) & SDASEN) {
+			int cnt = 8;
+			do {
+				write_MASTER_CTL(iface, SCLOVR);
+				udelay(6);
+				write_MASTER_CTL(iface, 0);
+				udelay(6);
+			} while ((read_MASTER_STAT(iface) & SDASEN) && cnt--);
+
+			write_MASTER_CTL(iface, SDAOVR | SCLOVR);
+			udelay(6);
+			write_MASTER_CTL(iface, SDAOVR);
+			udelay(6);
+			write_MASTER_CTL(iface, 0);
+		}
+
 		/* If it is a quick transfer, only address without data,
 		 * not an err, return 1.
 		 */
-- 
1.7.1
