From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 13/22] i2c-designware: i2c_dw_xfer_msg: Introduce a local
 "buf" pointer
Date: Fri, 06 Nov 2009 21:49:14 +0900
Message-ID: <4AF41B4A.8050102@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

While we have a local variable "buf_len" for dev->tx_buf_len, we don't
have such local variable for dev->tx_buf pointer.  While "buf_len" is
restored at first then updated when we start processing a new i2c_msg
(determined by STATUS_WRITE_IN_PROGRESS flag), ->tx_buf is different.

Such inconsistency makes the code slightly hard to follow.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index da5612b..e8e2212 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -364,6 +364,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	int rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
 	u32 addr = msgs[dev->msg_write_idx].addr;
 	u32 buf_len = dev->tx_buf_len;
+	u8 *buf = dev->tx_buf;;
 
 	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT | DW_IC_INTR_RX_FULL;
 
@@ -384,7 +385,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 
 		if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
 			/* new i2c_msg */
-			dev->tx_buf = msgs[dev->msg_write_idx].buf;
+			buf = msgs[dev->msg_write_idx].buf;
 			buf_len = msgs[dev->msg_write_idx].len;
 		}
 
@@ -393,11 +394,11 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 				writel(0x100, dev->base + DW_IC_DATA_CMD);
 				rx_limit--;
 			} else
-				writel(*(dev->tx_buf++),
-						dev->base + DW_IC_DATA_CMD);
+				writel(*buf++, dev->base + DW_IC_DATA_CMD);
 			tx_limit--; buf_len--;
 		}
 
+		dev->tx_buf = buf;
 		dev->tx_buf_len = buf_len;
 
 		if (buf_len > 0) {
-- 
1.6.5.2
