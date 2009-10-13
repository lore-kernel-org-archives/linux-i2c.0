From: "Olivares, Ricardo Perez" <richo-l0cyMroinI0@public.gmane.org>
Subject: FW: [PATCH 04/16] i2c-designware: i2c_dw_read: Take "struct
 dw_i2c_dev" pointer
Date: Tue, 13 Oct 2009 16:27:25 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE401554D745A@dlee06.ent.ti.com>
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
Subject: [PATCH 04/16] i2c-designware: i2c_dw_read: Take "struct dw_i2c_dev" pointer

There's no need to interface using with "struct i2c_adapter" pointer.
Let's use a local "struct dw_i2c_dev" pointer, instead.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 0164092..c6a35bf 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -328,9 +328,8 @@ i2c_dw_xfer_msg(struct i2c_adapter *adap)  }
 
 static void
-i2c_dw_read(struct i2c_adapter *adap)
+i2c_dw_read(struct dw_i2c_dev *dev)
 {
-	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 	struct i2c_msg *msgs = dev->msgs;
 	int num = dev->msgs_num;
 	u32 addr = msgs[dev->msg_read_idx].addr; @@ -416,7 +415,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (likely(!dev->cmd_err)) {
 		/* read rx fifo, and disable the adapter */
 		do {
-			i2c_dw_read(adap);
+			i2c_dw_read(dev);
 		} while (dev->status & STATUS_READ_IN_PROGRESS);
 		writel(0, dev->base + DW_IC_ENABLE);
 		ret = num;
@@ -450,7 +449,7 @@ static void dw_i2c_pump_msg(unsigned long data)
 	struct dw_i2c_dev *dev = (struct dw_i2c_dev *) data;
 	u32 intr_mask;
 
-	i2c_dw_read(&dev->adapter);
+	i2c_dw_read(dev);
 	i2c_dw_xfer_msg(&dev->adapter);
 
 	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
--
1.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
