From: Fugang Duan <b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] i2c: imx: double check IIF in case interrupt lost
Date: Thu, 14 Aug 2014 16:29:14 +0800
Message-ID: <1408004954-29418-1-git-send-email-b38611@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

In i2c_imx_read():
...
result = i2c_imx_trx_complete(i2c_imx);
if (result)
		return result;
..

If the current byte read complete, "IIF" status is set, and pend
up one GIC interrupt. In irq handler, wake up the wait queue in
.i2c_imx_trx_complete().

But, for imx6q platform with high bus and cpu loading test cases,
after long time test, sometime i2c interrupt is lost, but "IIF" is
set, according to current logic code, i2c_imx_trx_complete() still
return "-ETIMEDOUT", and then i2c host don't read the rest of data,
i2c driver stop transmit, disable controller and clock. Thus, i2c
device cannot wait clock and always drive the SDA line.

So, SDA is pulled down by i2c device, which needs 9 clocks to recovery
the SDA line.

To avoid the issue, we can double check IIF bit after timeout for waiting
event in .i2c_imx_trx_complete(), if IIF bit is set, process it in
normal flow. The patch just to double check IIF in case interrupt lost.

Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index aa8bc14..4b63771 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -285,11 +285,17 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 
 static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
 {
+	unsigned int temp;
+
 	wait_event_timeout(i2c_imx->queue, i2c_imx->i2csr & I2SR_IIF, HZ / 10);
 
 	if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
-		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
-		return -ETIMEDOUT;
+		/* Double check IIF to avoid interrupt lost */
+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
+		if (!(temp & I2SR_IIF)) {
+			dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
+			return -ETIMEDOUT;
+		}
 	}
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete\n", __func__);
 	i2c_imx->i2csr = 0;
-- 
1.7.8
