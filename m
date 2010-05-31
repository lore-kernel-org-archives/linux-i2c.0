From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/4] i2c: Share the I2C device presence detection code
Date: Mon, 31 May 2010 13:30:11 +0200
Message-ID: <20100531133011.6e08d9dd@hyperion.delvare>
References: <20100531132213.65f20b8f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100531132213.65f20b8f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use the same I2C device presence detection code for legacy and new
device detection functions. This is more consistent and makes the code
smaller.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   80 ++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)
--- linux-2.6.35-rc0.orig/drivers/i2c/i2c-core.c	2010-05-30 17:48:49.000000000 +0200
+++ linux-2.6.35-rc0/drivers/i2c/i2c-core.c	2010-05-30 18:41:07.000000000 +0200
@@ -1277,6 +1277,41 @@ EXPORT_SYMBOL(i2c_master_recv);
  * ----------------------------------------------------
  */
 
+/*
+ * Legacy default probe function, mostly relevant for SMBus. The default
+ * probe method is a quick write, but it is known to corrupt the 24RF08
+ * EEPROMs due to a state machine bug, and could also irreversibly
+ * write-protect some EEPROMs, so for address ranges 0x30-0x37 and 0x50-0x5f,
+ * we use a short byte read instead. Also, some bus drivers don't implement
+ * quick write, so we fallback to a byte read in that case too.
+ * On x86, there is another special case for FSC hardware monitoring chips,
+ * which want regular byte reads (address 0x73.) Fortunately, these are the
+ * only known chips using this I2C address on PC hardware.
+ * Returns 1 if probe succeeded, 0 if not.
+ */
+static int i2c_default_probe(struct i2c_adapter *adap, unsigned short addr)
+{
+	int err;
+	union i2c_smbus_data dummy;
+
+#ifdef CONFIG_X86
+	if (addr == 0x73 && (adap->class & I2C_CLASS_HWMON)
+	 && i2c_check_functionality(adap, I2C_FUNC_SMBUS_READ_BYTE_DATA))
+		err = i2c_smbus_xfer(adap, addr, 0, I2C_SMBUS_READ, 0,
+				     I2C_SMBUS_BYTE_DATA, &dummy);
+	else
+#endif
+	if ((addr & ~0x07) == 0x30 || (addr & ~0x0f) == 0x50
+	 || !i2c_check_functionality(adap, I2C_FUNC_SMBUS_QUICK))
+		err = i2c_smbus_xfer(adap, addr, 0, I2C_SMBUS_READ, 0,
+				     I2C_SMBUS_BYTE, &dummy);
+	else
+		err = i2c_smbus_xfer(adap, addr, 0, I2C_SMBUS_WRITE, 0,
+				     I2C_SMBUS_QUICK, NULL);
+
+	return err >= 0;
+}
+
 static int i2c_detect_address(struct i2c_client *temp_client,
 			      struct i2c_driver *driver)
 {
@@ -1297,23 +1332,8 @@ static int i2c_detect_address(struct i2c
 		return 0;
 
 	/* Make sure there is something at this address */
-	if (addr == 0x73 && (adapter->class & I2C_CLASS_HWMON)) {
-		/* Special probe for FSC hwmon chips */
-		union i2c_smbus_data dummy;
-
-		if (i2c_smbus_xfer(adapter, addr, 0, I2C_SMBUS_READ, 0,
-				   I2C_SMBUS_BYTE_DATA, &dummy) < 0)
-			return 0;
-	} else {
-		if (i2c_smbus_xfer(adapter, addr, 0, I2C_SMBUS_WRITE, 0,
-				   I2C_SMBUS_QUICK, NULL) < 0)
-			return 0;
-
-		/* Prevent 24RF08 corruption */
-		if ((addr & ~0x0f) == 0x50)
-			i2c_smbus_xfer(adapter, addr, 0, I2C_SMBUS_WRITE, 0,
-				       I2C_SMBUS_QUICK, NULL);
-	}
+	if (!i2c_default_probe(adapter, addr))
+		return 0;
 
 	/* Finally call the custom detection function */
 	memset(&info, 0, sizeof(struct i2c_board_info));
@@ -1420,29 +1440,9 @@ i2c_new_probed_device(struct i2c_adapter
 			continue;
 		}
 
-		/* Test address responsiveness
-		   The default probe method is a quick write, but it is known
-		   to corrupt the 24RF08 EEPROMs due to a state machine bug,
-		   and could also irreversibly write-protect some EEPROMs, so
-		   for address ranges 0x30-0x37 and 0x50-0x5f, we use a byte
-		   read instead. Also, some bus drivers don't implement
-		   quick write, so we fallback to a byte read it that case
-		   too. */
-		if ((addr_list[i] & ~0x07) == 0x30
-		 || (addr_list[i] & ~0x0f) == 0x50
-		 || !i2c_check_functionality(adap, I2C_FUNC_SMBUS_QUICK)) {
-			union i2c_smbus_data data;
-
-			if (i2c_smbus_xfer(adap, addr_list[i], 0,
-					   I2C_SMBUS_READ, 0,
-					   I2C_SMBUS_BYTE, &data) >= 0)
-				break;
-		} else {
-			if (i2c_smbus_xfer(adap, addr_list[i], 0,
-					   I2C_SMBUS_WRITE, 0,
-					   I2C_SMBUS_QUICK, NULL) >= 0)
-				break;
-		}
+		/* Test address responsiveness */
+		if (i2c_default_probe(adap, addr_list[i]))
+			break;
 	}
 
 	if (addr_list[i] == I2C_CLIENT_END) {

-- 
Jean Delvare
