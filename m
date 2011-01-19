From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] i2c: Fix error return codes
Date: Wed, 19 Jan 2011 13:14:53 -0800
Message-ID: <1295471693-463-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vincent Sanders <support-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

EREMOTEIO is not a valid error return code for I2C drivers. Replace with error
codes per Documentation/i2c/fault-codes.

Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c    |   14 +++++++-------
 drivers/i2c/algos/i2c-algo-pca.c    |    2 +-
 drivers/i2c/algos/i2c-algo-pcf.c    |    8 ++++----
 drivers/i2c/busses/i2c-cpm.c        |    6 +++---
 drivers/i2c/busses/i2c-davinci.c    |    4 ++--
 drivers/i2c/busses/i2c-designware.c |    2 +-
 drivers/i2c/busses/i2c-ibm_iic.c    |   10 +++++-----
 drivers/i2c/busses/i2c-nuc900.c     |    2 +-
 drivers/i2c/busses/i2c-omap.c       |    2 +-
 drivers/i2c/busses/i2c-pnx.c        |    2 +-
 drivers/i2c/busses/i2c-pxa.c        |    4 ++--
 drivers/i2c/busses/i2c-s3c2410.c    |    2 +-
 drivers/i2c/busses/i2c-sh7760.c     |    4 ++--
 drivers/i2c/busses/i2c-tiny-usb.c   |    8 ++++----
 14 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 38319a6..b364d15 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -425,7 +425,7 @@ static int readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
 					acknak(i2c_adap, 0);
 				dev_err(&i2c_adap->dev, "readbytes: invalid "
 					"block length (%d)\n", inval);
-				return -EREMOTEIO;
+				return -EPROTO;
 			}
 			/* The original count value accounts for the extra
 			   bytes, that is, either 1 for a regular transaction,
@@ -454,7 +454,7 @@ static int readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
  * reads, writes as well as 10bit-addresses.
  * returns:
  *  0 everything went okay, the chip ack'ed, or IGNORE_NAK flag was set
- * -x an error occurred (like: -EREMOTEIO if the device did not answer, or
+ * -x an error occurred (like: -ENXIO if the device did not answer, or
  *	-ETIMEDOUT, for example if the lines are stuck...)
  */
 static int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
@@ -477,14 +477,14 @@ static int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
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
@@ -496,7 +496,7 @@ static int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
 			if ((ret != 1) && !nak_ok) {
 				dev_err(&i2c_adap->dev,
 					"died at repeated address code\n");
-				return -EREMOTEIO;
+				return -ENXIO;
 			}
 		}
 	} else {		/* normal 7bit address	*/
@@ -554,7 +554,7 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
 					ret, ret == 1 ? "" : "s");
 			if (ret < pmsg->len) {
 				if (ret >= 0)
-					ret = -EREMOTEIO;
+					ret = -EPROTO;
 				goto bailout;
 			}
 		} else {
@@ -565,7 +565,7 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
 					ret, ret == 1 ? "" : "s");
 			if (ret < pmsg->len) {
 				if (ret >= 0)
-					ret = -EREMOTEIO;
+					ret = -EPROTO;
 				goto bailout;
 			}
 		}
diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index 2b9a8f5..1bcfb78 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -224,7 +224,7 @@ static int pca_xfer(struct i2c_adapter *i2c_adap,
 	}
 
 	curmsg = 0;
-	ret = -EREMOTEIO;
+	ret = -EIO;
 	while (curmsg < num) {
 		state = pca_status(adap);
 
diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 5eebf56..687f52f 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -233,12 +233,12 @@ static int pcf_sendbytes(struct i2c_adapter *i2c_adap, const char *buf,
 
 			i2c_stop(adap);
 			dev_err(&i2c_adap->dev, "i2c_write: error - timeout.\n");
-			return -EREMOTEIO; /* got a better one ?? */
+			return -ETIMEDOUT;
 		}
 		if (status & I2C_PCF_LRB) {
 			i2c_stop(adap);
 			dev_err(&i2c_adap->dev, "i2c_write: error - no ack.\n");
-			return -EREMOTEIO; /* got a better one ?? */
+			return -ENXIO;
 		}
 	}
 	if (last)
