From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH RESEND 2/2] i2c: pnx: Fix read transactions of >= 2 bytes
Date: Wed,  8 Aug 2012 09:42:32 +0200
Message-ID: <1344411752-23469-2-git-send-email-stigge@antcom.de>
References: <1344411752-23469-1-git-send-email-stigge@antcom.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1344411752-23469-1-git-send-email-stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kevin.wells-3arQi8VN3Tc@public.gmane.org, srinivas.bakki-3arQi8VN3Tc@public.gmane.org, aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On transactions with n>=2 bytes, the controller actually wrongly clocks in n+1
bytes. This is caused by the (wrong) assumption that RFE in the Status Register
is 1 iff there is no byte already ordered (via a dummy TX byte). This lead to
the implementation of synchronized byte ordering, e.g.:

Dummy-TX - RX - Dummy-TX - RX - ...

But since RFE actually stays high after some Dummy-TX, it rather looks like:

Dummy-TX - Dummy-TX - RX - Dummy-TX - RX - (RX)

The last RX byte is clocked in by the bus controller, but ignored by the kernel
when filling the userspace buffer.

This patch fixes the issue by asking for RX via Dummy-TX asynchronously.
Introducing a separate counter for TX bytes.

Signed-off-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>

---
Applies to v3.6-rc1

This patch for i2c-pnx affects PNX4008 and LPC32xx (and LPC31xx, not yet in
mainline). Can you please test?

Thanks in advance!

 drivers/i2c/busses/i2c-pnx.c |   48 +++++++++++++++++++++++++------------------
 include/linux/i2c-pnx.h      |    1 
 2 files changed, 29 insertions(+), 20 deletions(-)

--- linux-2.6.orig/drivers/i2c/busses/i2c-pnx.c
+++ linux-2.6/drivers/i2c/busses/i2c-pnx.c
@@ -291,31 +291,37 @@ static int i2c_pnx_master_rcv(struct i2c
 	 * or we didn't 'ask' for it yet.
 	 */
 	if (ioread32(I2C_REG_STS(alg_data)) & mstatus_rfe) {
-		dev_dbg(&alg_data->adapter.dev,
-			"%s(): Write dummy data to fill Rx-fifo...\n",
-			__func__);
+		/* 'Asking' is done asynchronously, e.g. dummy TX of several
+		 * bytes is done before the first actual RX arrives in FIFO.
+		 * Therefore, ordered bytes (via TX) are counted separately.
+		 */
+		if (alg_data->mif.order) {
+			dev_dbg(&alg_data->adapter.dev,
+				"%s(): Write dummy data to fill Rx-fifo...\n",
+				__func__);
 
-		if (alg_data->mif.len == 1) {
-			/* Last byte, do not acknowledge next rcv. */
-			val |= stop_bit;
+			if (alg_data->mif.order == 1) {
+				/* Last byte, do not acknowledge next rcv. */
+				val |= stop_bit;
+
+				/*
+				 * Enable interrupt RFDAIE (data in Rx fifo),
+				 * and disable DRMIE (need data for Tx)
+				 */
+				ctl = ioread32(I2C_REG_CTL(alg_data));
+				ctl |= mcntrl_rffie | mcntrl_daie;
+				ctl &= ~mcntrl_drmie;
+				iowrite32(ctl, I2C_REG_CTL(alg_data));
+			}
 
 			/*
-			 * Enable interrupt RFDAIE (data in Rx fifo),
-			 * and disable DRMIE (need data for Tx)
+			 * Now we'll 'ask' for data:
+			 * For each byte we want to receive, we must
+			 * write a (dummy) byte to the Tx-FIFO.
 			 */
-			ctl = ioread32(I2C_REG_CTL(alg_data));
-			ctl |= mcntrl_rffie | mcntrl_daie;
-			ctl &= ~mcntrl_drmie;
-			iowrite32(ctl, I2C_REG_CTL(alg_data));
+			iowrite32(val, I2C_REG_TX(alg_data));
+			alg_data->mif.order--;
 		}
-
-		/*
-		 * Now we'll 'ask' for data:
-		 * For each byte we want to receive, we must
-		 * write a (dummy) byte to the Tx-FIFO.
-		 */
-		iowrite32(val, I2C_REG_TX(alg_data));
-
 		return 0;
 	}
 
@@ -515,6 +521,7 @@ i2c_pnx_xfer(struct i2c_adapter *adap, s
 
 		alg_data->mif.buf = pmsg->buf;
 		alg_data->mif.len = pmsg->len;
+		alg_data->mif.order = pmsg->len;
 		alg_data->mif.mode = (pmsg->flags & I2C_M_RD) ?
 			I2C_SMBUS_READ : I2C_SMBUS_WRITE;
 		alg_data->mif.ret = 0;
@@ -567,6 +574,7 @@ i2c_pnx_xfer(struct i2c_adapter *adap, s
 	/* Cleanup to be sure... */
 	alg_data->mif.buf = NULL;
 	alg_data->mif.len = 0;
+	alg_data->mif.order = 0;
 
 	dev_dbg(&alg_data->adapter.dev, "%s(): exiting, stat = %x\n",
 		__func__, ioread32(I2C_REG_STS(alg_data)));
--- linux-2.6.orig/include/linux/i2c-pnx.h
+++ linux-2.6/include/linux/i2c-pnx.h
@@ -22,6 +22,7 @@ struct i2c_pnx_mif {
 	struct timer_list	timer;		/* Timeout */
 	u8 *			buf;		/* Data buffer */
 	int			len;		/* Length of data buffer */
+	int			order;		/* RX Bytes to order via TX */
 };
 
 struct i2c_pnx_algo_data {
