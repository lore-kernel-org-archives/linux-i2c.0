From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 04/22] i2c-designware: i2c_dw_read: Use "struct dw_i2c_dev"
 pointer
Date: Fri, 06 Nov 2009 21:45:39 +0900
Message-ID: <4AF41A73.4000804@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

We don't have to use "struct i2c_adapter" pointer here.
Let's use a local "struct dw_i2c_dev" pointer, instead.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 139f555..bb7b257 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -328,9 +328,8 @@ i2c_dw_xfer_msg(struct i2c_adapter *adap)
 }
 
 static void
-i2c_dw_read(struct i2c_adapter *adap)
+i2c_dw_read(struct dw_i2c_dev *dev)
 {
-	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 	struct i2c_msg *msgs = dev->msgs;
 	int num = dev->msgs_num;
 	u32 addr = msgs[dev->msg_read_idx].addr;
@@ -416,7 +415,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
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
1.6.5.2
