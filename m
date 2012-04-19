From: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] i2c-eg20t: add helper function for xfer check
Date: Thu, 19 Apr 2012 15:38:04 +0900
Message-ID: <1334817485-7121-1-git-send-email-tomoya.rohm@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Currently, there are the same code for xfer complete check processing.
So, I add helper function pch_i2c_wait_for_check_xfer.

Reported-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |  226 ++++++++++++----------------------------
 1 files changed, 66 insertions(+), 160 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index ca9e579..72bd23c 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -366,6 +366,34 @@ static void pch_i2c_stop(struct i2c_algo_pch_data *adap)
 	pch_clrbit(adap->pch_base_address, PCH_I2CCTL, PCH_START);
 }
 
+static int pch_i2c_wait_for_check_xfer(struct i2c_algo_pch_data *adap)
+{
+	int rtn;
+
+	rtn = pch_i2c_wait_for_xfer_complete(adap);
+	if (rtn == 0) {
+		if (pch_i2c_getack(adap)) {
+			pch_dbg(adap, "Receive NACK for slave address"
+				"setting\n");
+			return -EIO;
+		}
+	} else if (rtn == -EIO) { /* Arbitration Lost */
+		pch_err(adap, "Lost Arbitration\n");
+		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMAL_BIT);
+		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMIF_BIT);
+		pch_i2c_init(adap);
+		return -EAGAIN;
+	} else { /* wait-event timeout */
+		pch_err(adap, "%s(L.%d):wait-event timeout\n",
+			__func__, __LINE__);
+		pch_i2c_stop(adap);
+		pch_i2c_init(adap);
+		return -ETIME;
+	}
+
+	return 0;
+}
+
 /**
  * pch_i2c_repstart() - generate repeated start condition in normal mode
  * @adap:	Pointer to struct i2c_algo_pch_data.
@@ -420,30 +448,12 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 		if (first)
 			pch_i2c_start(adap);
 
-		rtn = pch_i2c_wait_for_xfer_complete(adap);
-		if (rtn == 0) {
-			if (pch_i2c_getack(adap)) {
-				pch_dbg(adap, "Receive NACK for slave address"
-					"setting\n");
-				return -EIO;
-			}
-			addr_8_lsb = (addr & I2C_ADDR_MSK);
-			iowrite32(addr_8_lsb, p + PCH_I2CDR);
-		} else if (rtn == -EIO) { /* Arbitration Lost */
-			pch_err(adap, "Lost Arbitration\n");
-			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
-				   I2CMAL_BIT);
-			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
-				   I2CMIF_BIT);
-			pch_i2c_init(adap);
-			return -EAGAIN;
-		} else { /* wait-event timeout */
-			pch_err(adap, "%s(L.%d):wait-event timeout\n",
-				__func__, __LINE__);
-			pch_i2c_stop(adap);
-			pch_i2c_init(adap);
-			return -ETIME;
-		}
+		rtn = pch_i2c_wait_for_check_xfer(adap);
+		if (rtn)
+			return rtn;
+
+		addr_8_lsb = (addr & I2C_ADDR_MSK);
+		iowrite32(addr_8_lsb, p + PCH_I2CDR);
 	} else {
 		/* set 7 bit slave address and R/W bit as 0 */
 		iowrite32(addr << 1, p + PCH_I2CDR);
@@ -451,50 +461,21 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 			pch_i2c_start(adap);
 	}
 
-	rtn = pch_i2c_wait_for_xfer_complete(adap);
-	if (rtn == 0) {
-		if (pch_i2c_getack(adap)) {
-			pch_dbg(adap, "Receive NACK for slave address"
-				"setting\n");
-			return -EIO;
-		}
-	} else if (rtn == -EIO) { /* Arbitration Lost */
-		pch_err(adap, "Lost Arbitration\n");
-		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMAL_BIT);
-		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMIF_BIT);
-		pch_i2c_init(adap);
-		return -EAGAIN;
-	} else { /* wait-event timeout */
-		pch_err(adap, "%s(L.%d):wait-event timeout\n",
-			__func__, __LINE__);
-		pch_i2c_stop(adap);
-		pch_i2c_init(adap);
-		return -ETIME;
-	}
+	rtn = pch_i2c_wait_for_check_xfer(adap);
+	if (rtn)
+		return rtn;
 
 	for (wrcount = 0; wrcount < length; ++wrcount) {
 		/* write buffer value to I2C data register */
 		iowrite32(buf[wrcount], p + PCH_I2CDR);
 		pch_dbg(adap, "writing %x to Data register\n", buf[wrcount]);
 
-		rtn = pch_i2c_wait_for_xfer_complete(adap);
-		if (rtn == 0) {
-			if (pch_i2c_getack(adap)) {
-				pch_dbg(adap, "Receive NACK for slave address"
-					"setting\n");
-				return -EIO;
-			}
-			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
-				   I2CMCF_BIT);
-			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
-				   I2CMIF_BIT);
-		} else { /* wait-event timeout */
-			pch_err(adap, "%s(L.%d):wait-event timeout\n",
-				__func__, __LINE__);
-			pch_i2c_stop(adap);
-			pch_i2c_init(adap);
-			return -ETIME;
-		}
+		rtn = pch_i2c_wait_for_check_xfer(adap);
+		if (rtn)
+			return rtn;
+
+		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMCF_BIT);
+		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMIF_BIT);
 	}
 
 	/* check if this is the last message */
