From: "Olivares, Ricardo Perez" <richo-l0cyMroinI0@public.gmane.org>
Subject: FW: [PATCH 06/16] i2c-designware: Remove an useless local variable
 "num"
Date: Tue, 13 Oct 2009 17:06:12 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE401554D74D8@dlee06.ent.ti.com>
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
Sent: Monday, October 12, 2009 9:50 PM
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Subject: [PATCH 06/16] i2c-designware: Remove an useless local variable "num"

We couldn't know the original intent for this variable, but at this point it's useless.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 205f691..9d81775 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -257,7 +257,6 @@ static void
 i2c_dw_xfer_msg(struct dw_i2c_dev *dev)  {
 	struct i2c_msg *msgs = dev->msgs;
-	int num = dev->msgs_num;
 	u32 ic_con, intr_mask;
 	int tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
 	int rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR); @@ -283,7 +282,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 		writel(1, dev->base + DW_IC_ENABLE);
 	}
 
-	for (; dev->msg_write_idx < num; dev->msg_write_idx++) {
+	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
 		/* if target address has changed, we need to
 		 * reprogram the target address in the i2c
 		 * adapter when we are done with this transfer @@ -330,11 +329,10 @@ static void  i2c_dw_read(struct dw_i2c_dev *dev)  {
 	struct i2c_msg *msgs = dev->msgs;
-	int num = dev->msgs_num;
 	u32 addr = msgs[dev->msg_read_idx].addr;
 	int rx_valid = readl(dev->base + DW_IC_RXFLR);
 
-	for (; dev->msg_read_idx < num; dev->msg_read_idx++) {
+	for (; dev->msg_read_idx < dev->msgs_num; dev->msg_read_idx++) {
 		u32 len;
 		u8 *buf;
 
--
1.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
