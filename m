From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 14/22] i2c-designware: Initialize byte count variables
 just prior to being used
Date: Fri, 06 Nov 2009 21:49:39 +0900
Message-ID: <4AF41B63.3020404@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

As the driver and hardware always process the given data in parallel,
then it would be better to initialize tx_limit, rx_limit and rx_valid
variables just prior to being used.

This will help us to send / receive as much data as possible.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index e8e2212..c3702a8 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -360,8 +360,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
 	u32 intr_mask;
-	int tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
-	int rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
+	int tx_limit, rx_limit;
 	u32 addr = msgs[dev->msg_write_idx].addr;
 	u32 buf_len = dev->tx_buf_len;
 	u8 *buf = dev->tx_buf;;
@@ -389,6 +388,9 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			buf_len = msgs[dev->msg_write_idx].len;
 		}
 
+		tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
+		rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
+
 		while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
 			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
 				writel(0x100, dev->base + DW_IC_DATA_CMD);
@@ -418,7 +420,7 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
 	u32 addr = msgs[dev->msg_read_idx].addr;
-	int rx_valid = readl(dev->base + DW_IC_RXFLR);
+	int rx_valid;
 
 	for (; dev->msg_read_idx < dev->msgs_num; dev->msg_read_idx++) {
 		u32 len;
@@ -439,6 +441,8 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 			buf = dev->rx_buf;
 		}
 
+		rx_valid = readl(dev->base + DW_IC_RXFLR);
+
 		for (; len > 0 && rx_valid > 0; len--, rx_valid--)
 			*buf++ = readl(dev->base + DW_IC_DATA_CMD);
 
-- 
1.6.5.2
