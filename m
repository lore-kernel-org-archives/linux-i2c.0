From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Delete ANY_I2C_BUS
Date: Wed, 16 Nov 2011 16:50:00 +0100
Message-ID: <20111116165000.7dd1d07f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Last piece of code using ANY_I2C_BUS was deleted almost 2 years ago,
so ANY_I2C_BUS can go away as well.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 include/linux/i2c.h |    3 ---
 1 file changed, 3 deletions(-)

--- linux-3.2-rc2.orig/include/linux/i2c.h	2011-11-09 15:53:58.000000000 +0100
+++ linux-3.2-rc2/include/linux/i2c.h	2011-11-16 16:28:29.000000000 +0100
@@ -432,9 +432,6 @@ void i2c_unlock_adapter(struct i2c_adapt
 /* Internal numbers to terminate lists */
 #define I2C_CLIENT_END		0xfffeU
 
-/* The numbers to use to set I2C bus address */
-#define ANY_I2C_BUS		0xffff
-
 /* Construct an I2C_CLIENT_END-terminated array of i2c addresses */
 #define I2C_ADDRS(addr, addrs...) \
 	((const unsigned short []){ addr, ## addrs, I2C_CLIENT_END })


-- 
Jean Delvare
