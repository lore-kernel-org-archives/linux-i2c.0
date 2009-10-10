From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] i2c-powermac: Log errors
Date: Sat, 10 Oct 2009 14:20:28 +0200
Message-ID: <20091010142028.52f19518@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Log errors when they happen, otherwise we have no idea what went
wrong.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/busses/i2c-powermac.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/i2c/busses/i2c-powermac.c	2009-10-10 14:13:04.000000000 +0200
+++ linux-2.6.32-rc3/drivers/i2c/busses/i2c-powermac.c	2009-10-10 14:13:12.000000000 +0200
@@ -108,16 +108,25 @@ static s32 i2c_powermac_smbus_xfer(	stru
 	}
 
 	rc = pmac_i2c_open(bus, 0);
-	if (rc)
+	if (rc) {
+		dev_err(&adap->dev, "Failed to open I2C, err %d\n", rc);
 		return rc;
+	}
 
 	rc = pmac_i2c_setmode(bus, mode);
-	if (rc)
+	if (rc) {
+		dev_err(&adap->dev, "Failed to set I2C mode %d, err %d\n",
+			mode, rc);
 		goto bail;
+	}
 
 	rc = pmac_i2c_xfer(bus, addrdir, subsize, subaddr, buf, len);
-	if (rc)
+	if (rc) {
+		dev_err(&adap->dev,
+			"I2C transfer at 0x%02x failed, size %d, err %d\n",
+			addrdir >> 1, size, rc);
 		goto bail;
+	}
 
 	if (size == I2C_SMBUS_WORD_DATA && read) {
 		data->word = ((u16)local[1]) << 8;
@@ -157,12 +166,21 @@ static int i2c_powermac_master_xfer(	str
 		addrdir ^= 1;
 
 	rc = pmac_i2c_open(bus, 0);
-	if (rc)
+	if (rc) {
+		dev_err(&adap->dev, "Failed to open I2C, err %d\n", rc);
 		return rc;
+	}
 	rc = pmac_i2c_setmode(bus, pmac_i2c_mode_std);
-	if (rc)
+	if (rc) {
+		dev_err(&adap->dev, "Failed to set I2C mode %d, err %d\n",
+			pmac_i2c_mode_std, rc);
 		goto bail;
+	}
 	rc = pmac_i2c_xfer(bus, addrdir, 0, 0, msgs->buf, msgs->len);
+	if (rc < 0)
+		dev_err(&adap->dev, "I2C %s 0x%02x failed, err %d\n",
+			addrdir & 1 ? "read from" : "write to", addrdir >> 1,
+			rc);
  bail:
 	pmac_i2c_close(bus);
 	return rc < 0 ? rc : 1;


-- 
Jean Delvare
