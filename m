From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Make i2c_default_probe self-sufficient
Date: Thu, 17 Jun 2010 18:04:31 +0200
Message-ID: <20100617180431.66309c3d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make i2c_default_probe self-sufficient, so that callers don't have to
do functionality checks themselves. This ensures everything is and
will stay consistent.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

--- linux-2.6.35-rc3.orig/drivers/i2c/i2c-core.c	2010-06-17 13:05:41.000000000 +0200
+++ linux-2.6.35-rc3/drivers/i2c/i2c-core.c	2010-06-17 17:02:47.000000000 +0200
@@ -1369,13 +1369,17 @@ static int i2c_default_probe(struct i2c_
 				     I2C_SMBUS_BYTE_DATA, &dummy);
 	else
 #endif
-	if ((addr & ~0x07) == 0x30 || (addr & ~0x0f) == 0x50
-	 || !i2c_check_functionality(adap, I2C_FUNC_SMBUS_QUICK))
-		err = i2c_smbus_xfer(adap, addr, 0, I2C_SMBUS_READ, 0,
-				     I2C_SMBUS_BYTE, &dummy);
-	else
+	if (!((addr & ~0x07) == 0x30 || (addr & ~0x0f) == 0x50)
+	 && i2c_check_functionality(adap, I2C_FUNC_SMBUS_QUICK))
 		err = i2c_smbus_xfer(adap, addr, 0, I2C_SMBUS_WRITE, 0,
 				     I2C_SMBUS_QUICK, NULL);
+	else if (i2c_check_functionality(adap, I2C_FUNC_SMBUS_READ_BYTE))
+		err = i2c_smbus_xfer(adap, addr, 0, I2C_SMBUS_READ, 0,
+				     I2C_SMBUS_BYTE, &dummy);
+	else {
+		dev_warn(&adap->dev, "No suitable probing method supported\n");
+		err = -EOPNOTSUPP;
+	}
 
 	return err >= 0;
 }
@@ -1456,16 +1460,6 @@ static int i2c_detect(struct i2c_adapter
 	if (!(adapter->class & driver->class))
 		goto exit_free;
 
-	/* Stop here if the bus doesn't support probing */
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE)) {
-		if (address_list[0] == I2C_CLIENT_END)
-			goto exit_free;
-
-		dev_warn(&adapter->dev, "Probing not supported\n");
-		err = -EOPNOTSUPP;
-		goto exit_free;
-	}
-
 	for (i = 0; address_list[i] != I2C_CLIENT_END; i += 1) {
 		dev_dbg(&adapter->dev, "found normal entry for adapter %d, "
 			"addr 0x%02x\n", adap_id, address_list[i]);
@@ -1495,14 +1489,8 @@ i2c_new_probed_device(struct i2c_adapter
 {
 	int i;
 
-	if (!probe) {
-		/* Stop here if the bus doesn't support probing */
-		if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_READ_BYTE)) {
-			dev_err(&adap->dev, "Probing not supported\n");
-			return NULL;
-		}
+	if (!probe)
 		probe = i2c_default_probe;
-	}
 
 	for (i = 0; addr_list[i] != I2C_CLIENT_END; i++) {
 		/* Check address validity */


-- 
Jean Delvare
