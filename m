From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/2] i2c: Simplify i2c_parent_is_i2c_adapter
Date: Mon, 23 Aug 2010 11:29:14 +0200
Message-ID: <20100823112914.3fdc94b6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Only i2c devices can have their type set to i2c_adapter_type, so
testing the bus type is redundant.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
---
Michael, is this OK with you?

 include/linux/i2c.h |    1 -
 1 file changed, 1 deletion(-)

--- linux-2.6.36-rc0.orig/include/linux/i2c.h	2010-08-15 21:00:36.000000000 +0200
+++ linux-2.6.36-rc0/include/linux/i2c.h	2010-08-15 21:01:32.000000000 +0200
@@ -387,7 +387,6 @@ static inline void i2c_set_adapdata(stru
 static inline int i2c_parent_is_i2c_adapter(const struct i2c_adapter *adapter)
 {
 	return adapter->dev.parent != NULL
-		&& adapter->dev.parent->bus == &i2c_bus_type
 		&& adapter->dev.parent->type == &i2c_adapter_type;
 }
 


-- 
Jean Delvare
