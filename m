From: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: [PATCH 5/6] i2c: update i2c_algorithm documentation
Date: Sun, 26 Jan 2014 16:05:36 +0000
Message-ID: <1390752337-22386-6-git-send-email-ben.dooks@codethink.co.uk>
References: <1390752337-22386-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390752337-22386-1-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add some kerneldoc style documentaton to the i2c_algorithm
structure, and point the master_xfer return codes at the
right place in Documentation/i2c/fault_codes

Signed-off-by: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
---
Cc: Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 include/linux/i2c.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index eff50e0..2aeb091 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -342,11 +342,25 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
 }
 #endif /* I2C_BOARDINFO */
 
-/*
+/**
+ * struct i2c_algorithm - represent I2C transfer method
+ * @master_xfer: Issue a set of i2c transactions to the given I2C adapter
+ *   defined by the msgs array, with num messages available to transfer via
+ *   the adapter specified by adap.
+ * @smbus_xfer: Issue smbus transactions to the given I2C adapter. If this
+ *   is not present, then the bus layer will try and convert the SMBus calls
+ *   into I2C transfers instead.
+ * @functionality: Return the flags that this algorithm/adapter pair supports
+ *   from the I2C_FUNC_* flags.
+ *
  * The following structs are for those who like to implement new bus drivers:
  * i2c_algorithm is the interface to a class of hardware solutions which can
  * be addressed using the same bus algorithms - i.e. bit-banging or the PCF8584
  * to name two of the most common.
+ *
+ * The return codes from the @master_xfer field should indicate the type of
+ * error code that occured during the transfer, as documented in the kernel
+ * Documentation file Documentation/i2c/fault-codes.
  */
 struct i2c_algorithm {
 	/* If an adapter algorithm can't do I2C-level access, set master_xfer
-- 
1.8.5.2
