From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-algo-pca: Return standard fault codes
Date: Thu, 20 Oct 2011 17:36:48 +0200
Message-ID: <20111020173648.28448861@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Adjust i2c-algo-pca to return fault codes compliant with
Documentation/i2c/fault-codes, rather than the undocumented and
vague -EREMOTEIO.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Wolfram, could you please test this patch and confirm it works OK for
you? Tools like i2cdetect should behave much better with it.

 drivers/i2c/algos/i2c-algo-pca.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-3.1-rc10.orig/drivers/i2c/algos/i2c-algo-pca.c	2011-07-22 04:17:23.000000000 +0200
+++ linux-3.1-rc10/drivers/i2c/algos/i2c-algo-pca.c	2011-10-20 17:25:23.000000000 +0200
@@ -196,7 +196,7 @@ static int pca_xfer(struct i2c_adapter *
 		} else {
 			dev_dbg(&i2c_adap->dev, "bus is not idle. status is "
 				"%#04x\n", state);
-			return -EAGAIN;
+			return -EBUSY;
 		}
 	}
 
@@ -224,7 +224,7 @@ static int pca_xfer(struct i2c_adapter *
 	}
 
 	curmsg = 0;
-	ret = -EREMOTEIO;
+	ret = -EIO;
 	while (curmsg < num) {
 		state = pca_status(adap);
 
@@ -259,6 +259,7 @@ static int pca_xfer(struct i2c_adapter *
 		case 0x20: /* SLA+W has been transmitted; NOT ACK has been received */
 			DEB2("NOT ACK received after SLA+W\n");
 			pca_stop(adap);
+			ret = -ENXIO;
 			goto out;
 
 		case 0x40: /* SLA+R has been transmitted; ACK has been received */
@@ -283,6 +284,7 @@ static int pca_xfer(struct i2c_adapter *
 		case 0x48: /* SLA+R has been transmitted; NOT ACK has been received */
 			DEB2("NOT ACK received after SLA+R\n");
 			pca_stop(adap);
+			ret = -ENXIO;
 			goto out;
 
 		case 0x30: /* Data byte in I2CDAT has been transmitted; NOT ACK has been received */


-- 
Jean Delvare
