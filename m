From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-algo-bit: Return standard fault codes
Date: Thu, 20 Oct 2011 17:34:51 +0200
Message-ID: <20111020173451.5a6d50c8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Adjust i2c-algo-bit to return fault codes compliant with
Documentation/i2c/fault-codes, rather than the undocumented and
vague -EREMOTEIO.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- linux-3.1-rc10.orig/drivers/i2c/algos/i2c-algo-bit.c	2011-10-20 15:33:11.000000000 +0200
+++ linux-3.1-rc10/drivers/i2c/algos/i2c-algo-bit.c	2011-10-20 17:14:27.000000000 +0200
@@ -447,7 +447,7 @@ static int readbytes(struct i2c_adapter
 					acknak(i2c_adap, 0);
 				dev_err(&i2c_adap->dev, "readbytes: invalid "
 					"block length (%d)\n", inval);
-				return -EREMOTEIO;
+				return -EPROTO;
 			}
 			/* The original count value accounts for the extra
 			   bytes, that is, either 1 for a regular transaction,
@@ -476,7 +476,7 @@ static int readbytes(struct i2c_adapter
  * reads, writes as well as 10bit-addresses.
  * returns:
  *  0 everything went okay, the chip ack'ed, or IGNORE_NAK flag was set
- * -x an error occurred (like: -EREMOTEIO if the device did not answer, or
+ * -x an error occurred (like: -ENXIO if the device did not answer, or
  *	-ETIMEDOUT, for example if the lines are stuck...)
  */
 static int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
@@ -499,14 +499,14 @@ static int bit_doAddress(struct i2c_adap
 		if ((ret != 1) && !nak_ok)  {
 			dev_err(&i2c_adap->dev,
 				"died at extended address code\n");
-			return -EREMOTEIO;
+			return -ENXIO;
 		}
 		/* the remaining 8 bit address */
 		ret = i2c_outb(i2c_adap, msg->addr & 0x7f);
 		if ((ret != 1) && !nak_ok) {
 			/* the chip did not ack / xmission error occurred */
 			dev_err(&i2c_adap->dev, "died at 2nd address code\n");
-			return -EREMOTEIO;
+			return -ENXIO;
 		}
 		if (flags & I2C_M_RD) {
 			bit_dbg(3, &i2c_adap->dev, "emitting repeated "
@@ -518,7 +518,7 @@ static int bit_doAddress(struct i2c_adap
 			if ((ret != 1) && !nak_ok) {
 				dev_err(&i2c_adap->dev,
 					"died at repeated address code\n");
-				return -EREMOTEIO;
+				return -EIO;
 			}
 		}
 	} else {		/* normal 7bit address	*/
@@ -576,7 +576,7 @@ static int bit_xfer(struct i2c_adapter *
 					ret, ret == 1 ? "" : "s");
 			if (ret < pmsg->len) {
 				if (ret >= 0)
-					ret = -EREMOTEIO;
+					ret = -EIO;
 				goto bailout;
 			}
 		} else {
@@ -587,7 +587,7 @@ static int bit_xfer(struct i2c_adapter *
 					ret, ret == 1 ? "" : "s");
 			if (ret < pmsg->len) {
 				if (ret >= 0)
-					ret = -EREMOTEIO;
+					ret = -EIO;
 				goto bailout;
 			}
 		}


-- 
Jean Delvare