@@ -354,7 +354,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 			i2c_stop(adap);
 			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: Timeout waiting "
 				    "for PIN(1) in pcf_xfer\n");)
-			i = -EREMOTEIO;
+			i = -ETIMEDOUT;
 			goto out;
 		}
 
@@ -362,7 +362,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		if (status & I2C_PCF_LRB) {
 			i2c_stop(adap);
 			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
-			i = -EREMOTEIO;
+			i = -ENXIO;
 			goto out;
 		}
 
diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index f2de3be..438e3e9 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -279,11 +279,11 @@ static int cpm_i2c_check_message(struct i2c_adapter *adap,
 		if (in_be16(&rbdf->cbd_sc) & BD_SC_EMPTY) {
 			dev_err(&adap->dev,
 				"I2C read; complete but rbuf empty\n");
-			return -EREMOTEIO;
+			return -EPROTO;
 		}
 		if (in_be16(&rbdf->cbd_sc) & BD_SC_OV) {
 			dev_err(&adap->dev, "I2C read; Overrun\n");
-			return -EREMOTEIO;
+			return -EIO;
 		}
 		memcpy(pmsg->buf, rb, pmsg->len);
 	} else {
@@ -373,7 +373,7 @@ static int cpm_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 				!(in_be16(&tbdf[tptr].cbd_sc) & BD_SC_READY),
 				1 * HZ);
 		if (ret == 0) {
-			ret = -EREMOTEIO;
+			ret = -ETIMEDOUT;
 			dev_err(&adap->dev, "I2C transfer: timeout\n");
 			goto out_err;
 		}
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 5795c83..99dd08c 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -394,7 +394,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 		if (r >= 0) {
 			dev_err(dev->dev, "abnormal termination buf_len=%i\n",
 				dev->buf_len);
-			r = -EREMOTEIO;
+			r = -EIO;
 		}
 		dev->terminate = 1;
 		wmb();
@@ -421,7 +421,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 			w |= DAVINCI_I2C_MDR_STP;
 			davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
 		}
-		return -EREMOTEIO;
+		return -ENXIO;
 	}
 	return -EIO;
 }
diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index b664ed8..1c6e107 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -501,7 +501,7 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 		for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
 			dev_dbg(dev->dev,
 				"%s: %s\n", __func__, abort_sources[i]);
-		return -EREMOTEIO;
+		return -ENXIO;
 	}
 
 	for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 6e3c382..189b42e 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -291,7 +291,7 @@ static int iic_smbus_quick(struct ibm_iic_private* dev, const struct i2c_msg* p)
 	out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
 	if (unlikely(iic_dc_wait(iic, DIRCNTL_MSC)))
 		goto err;
-	res = (in_8(&iic->directcntl) & DIRCNTL_MSDA) ? -EREMOTEIO : 1;
+	res = (in_8(&iic->directcntl) & DIRCNTL_MSDA) ? -EIO : 1;
 	ndelay(t->high);
 
 	/* STOP */
@@ -316,7 +316,7 @@ out:
 	return res;
 err:
 	DBG("%d: smbus_quick - bus is stuck\n", dev->idx);
-	res = -EREMOTEIO;
+	res = -EIO;
 	goto out;
 }
 
@@ -366,7 +366,7 @@ static int iic_xfer_result(struct ibm_iic_private* dev)
 			DBG("%d: bus is stuck, resetting\n", dev->idx);
 			iic_dev_reset(dev);
 		}
-		return -EREMOTEIO;
+		return -EIO;
 	}
 	else
 		return in_8(&iic->xfrcnt) & XFRCNT_MTC_MASK;
@@ -501,7 +501,7 @@ static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
 			if (combined_xfer || (i < loops - 1))
     				iic_abort_xfer(dev);
 
-			ret = -EREMOTEIO;
+			ret = -EPROTO;
 			break;
 		}
 
