From: Xiangliang Yu <Xiangliang.Yu@amd.com>
Subject: [PATCH v2] I2C: designware: fix IO timeout issue for AMD controller
Date: Fri, 11 Dec 2015 20:02:53 +0800
Message-ID: <1449835373-4669-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0053.outbound.protection.outlook.com ([65.55.169.53]:3808
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753587AbbLKHEY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 11 Dec 2015 02:04:24 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: SPG_Linux_Kernel@amd.com, Xiangliang Yu <Xiangliang.Yu@amd.com>

Because of some hardware limitation, AMD I2C controller can't
trigger pending interrupt if interrupt status has been changed
after clearing interrupt status bits. Then, I2C will lost
interrupt and IO timeout.

According to hardware design, this patch implements a workaround
to disable i2c controller interrupt and re-enable i2c interrupt
before exiting ISR.

To reduce the performance impacts on other vendors, use unlikely
function to check flag in ISR.
---
Changes in v2:
    - pass flags with ->driver_data
    - unmask interrupt right after masking

Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
---
 drivers/i2c/busses/i2c-designware-core.c    | 6 ++++++
 drivers/i2c/busses/i2c-designware-core.h    | 1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 7 ++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 8c48b27..de7fbbb 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -813,6 +813,12 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 tx_aborted:
 	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_err)
 		complete(&dev->cmd_complete);
+	else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
+		/* workaround to trigger pending interrupt */
+		stat = dw_readl(dev, DW_IC_INTR_MASK);
+		i2c_dw_disable_int(dev);
+		dw_writel(dev, stat, DW_IC_INTR_MASK);
+	}
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 1d50898..9ffb63a 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -111,6 +111,7 @@ struct dw_i2c_dev {
 
 #define ACCESS_SWAP		0x00000001
 #define ACCESS_16BIT		0x00000002
+#define ACCESS_INTR_MASK	0x00000004
 
 extern int i2c_dw_init(struct dw_i2c_dev *dev);
 extern void i2c_dw_disable(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 809579e..f03ea71 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -93,6 +93,7 @@ static void dw_i2c_acpi_params(struct platform_device *pdev, char method[],
 static int dw_i2c_acpi_configure(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+	const struct acpi_device_id *id;
 
 	dev->adapter.nr = -1;
 	dev->tx_fifo_depth = 32;
@@ -106,6 +107,10 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev->fs_lcnt,
 			   &dev->sda_hold_time);
 
+	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
+	if (id && id->driver_data)
+		dev->accessor_flags |= (u32)id->driver_data;
+
 	return 0;
 }
 
@@ -116,7 +121,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "INT3433", 0 },
 	{ "80860F41", 0 },
 	{ "808622C1", 0 },
-	{ "AMD0010", 0 },
+	{ "AMD0010", ACCESS_INTR_MASK },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
-- 
1.9.1
