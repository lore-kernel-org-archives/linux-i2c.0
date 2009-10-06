From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/3] i2c: Simplify i2c_detect_address
Date: Tue, 6 Oct 2009 18:05:35 +0200
Message-ID: <20091006180535.7ae324a7@hyperion.delvare>
References: <20091006175611.46bf0dfa@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091006175611.46bf0dfa-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The kind parameter of i2c_detect_address() always has value -1, so we
can get rid of it.

Next step is to update all i2c detect callback functions to get rid of
this now useless parameter.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/i2c/i2c-core.c	2009-10-05 21:17:14.000000000 +0200
+++ linux-2.6.32-rc3/drivers/i2c/i2c-core.c	2009-10-06 09:55:31.000000000 +0200
@@ -1169,7 +1169,7 @@ EXPORT_SYMBOL(i2c_master_recv);
  * ----------------------------------------------------
  */
 
-static int i2c_detect_address(struct i2c_client *temp_client, int kind,
+static int i2c_detect_address(struct i2c_client *temp_client,
 			      struct i2c_driver *driver)
 {
 	struct i2c_board_info info;
@@ -1188,22 +1188,18 @@ static int i2c_detect_address(struct i2c
 	if (i2c_check_addr(adapter, addr))
 		return 0;
 
-	/* Make sure there is something at this address, unless forced */
-	if (kind < 0) {
-		if (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
-				   I2C_SMBUS_QUICK, NULL) < 0)
-			return 0;
-
-		/* prevent 24RF08 corruption */
-		if ((addr & ~0x0f) == 0x50)
-			i2c_smbus_xfer(adapter, addr, 0, 0, 0,
-				       I2C_SMBUS_QUICK, NULL);
-	}
+	/* Make sure there is something at this address */
+	if (i2c_smbus_xfer(adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) < 0)
+		return 0;
+
+	/* Prevent 24RF08 corruption */
+	if ((addr & ~0x0f) == 0x50)
+		i2c_smbus_xfer(adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL);
 
 	/* Finally call the custom detection function */
 	memset(&info, 0, sizeof(struct i2c_board_info));
 	info.addr = addr;
-	err = driver->detect(temp_client, kind, &info);
+	err = driver->detect(temp_client, -1, &info);
 	if (err) {
 		/* -ENODEV is returned if the detection fails. We catch it
 		   here as this isn't an error. */
@@ -1268,7 +1264,7 @@ static int i2c_detect(struct i2c_adapter
 			"addr 0x%02x\n", adap_id,
 			address_data->normal_i2c[i]);
 		temp_client->addr = address_data->normal_i2c[i];
-		err = i2c_detect_address(temp_client, -1, driver);
+		err = i2c_detect_address(temp_client, driver);
 		if (err)
 			goto exit_free;
 	}

-- 
Jean Delvare
