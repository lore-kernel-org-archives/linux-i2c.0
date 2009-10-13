From: "Olivares, Ricardo Perez" <richo-l0cyMroinI0@public.gmane.org>
Subject: FW: [PATCH 11/16] i2c-designware: Set Tx/Rx FIFO threshold levels
Date: Tue, 13 Oct 2009 16:27:25 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE401554D744D@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

 

-----Original Message-----
From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Shinya Kuribayashi
Sent: Monday, October 12, 2009 9:52 PM
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Subject: [PATCH 11/16] i2c-designware: Set Tx/Rx FIFO threshold levels

As a hardware feature, DesignWare I2C core emits a STOP condition whenever Tx FIFO becomes empty (strictly speaking, whenever the last byte in the Tx FIFO has been sent out), even if we have more bytes to be written.

In other words, we must never make "Tx FIFO underrun" happen during a transaction, except for the last byte.  For the safety's sake, we'd make TX_EMPTY interrupt get triggered every time one byte is processed.

Rx FIFO threshold needs to be set as well according to such tx policy.
In addition, this patch also modifies the interrupt settings properly (enable RX_FULL mask, and hook it in the handler)

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 52a69a2..d9b5790 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -50,6 +50,8 @@
 #define DW_IC_INTR_STAT		0x2c
 #define DW_IC_INTR_MASK		0x30
 #define DW_IC_RAW_INTR_STAT	0x34
+#define DW_IC_RX_TL		0x38
+#define DW_IC_TX_TL		0x3c
 #define DW_IC_CLR_INTR		0x40
 #define DW_IC_CLR_RX_UNDER	0x44
 #define DW_IC_CLR_RX_OVER	0x48
@@ -294,6 +296,10 @@ static void i2c_dw_init(struct dw_i2c_dev *dev)
 	writel(lcnt, dev->base + DW_IC_FS_SCL_LCNT);
 	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
 
+	/* Configure Tx/Rx FIFO threshold levels */
+	writel(dev->tx_fifo_depth - 1, dev->base + DW_IC_TX_TL);
+	writel(0, dev->base + DW_IC_RX_TL);
+
 	/* configure the i2c master */
 	ic_con = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST; @@ -396,7 +402,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 		}
 	}
 
-	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
+	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT | 
+DW_IC_INTR_RX_FULL;
 	if (buf_len > 0)
 		intr_mask |= DW_IC_INTR_TX_EMPTY;
 	writel(intr_mask, dev->base + DW_IC_INTR_MASK); @@ -582,11 +588,12 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 		dev->status = STATUS_IDLE;
 	}
 
-	if (stat & DW_IC_INTR_TX_EMPTY) {
-		/* Allocate room for data reception prior to xfer_msg() */
+	/* Allocate room for data reception prior to i2c_dw_xfer_msg(). */
+	if (stat & DW_IC_INTR_RX_FULL)
 		i2c_dw_read(dev);
+
+	if (stat & DW_IC_INTR_TX_EMPTY)
 		i2c_dw_xfer_msg(dev);
-	}
 
 	/*
 	 * No need to modify or disable the interrupt mask here, as
--
1.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
