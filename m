From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c: Fix probing of FSC hardware monitoring chips
Date: Wed, 7 Apr 2010 14:04:55 +0200
Message-ID: <20100407140455.1eadb745@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Some FSC hardware monitoring chips (Syleus at least) doesn't like
quick writes we typically use to probe for I2C chips. Use a regular
byte read instead for the address they live at (0x73). These are the
only known chips living at this address on PC systems.

For clarity, this fix should not be needed for kernels 2.6.30 and
later, as we started instantiating the hwmon devices explicitly based
on DMI data. Still, this fix is valuable in the following two cases:
* Support for recent FSC chips on older kernels. The DMI-based device
  instantiation is more difficult to backport than the device support
  itself.
* Case where the DMI-based device instantiation fails, whatever the
  reason. We fall back to probing in that case, so it should work.

This fixes kernel bug #15634:
https://bugzilla.kernel.org/show_bug.cgi?id=15634

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- linux-2.6.34-rc3.orig/drivers/i2c/i2c-core.c	2010-04-07 09:03:30.000000000 +0200
+++ linux-2.6.34-rc3/drivers/i2c/i2c-core.c	2010-04-07 13:45:28.000000000 +0200
@@ -1264,12 +1264,23 @@ static int i2c_detect_address(struct i2c
 		return 0;
 
 	/* Make sure there is something at this address */
-	if (i2c_smbus_xfer(adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) < 0)
-		return 0;
+	if (addr == 0x73 && (adapter->class & I2C_CLASS_HWMON)) {
+		/* Special probe for FSC hwmon chips */
+		union i2c_smbus_data dummy;
+
+		if (i2c_smbus_xfer(adapter, addr, 0, I2C_SMBUS_READ, 0,
+				   I2C_SMBUS_BYTE_DATA, &dummy) < 0)
+			return 0;
+	} else {
+		if (i2c_smbus_xfer(adapter, addr, 0, I2C_SMBUS_WRITE, 0,
+				   I2C_SMBUS_QUICK, NULL) < 0)
+			return 0;
 
-	/* Prevent 24RF08 corruption */
-	if ((addr & ~0x0f) == 0x50)
-		i2c_smbus_xfer(adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL);
+		/* Prevent 24RF08 corruption */
+		if ((addr & ~0x0f) == 0x50)
+			i2c_smbus_xfer(adapter, addr, 0, I2C_SMBUS_WRITE, 0,
+				       I2C_SMBUS_QUICK, NULL);
+	}
 
 	/* Finally call the custom detection function */
 	memset(&info, 0, sizeof(struct i2c_board_info));


-- 
Jean Delvare
