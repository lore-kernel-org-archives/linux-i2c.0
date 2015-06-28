From: David Kessler <djkessler-BUHhN+a2lJ4@public.gmane.org>
Subject: [PATCH] i2c-pnx: Adds support for repeated start i2c transactions
Date: Sat, 27 Jun 2015 20:08:53 -0400
Message-ID: <1435450133-7711-1-git-send-email-DJKessler@me.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Kessler <djkessler-BUHhN+a2lJ4@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sean Horton <seanhorton87-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c-pnx driver implements the i2c specification incorrectly. The
specification allows for 'repeated start' transactions in which the i2c
master generates two start conditions without generating a stop condition in
between them. However, the i2c-pnx driver always generates a stop condition
after every start condition. This patch correctly implements repeated start
transactions.
---
 drivers/i2c/busses/i2c-pnx.c | 88 ++++++++++++++++++++++++++++++++++----------
 include/linux/i2c-pnx.h      |  2 +
 2 files changed, 71 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index e814a36..7bac253 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -139,20 +139,24 @@ static int i2c_pnx_start(unsigned char slave_addr,
 	}
 
 	/* First, make sure bus is idle */
-	if (wait_timeout(alg_data)) {
-		/* Somebody else is monopolizing the bus */
-		dev_err(&alg_data->adapter.dev,
-			"%s: Bus busy. Slave addr = %02x, cntrl = %x, stat = %x\n",
-			alg_data->adapter.name, slave_addr,
-			ioread32(I2C_REG_CTL(alg_data)),
-			ioread32(I2C_REG_STS(alg_data)));
-		return -EBUSY;
-	} else if (ioread32(I2C_REG_STS(alg_data)) & mstatus_afi) {
-		/* Sorry, we lost the bus */
-		dev_err(&alg_data->adapter.dev,
-		        "%s: Arbitration failure. Slave addr = %02x\n",
-			alg_data->adapter.name, slave_addr);
-		return -EIO;
+	if (!alg_data->write_start_read) {
+		if (wait_timeout(alg_data)) {
+			/* Somebody else is monopolizing the bus */
+			dev_err(&alg_data->adapter.dev,
+					"%s: Bus busy. Slave addr = %02x, cntrl = %x, stat = %x\n",
+					alg_data->adapter.name, slave_addr,
+					ioread32(I2C_REG_CTL(alg_data)),
+					ioread32(I2C_REG_STS(alg_data)));
+			return -EBUSY;
+		} else if (ioread32(I2C_REG_STS(alg_data)) & mstatus_afi) {
+			/* Sorry, we lost the bus */
+			dev_err(&alg_data->adapter.dev,
+					"%s: Arbitration failure. Slave addr = %02x\n",
+					alg_data->adapter.name, slave_addr);
+			return -EIO;
+		}
+	} else {
+		alg_data->write_start_read = 0;
 	}
 
 	/*
@@ -168,6 +172,9 @@ static int i2c_pnx_start(unsigned char slave_addr,
 	/* Write the slave address, START bit and R/W bit */
 	iowrite32((slave_addr << 1) | start_bit | alg_data->mif.mode,
 		  I2C_REG_TX(alg_data));
+	iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_afie | mcntrl_naie |
+			(alg_data->write_start_read ? 0 : mcntrl_drmie),
+		  I2C_REG_CTL(alg_data));
 
 	dev_dbg(&alg_data->adapter.dev, "%s(): exit\n", __func__);
 
@@ -220,8 +227,14 @@ static int i2c_pnx_master_xmit(struct i2c_pnx_algo_data *alg_data)
 		/* We still have something to talk about... */
 		val = *alg_data->mif.buf++;
 
-		if (alg_data->mif.len == 1)
+		if (alg_data->mif.len == 1 && !(alg_data->repeated_start)) {
+			alg_data->write_start_read = 0;
 			val |= stop_bit;
+		} else if (alg_data->mif.len == 1) {
+			alg_data->write_start_read = 1;
+		} else {
+			alg_data->write_start_read = 0;
+		}
 
 		alg_data->mif.len--;
 		iowrite32(val, I2C_REG_TX(alg_data));
