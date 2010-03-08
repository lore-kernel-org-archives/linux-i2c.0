From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-stub: Expose the default functionality flags
Date: Mon, 8 Mar 2010 08:47:10 +0100
Message-ID: <20100308084710.30708ce2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

It is easier to adjust the flags when you know their default value.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-stub.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6.33.orig/drivers/i2c/busses/i2c-stub.c	2010-02-25 09:12:23.000000000 +0100
+++ linux-2.6.33/drivers/i2c/busses/i2c-stub.c	2010-03-06 14:33:22.000000000 +0100
@@ -29,13 +29,16 @@
 #include <linux/i2c.h>
 
 #define MAX_CHIPS 10
+#define STUB_FUNC (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE | \
+		   I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA | \
+		   I2C_FUNC_SMBUS_I2C_BLOCK)
 
 static unsigned short chip_addr[MAX_CHIPS];
 module_param_array(chip_addr, ushort, NULL, S_IRUGO);
 MODULE_PARM_DESC(chip_addr,
 		 "Chip addresses (up to 10, between 0x03 and 0x77)");
 
-static unsigned long functionality = ~0UL;
+static unsigned long functionality = STUB_FUNC;
 module_param(functionality, ulong, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(functionality, "Override functionality bitfield");
 
@@ -156,9 +159,7 @@ static s32 stub_xfer(struct i2c_adapter
 
 static u32 stub_func(struct i2c_adapter *adapter)
 {
-	return (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
-		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-		I2C_FUNC_SMBUS_I2C_BLOCK) & functionality;
+	return STUB_FUNC & functionality;
 }
 
 static const struct i2c_algorithm smbus_algorithm = {


-- 
Jean Delvare
