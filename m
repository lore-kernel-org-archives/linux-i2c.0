From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: {PATCH] i2c: Minor documentation update
Date: Mon, 28 Sep 2009 14:18:18 +0200
Message-ID: <20090928141818.1e934366@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The sysfs path to i2c adapters has changed recently, update the
documentation to reflect that change.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/instantiating-devices |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.32-rc1.orig/Documentation/i2c/instantiating-devices	2009-09-10 10:07:54.000000000 +0200
+++ linux-2.6.32-rc1/Documentation/i2c/instantiating-devices	2009-09-28 14:04:25.000000000 +0200
@@ -188,7 +188,7 @@ segment, the address is sufficient to un
 deleted.
 
 Example:
-# echo eeprom 0x50 > /sys/class/i2c-adapter/i2c-3/new_device
+# echo eeprom 0x50 > /sys/bus/i2c/devices/i2c-3/new_device
 
 While this interface should only be used when in-kernel device declaration
 can't be done, there is a variety of cases where it can be helpful:


-- 
Jean Delvare
