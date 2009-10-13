From: "Olivares, Ricardo Perez" <richo-l0cyMroinI0@public.gmane.org>
Subject: FW: [PATCH 13/16] i2c-designware: i2c_dw_xfer_msg: Introduce a
 local "buf" pointer
Date: Tue, 13 Oct 2009 17:05:05 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE401554D74B7@dlee06.ent.ti.com>
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
Sent: Monday, October 12, 2009 9:53 PM
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Subject: [PATCH 13/16] i2c-designware: i2c_dw_xfer_msg: Introduce a local "buf" pointer

While we have "buf_len" local variable for dev->tx_buf_len, we don't have such local variable for dev->tx_buf pointer.  While "buf_len" is restored at first then updated when we're going to process a new i2c_msg (in WRITE_IN_PROGRESS case), ->tx_buf is never done so.

Such inconsistency makes the code slightly hard to follow.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---

 Furthermore, even with this change, i2c_dw_xfer_msg() is still  inconsistent with i2c_dw_read().  I don't have preference around  here, but would like to sort out.  Any suggestions are welcome.

 drivers/i2c/busses/i2c-designware.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index de006f0..b3152c2 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -363,6 +363,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	int rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
 	u32 addr = msgs[dev->msg_write_idx].addr;
 	u32 buf_len = dev->tx_buf_len;
+	u8 *buf = dev->tx_buf;;
 
 	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
 		/* if target address has changed, we need to @@ -381,7 +382,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 
 		if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
 			/* new i2c_msg */
-			dev->tx_buf = msgs[dev->msg_write_idx].buf;
+			buf	= msgs[dev->msg_write_idx].buf;
 			buf_len = msgs[dev->msg_write_idx].len;
 		}
 
@@ -390,12 +391,12 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 				writel(0x100, dev->base + DW_IC_DATA_CMD);
 				rx_limit--;
 			} else
-				writel(*(dev->tx_buf++),
-						dev->base + DW_IC_DATA_CMD);
+				writel(*buf++, dev->base + DW_IC_DATA_CMD);
 			tx_limit--; buf_len--;
 		}
 
 		dev->tx_buf_len = buf_len;
+		dev->tx_buf = buf;
 
 		/* more bytes to be written? */
 		if (buf_len > 0) {
--
1.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
