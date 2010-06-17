From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Fix probability check
Date: Thu, 17 Jun 2010 13:04:15 +0200
Message-ID: <20100617130415.2276bc45@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The new unified probing function differs from the original code, and
the preliminary test whether probing is possible must be updated
accordingly.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
It would probably make more sense to skip this test altogether and
make i2c_default_probe() more robust, but this quick fix will do for
2.6.35 meanwhile.

 drivers/i2c/i2c-core.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.35-rc3.orig/drivers/i2c/i2c-core.c	2010-06-17 10:38:40.000000000 +0200
+++ linux-2.6.35-rc3/drivers/i2c/i2c-core.c	2010-06-17 10:50:38.000000000 +0200
@@ -1428,13 +1428,12 @@ static int i2c_detect(struct i2c_adapter
 	if (!(adapter->class & driver->class))
 		goto exit_free;
 
-	/* Stop here if we can't use SMBUS_QUICK */
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK)) {
+	/* Stop here if the bus doesn't support probing */
+	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_READ_BYTE)) {
 		if (address_list[0] == I2C_CLIENT_END)
 			goto exit_free;
 
-		dev_warn(&adapter->dev, "SMBus Quick command not supported, "
-			 "can't probe for chips\n");
+		dev_warn(&adapter->dev, "Probing not supported\n");
 		err = -EOPNOTSUPP;
 		goto exit_free;
 	}


-- 
Jean Delvare
