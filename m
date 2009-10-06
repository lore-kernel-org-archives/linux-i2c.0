From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/3] ics932s401: Clean up detect function
Date: Tue, 6 Oct 2009 18:06:23 +0200
Message-ID: <20091006180623.4face173@hyperion.delvare>
References: <20091006175611.46bf0dfa@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091006175611.46bf0dfa-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Darrick J. Wong" <djwong-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As kind is now hard-coded to -1, there is room for code clean-ups.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "Darrick J. Wong" <djwong-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
---
 drivers/misc/ics932s401.c |   35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/misc/ics932s401.c	2009-10-06 10:33:15.000000000 +0200
+++ linux-2.6.32-rc3/drivers/misc/ics932s401.c	2009-10-06 10:34:10.000000000 +0200
@@ -417,32 +417,25 @@ static int ics932s401_detect(struct i2c_
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
+	int vendor, device, revision;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	if (kind <= 0) {
-		int vendor, device, revision;
+	vendor = i2c_smbus_read_word_data(client, ICS932S401_REG_VENDOR_REV);
+	vendor >>= 8;
+	revision = vendor >> ICS932S401_REV_SHIFT;
+	vendor &= ICS932S401_VENDOR_MASK;
+	if (vendor != ICS932S401_VENDOR)
+		return -ENODEV;
+
+	device = i2c_smbus_read_word_data(client, ICS932S401_REG_DEVICE);
+	device >>= 8;
+	if (device != ICS932S401_DEVICE)
+		return -ENODEV;
 
-		vendor = i2c_smbus_read_word_data(client,
-						  ICS932S401_REG_VENDOR_REV);
-		vendor >>= 8;
-		revision = vendor >> ICS932S401_REV_SHIFT;
-		vendor &= ICS932S401_VENDOR_MASK;
-		if (vendor != ICS932S401_VENDOR)
-			return -ENODEV;
-
-		device = i2c_smbus_read_word_data(client,
-						  ICS932S401_REG_DEVICE);
-		device >>= 8;
-		if (device != ICS932S401_DEVICE)
-			return -ENODEV;
-
-		if (revision != ICS932S401_REV)
-			dev_info(&adapter->dev, "Unknown revision %d\n",
-				 revision);
-	} else
-		dev_dbg(&adapter->dev, "detection forced\n");
+	if (revision != ICS932S401_REV)
+		dev_info(&adapter->dev, "Unknown revision %d\n", revision);
 
 	strlcpy(info->type, "ics932s401", I2C_NAME_SIZE);
 

-- 
Jean Delvare