@@ -281,7 +294,7 @@ static int i2c_pnx_master_xmit(struct i2c_pnx_algo_data *alg_data)
  */
 static int i2c_pnx_master_rcv(struct i2c_pnx_algo_data *alg_data)
 {
-	unsigned int val = 0;
+	unsigned int val = 0xFF;
 	u32 ctl = 0;
 
 	dev_dbg(&alg_data->adapter.dev, "%s(): entering: stat = %04x.\n",
@@ -467,6 +480,11 @@ static inline void bus_reset_if_active(struct i2c_pnx_algo_data *alg_data)
 			alg_data->adapter.name);
 		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_reset,
 			  I2C_REG_CTL(alg_data));
+
+		dev_dbg(&alg_data->adapter.dev,
+			  "%s: Resetting bus\n", __func__);
+		iowrite32(0xff | start_bit, I2C_REG_TX(alg_data));
+
 		wait_reset(alg_data);
 	} else if (!(stat & mstatus_rfe) || !(stat & mstatus_tfe)) {
 		/* If there is data in the fifo's after transfer,
@@ -482,6 +500,32 @@ static inline void bus_reset_if_active(struct i2c_pnx_algo_data *alg_data)
 	}
 }
 
+static inline void
+setup_repeated_start(struct i2c_adapter *adap, struct i2c_msg *msgs, int num) {
+	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
+
+	if (1 < num && !(msgs[0].flags) && ((msgs[1].flags) & I2C_M_RD)) {
+		alg_data->repeated_start = 1;
+		dev_dbg(&adap->dev,
+			"%s(): repeated start\n", __func__);
+	} else if (1 < num) {
+		alg_data->repeated_start = 0;
+		dev_dbg(&adap->dev,
+			"%s(): non-repeated start\n", __func__);
+	} else if (1 < msgs[0].len) {
+		alg_data->repeated_start = 0;
+		if (!msgs[0].flags) {
+			dev_dbg(&adap->dev,
+				"%s(): multi-byte write\n", __func__);
+		} else {
+			dev_dbg(&adap->dev,
+				"%s(): multi-byte read\n", __func__);
+		}
+	} else {
+		alg_data->repeated_start = 0;
+	}
+}
+
 /**
  * i2c_pnx_xfer - generic transfer entry point
  * @adap:		pointer to I2C adapter structure
@@ -504,6 +548,9 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 	bus_reset_if_active(alg_data);
 
+	setup_repeated_start(adap, msgs, num);
+	alg_data->write_start_read = 0;
+
 	/* Process transactions in a loop. */
 	for (i = 0; rc >= 0 && i < num; i++) {
 		u8 addr;
@@ -527,8 +574,10 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		alg_data->mif.ret = 0;
 		alg_data->last = (i == num - 1);
 
-		dev_dbg(&alg_data->adapter.dev, "%s(): mode %d, %d bytes\n",
-			__func__, alg_data->mif.mode, alg_data->mif.len);
+		dev_dbg(&alg_data->adapter.dev, "%s(): mode %s, %d bytes\n",
+			__func__,
+			(alg_data->mif.mode == I2C_SMBUS_READ ? "R" : "W"),
+			alg_data->mif.len);
 
 		i2c_pnx_arm_timer(alg_data);
 
@@ -537,7 +586,8 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 		/* Enable master interrupt */
 		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_afie |
-				mcntrl_naie | mcntrl_drmie,
+				mcntrl_naie |
+				(alg_data->write_start_read ? 0 : mcntrl_drmie),
 			  I2C_REG_CTL(alg_data));
 
 		/* Put start-code and slave-address on the bus. */
diff --git a/include/linux/i2c-pnx.h b/include/linux/i2c-pnx.h
index 5388326..1c5fa84 100644
--- a/include/linux/i2c-pnx.h
+++ b/include/linux/i2c-pnx.h
@@ -29,6 +29,8 @@ struct i2c_pnx_algo_data {
 	void __iomem		*ioaddr;
 	struct i2c_pnx_mif	mif;
 	int			last;
+	int			repeated_start;
+	int			write_start_read;
 	struct clk		*clk;
 	struct i2c_adapter	adapter;
 	int			irq;
-- 
2.4.5
