From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] i2c: Drop configure option I2C_DEBUG_CHIP
Date: Tue, 9 Mar 2010 11:36:25 +0100
Message-ID: <20100309113625.3c9ffd3f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c: Drop configure option I2C_DEBUG_CHIP

Now that directory drivers/i2c/chips is gone, configuration option
I2C_DEBUG_CHIP no longer has any effect, so we can drop it.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/Kconfig |    8 --------
 1 file changed, 8 deletions(-)

--- linux-2.6.34-rc0.orig/drivers/i2c/Kconfig	2010-03-07 11:48:07.000000000 +0100
+++ linux-2.6.34-rc0/drivers/i2c/Kconfig	2010-03-07 11:48:10.000000000 +0100
@@ -97,12 +97,4 @@ config I2C_DEBUG_BUS
 	  a problem with I2C support and want to see more of what is going
 	  on.
 
-config I2C_DEBUG_CHIP
-	bool "I2C Chip debugging messages"
-	help
-	  Say Y here if you want the I2C chip drivers to produce a bunch of
-	  debug messages to the system log.  Select this if you are having
-	  a problem with I2C support and want to see more of what is going
-	  on.
-
 endif # I2C


-- 
Jean Delvare