@@ -582,56 +563,21 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 		if (first)
 			pch_i2c_start(adap);
 
-		rtn = pch_i2c_wait_for_xfer_complete(adap);
-		if (rtn == 0) {
-			if (pch_i2c_getack(adap)) {
-				pch_dbg(adap, "Receive NACK for slave address"
-					"setting\n");
-				return -EIO;
-			}
-			addr_8_lsb = (addr & I2C_ADDR_MSK);
-			iowrite32(addr_8_lsb, p + PCH_I2CDR);
-		} else if (rtn == -EIO) { /* Arbitration Lost */
-			pch_err(adap, "Lost Arbitration\n");
-			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
-				   I2CMAL_BIT);
-			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
-				   I2CMIF_BIT);
-			pch_i2c_init(adap);
-			return -EAGAIN;
-		} else { /* wait-event timeout */
-			pch_err(adap, "%s(L.%d):wait-event timeout\n",
-				__func__, __LINE__);
-			pch_i2c_stop(adap);
-			pch_i2c_init(adap);
-			return -ETIME;
-		}
+		rtn = pch_i2c_wait_for_check_xfer(adap);
+		if (rtn)
+			return rtn;
+
+		addr_8_lsb = (addr & I2C_ADDR_MSK);
+		iowrite32(addr_8_lsb, p + PCH_I2CDR);
+
 		pch_i2c_restart(adap);
-		rtn = pch_i2c_wait_for_xfer_complete(adap);
-		if (rtn == 0) {
-			if (pch_i2c_getack(adap)) {
-				pch_dbg(adap, "Receive NACK for slave address"
-					"setting\n");
-				return -EIO;
-			}
-			addr_2_msb |= I2C_RD;
-			iowrite32(addr_2_msb | TEN_BIT_ADDR_MASK,
-				  p + PCH_I2CDR);
-		} else if (rtn == -EIO) { /* Arbitration Lost */
-			pch_err(adap, "Lost Arbitration\n");
-			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
-				   I2CMAL_BIT);
-			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
-				   I2CMIF_BIT);
-			pch_i2c_init(adap);
-			return -EAGAIN;
-		} else { /* wait-event timeout */
-			pch_err(adap, "%s(L.%d):wait-event timeout\n",
-				__func__, __LINE__);
-			pch_i2c_stop(adap);
-			pch_i2c_init(adap);
-			return -ETIME;
-		}
+
+		rtn = pch_i2c_wait_for_check_xfer(adap);
+		if (rtn)
+			return rtn;
+
+		addr_2_msb |= I2C_RD;
+		iowrite32(addr_2_msb | TEN_BIT_ADDR_MASK, p + PCH_I2CDR);
 	} else {
 		/* 7 address bits + R/W bit */
 		addr = (((addr) << 1) | (I2C_RD));
@@ -642,26 +588,9 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 	if (first)
 		pch_i2c_start(adap);
 
-	rtn = pch_i2c_wait_for_xfer_complete(adap);
-	if (rtn == 0) {
-		if (pch_i2c_getack(adap)) {
-			pch_dbg(adap, "Receive NACK for slave address"
-				"setting\n");
-			return -EIO;
-		}
-	} else if (rtn == -EIO) { /* Arbitration Lost */
-		pch_err(adap, "Lost Arbitration\n");
-		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMAL_BIT);
-		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMIF_BIT);
-		pch_i2c_init(adap);
-		return -EAGAIN;
-	} else { /* wait-event timeout */
-		pch_err(adap, "%s(L.%d):wait-event timeout\n",
-			__func__, __LINE__);
-		pch_i2c_stop(adap);
-		pch_i2c_init(adap);
-		return -ETIME;
-	}
+	rtn = pch_i2c_wait_for_check_xfer(adap);
+	if (rtn)
+		return rtn;
 
 	if (length == 0) {
 		pch_i2c_stop(adap);
@@ -680,21 +609,9 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 			if (loop != 1)
 				read_index++;
 
-			rtn = pch_i2c_wait_for_xfer_complete(adap);
-			if (rtn == 0) {
-				if (pch_i2c_getack(adap)) {
-					pch_dbg(adap, "Receive NACK for slave"
-						"address setting\n");
-					return -EIO;
-				}
-			} else { /* wait-event timeout */
-				pch_err(adap, "%s(L.%d):wait-event timeout\n",
-					__func__, __LINE__);
-				pch_i2c_stop(adap);
-				pch_i2c_init(adap);
-				return -ETIME;
-			}
-
+			rtn = pch_i2c_wait_for_check_xfer(adap);
+			if (rtn)
+				return rtn;
 		}	/* end for */
 
 		pch_i2c_sendnack(adap);
@@ -704,20 +621,9 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 		if (length != 1)
 			read_index++;
 
-		rtn = pch_i2c_wait_for_xfer_complete(adap);
-		if (rtn == 0) {
-			if (pch_i2c_getack(adap)) {
-				pch_dbg(adap, "Receive NACK for slave"
-					"address setting\n");
-				return -EIO;
-			}
-		} else { /* wait-event timeout */
-			pch_err(adap, "%s(L.%d):wait-event timeout\n",
-				__func__, __LINE__);
-			pch_i2c_stop(adap);
-			pch_i2c_init(adap);
-			return -ETIME;
-		}
+		rtn = pch_i2c_wait_for_check_xfer(adap);
+		if (rtn)
+			return rtn;
 
 		if (last)
 			pch_i2c_stop(adap);
-- 
1.7.4.4
