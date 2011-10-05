From: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 3/7 v2] i2c-eg20t: Separate error processing
Date: Wed,  5 Oct 2011 13:17:40 +0900
Message-ID: <1317788264-13118-3-git-send-email-tomoya-linux@dsn.lapis-semi.com>
References: <1317788264-13118-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1317788264-13118-1-git-send-email-tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, toshiharu-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org, Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Error processing for NACK or wait-event must be precessed separately.
So divide wait-event error processing into NACK-receiving and timeout.
Add arbitration lost processing.

Signed-off-by: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
---
v2: "[PATCH] i2c-eg20t: Separate error processing" was invalid patch.
---
 drivers/i2c/busses/i2c-eg20t.c |  154 +++++++++++++++++++++++++--------------
 1 files changed, 99 insertions(+), 55 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index c18210e..29911c5 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -388,6 +388,7 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 	u32 length;
 	u32 addr;
 	s32 wrcount;
+	s32 rtn;
 	void __iomem *p = adap->pch_base_address;
 
 	length = msgs->len;
@@ -416,30 +417,48 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 	if (first)
 		pch_i2c_start(adap);
 
-	if ((pch_i2c_wait_for_xfer_complete(adap) == 0) &&
-	    (pch_i2c_getack(adap) == 0)) {
-		for (wrcount = 0; wrcount < length; ++wrcount) {
-			/* write buffer value to I2C data register */
-			iowrite32(buf[wrcount], p + PCH_I2CDR);
-			pch_dbg(adap, "writing %x to Data register\n",
-				buf[wrcount]);
+	rtn = pch_i2c_wait_for_xfer_complete(adap);
+	if (rtn == 0) {
+		if (pch_i2c_getack(adap)) {
+			pch_err(adap, "Receive NACK for slave address\
+				setting\n");
+			return -EIO;
+		}
+	} else if (rtn == -EIO) { /* Arbitration Lost */
+		pch_err(adap, "Lost Arbitration\n");
+		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMAL_BIT);
+		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMIF_BIT);
+		return -EAGAIN;
+	} else { /* wait-event timeout */
+		return -ETIME;
+	}
 
-			if (pch_i2c_wait_for_xfer_complete(adap) != 0)
-				return -ETIME;
+	for (wrcount = 0; wrcount < length; ++wrcount) {
+		/* write buffer value to I2C data register */
+		iowrite32(buf[wrcount], p + PCH_I2CDR);
+		pch_dbg(adap, "writing %x to Data register\n", buf[wrcount]);
 
-			if (pch_i2c_getack(adap))
+		rtn = pch_i2c_wait_for_xfer_complete(adap);
+		if (rtn == 0) {
+			if (pch_i2c_getack(adap)) {
+				pch_err(adap, "Receive NACK for slave address\
+					setting\n");
 				return -EIO;
+			}
+			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
+				   I2CMCF_BIT);
+			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
+				   I2CMIF_BIT);
+		} else { /* wait-event timeout */
+			return -ETIME;
 		}
+	}
 
-		/* check if this is the last message */
-		if (last)
-			pch_i2c_stop(adap);
-		else
-			pch_i2c_repstart(adap);
-	} else {
+	/* check if this is the last message */
+	if (last)
 		pch_i2c_stop(adap);
-		return -EIO;
-	}
+	else
+		pch_i2c_repstart(adap);
 
 	pch_dbg(adap, "return=%d\n", wrcount);
 
@@ -485,6 +504,7 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 	u32 length;
 	u32 addr;
 	void __iomem *p = adap->pch_base_address;
+	s32 rtn;
 
 	length = msgs->len;
 	buf = msgs->buf;
@@ -511,56 +531,80 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 	if (first)
 		pch_i2c_start(adap);
 
-	if ((pch_i2c_wait_for_xfer_complete(adap) == 0) &&
-	    (pch_i2c_getack(adap) == 0)) {
-		pch_dbg(adap, "return %d\n", 0);
+	rtn = pch_i2c_wait_for_xfer_complete(adap);
+	if (rtn == 0) {
+		if (pch_i2c_getack(adap)) {
+			pch_err(adap, "Receive NACK for slave address\
+				setting\n");
+			return -EIO;
+		}
+	} else if (rtn == -EIO) { /* Arbitration Lost */
+		pch_err(adap, "Lost Arbitration\n");
+		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMAL_BIT);
+		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMIF_BIT);
+		return -EAGAIN;
+	} else { /* wait-event timeout */
+		pch_i2c_stop(adap);
+		return -ETIME;
+	}
 
-		if (length == 0) {
-			pch_i2c_stop(adap);
-			ioread32(p + PCH_I2CDR); /* Dummy read needs */
+	if (length == 0) {
+		pch_i2c_stop(adap);
+		ioread32(p + PCH_I2CDR); /* Dummy read needs */
 
-			count = length;
-		} else {
-			int read_index;
-			int loop;
-			pch_i2c_sendack(adap);
+		count = length;
+	} else {
+		int read_index;
+		int loop;
+		pch_i2c_sendack(adap);
 
-			/* Dummy read */
-			for (loop = 1, read_index = 0; loop < length; loop++) {
-				buf[read_index] = ioread32(p + PCH_I2CDR);
+		/* Dummy read */
+		for (loop = 1, read_index = 0; loop < length; loop++) {
+			buf[read_index] = ioread32(p + PCH_I2CDR);
 
-				if (loop != 1)
-					read_index++;
+			if (loop != 1)
+				read_index++;
 
-				if (pch_i2c_wait_for_xfer_complete(adap) != 0) {
-					pch_i2c_stop(adap);
-					return -ETIME;
+			rtn = pch_i2c_wait_for_xfer_complete(adap);
+			if (rtn == 0) {
+				if (pch_i2c_getack(adap)) {
+					pch_err(adap, "Receive NACK for slave\
+						address setting\n");
+					return -EIO;
 				}
-			}	/* end for */
+			} else { /* wait-event timeout */
+				pch_i2c_stop(adap);
+				return -ETIME;
+			}
 
-			pch_i2c_sendnack(adap);
+		}	/* end for */
 
-			buf[read_index] = ioread32(p + PCH_I2CDR);
+		pch_i2c_sendnack(adap);
 
-			if (length != 1)
-				read_index++;
+		buf[read_index] = ioread32(p + PCH_I2CDR); /* Read final - 1 */
 
-			if (pch_i2c_wait_for_xfer_complete(adap) == 0) {
-				if (last)
-					pch_i2c_stop(adap);
-				else
-					pch_i2c_repstart(adap);
+		if (length != 1)
+			read_index++;
 
-				buf[read_index++] = ioread32(p + PCH_I2CDR);
-				count = read_index;
-			} else {
-				count = -ETIME;
+		rtn = pch_i2c_wait_for_xfer_complete(adap);
+		if (rtn == 0) {
+			if (pch_i2c_getack(adap)) {
+				pch_err(adap, "Receive NACK for slave\
+					address setting\n");
+				return -EIO;
 			}
-
+		} else { /* wait-event timeout */
+			pch_i2c_stop(adap);
+			return -ETIME;
 		}
-	} else {
-		count = -ETIME;
-		pch_i2c_stop(adap);
+
+		if (last)
+			pch_i2c_stop(adap);
+		else
+			pch_i2c_repstart(adap);
+
+		buf[read_index++] = ioread32(p + PCH_I2CDR); /* Read Final */
+		count = read_index;
 	}
 
 	return count;
-- 
1.7.6.4
