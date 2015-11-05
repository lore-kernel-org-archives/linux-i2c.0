From: Xiangliang Yu <Xiangliang.Yu@amd.com>
Subject: [PATCH 1/1] I2C: designware: fix IO timeout issue for AMD controller
Date: Thu, 5 Nov 2015 20:34:44 +0800
Message-ID: <1446726884-30558-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1on0094.outbound.protection.outlook.com ([157.56.110.94]:42030
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1031161AbbKEHuv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 5 Nov 2015 02:50:51 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ken.Xue@amd.com, Vincent.Wan@amd.com, Ray.Huang@amd.com, Annie.Wang@amd.com, Tony.Li@amd.com, Xiangliang Yu <Xiangliang.Yu@amd.com>

Because of some hardware limitation, AMD I2C controller can't
trigger next interrupt if interrupt status has been changed
after clearing interrupt status bits. Then, I2C will lost
interrupt and IO timeout.

According to hardware design, this patch implements a workaround
to disable i2c controller interrupt after clearing interrupt bits
when entering ISR and to enable i2c interrupt before exiting ISR.

To reduce the performance impacts on other vendors, use unlikely
function to check flag in ISR.

Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
---
 drivers/i2c/busses/i2c-designware-core.c    | 6 ++++++
 drivers/i2c/busses/i2c-designware-core.h    | 1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 7441cdc..04e7b65 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -783,6 +783,9 @@ irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 
 	stat = i2c_dw_read_clear_intrbits(dev);
 
+	if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK))
+		i2c_dw_disable_int(dev);
+
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		dev->cmd_err |= DW_IC_ERR_TX_ABRT;
 		dev->status = STATUS_IDLE;
@@ -811,6 +814,9 @@ tx_aborted:
 	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_err)
 		complete(&dev->cmd_complete);
 
+	if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK))
+		dw_writel(dev, DW_IC_INTR_DEFAULT_MASK, DW_IC_INTR_MASK);
+
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL_GPL(i2c_dw_isr);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9630222..808ef6a 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -111,6 +111,7 @@ struct dw_i2c_dev {
 
 #define ACCESS_SWAP		0x00000001
 #define ACCESS_16BIT		0x00000002
+#define ACCESS_INTR_MASK	0x00000004
 
 extern u32 dw_readl(struct dw_i2c_dev *dev, int offset);
 extern void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 472b882..0c59357 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -251,6 +251,10 @@ static int dw_i2c_probe(struct platform_device *pdev)
 		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
 		dev->adapter.nr = pdev->id;
 	}
+
+	if (!strncmp(pdev->name, "AMD0010", 7))
+		dev->accessor_flags |= ACCESS_INTR_MASK;
+
 	r = i2c_dw_init(dev);
 	if (r)
 		return r;
-- 
1.9.1