@@ -605,7 +605,7 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
 			DBG("%d: iic_xfer, bus is still not free\n", dev->idx);
-			return -EREMOTEIO;
+			return -EIO;
 		}
 	}
 	else {
diff --git a/drivers/i2c/busses/i2c-nuc900.c b/drivers/i2c/busses/i2c-nuc900.c
index 7243426..1bee600 100644
--- a/drivers/i2c/busses/i2c-nuc900.c
+++ b/drivers/i2c/busses/i2c-nuc900.c
@@ -496,7 +496,7 @@ static int nuc900_i2c_xfer(struct i2c_adapter *adap,
 		udelay(100);
 	}
 
-	return -EREMOTEIO;
+	return -ETIMEDOUT;
 }
 
 /* declare our i2c functionality */
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b605ff3..6c21024 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -627,7 +627,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 			w |= OMAP_I2C_CON_STP;
 			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 		}
-		return -EREMOTEIO;
+		return -ENXIO;
 	}
 	return -EIO;
 }
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index a97e3fe..3a98ba6 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -525,7 +525,7 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		__func__, ioread32(I2C_REG_STS(alg_data)));
 
 	if (completed != num)
-		return ((rc < 0) ? rc : -EREMOTEIO);
+		return ((rc < 0) ? rc : -EPROTO);
 
 	return num;
 }
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index f4c19a9..c085a17 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -759,7 +759,7 @@ static int i2c_pxa_pio_xfer(struct i2c_adapter *adap,
 		udelay(100);
 	}
 	i2c_pxa_scream_blue_murder(i2c, "exhausted retries");
-	ret = -EREMOTEIO;
+	ret = -ETIMEDOUT;
  out:
 	i2c_pxa_set_slave(i2c, ret);
 	return ret;
@@ -974,7 +974,7 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
 		udelay(100);
 	}
 	i2c_pxa_scream_blue_murder(i2c, "exhausted retries");
-	ret = -EREMOTEIO;
+	ret = -ETIMEDOUT;
  out:
 	i2c_pxa_set_slave(i2c, ret);
 	return ret;
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 6c00c10..75dda8c 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -571,7 +571,7 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
 	}
 
 	clk_disable(i2c->clk);
-	return -EREMOTEIO;
+	return -ETIMEDOUT;
 }
 
 /* declare our i2c functionality */
diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index 3cad8fe..c9b1f01 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -336,7 +336,7 @@ retry:
 		if (id->status & IDS_NACK) {
 			/* wait a bit or i2c module stops working */
 			mdelay(1);
-			num = -EREMOTEIO;
+			num = -ENXIO;
 			break;
 		}
 
@@ -345,7 +345,7 @@ retry:
 				mdelay(2);
 				goto retry;
 			}
-			num = -EREMOTEIO;
+			num = -ETIMEDOUT;
 			break;
 		}
 
diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index d03b040..cac7ec6 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -84,7 +84,7 @@ static int usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
 				     pmsg->buf, pmsg->len) != pmsg->len) {
 				dev_err(&adapter->dev,
 					"failure reading data\n");
-				return -EREMOTEIO;
+				return -EIO;
 			}
 		} else {
 			/* write data */
@@ -93,19 +93,19 @@ static int usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
 				      pmsg->buf, pmsg->len) != pmsg->len) {
 				dev_err(&adapter->dev,
 					"failure writing data\n");
-				return -EREMOTEIO;
+				return -EIO;
 			}
 		}
 
 		/* read status */
 		if (usb_read(adapter, CMD_GET_STATUS, 0, 0, &status, 1) != 1) {
 			dev_err(&adapter->dev, "failure reading status\n");
-			return -EREMOTEIO;
+			return -EIO;
 		}
 
 		dev_dbg(&adapter->dev, "  status = %d\n", status);
 		if (status == STATUS_ADDRESS_NAK)
-			return -EREMOTEIO;
+			return -ENXIO;
 	}
 
 	return i;
-- 
1.7.3.1
