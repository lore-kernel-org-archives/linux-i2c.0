From: Tin Huynh <tnhuynh@apm.com>
Subject: [PATCH V3] i2c: designware: fix wrong tx/rx fifo for ACPI
Date: Mon, 12 Dec 2016 15:36:50 +0700
Message-ID: <1481531810-31695-1-git-send-email-tnhuynh@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com, Tin Huynh <tnhuynh@apm.com>
List-Id: linux-i2c@vger.kernel.org

ACPI always sets txfifo and rxfifo to 32. This configuration will
cause problem if the IP core supports a fifo size of less than 32.
The driver should read the fifo size from the IP and select the 
smaller one of the two.

Signed-off-by: Tin Huynh <tnhuynh@apm.com>

---
 drivers/i2c/busses/i2c-designware-platdrv.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

Change from V2:
 -Add a helper function to set fifo size.

Change from V1:
 -Revert the default 32 for fifo, read parameter from IP core
 and pick the smaller one of the two.
 -Correct the title to describe new approach.

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0b42a12..665f491 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -150,6 +150,24 @@ static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
 	return 0;
 }
 
+static void dw_i2c_set_fifo_size(struct dw_i2c_dev *dev)
+{
+	u32 param1, tx_fifo_depth, rx_fifo_depth;
+
+	param1 = i2c_dw_read_comp_param(dev);
+	tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
+	rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
+	if (!dev->tx_fifo_depth) {
+		dev->tx_fifo_depth = tx_fifo_depth;
+		dev->rx_fifo_depth = rx_fifo_depth;
+	} else if (tx_fifo_depth) {
+		dev->tx_fifo_depth = min_t(u32, dev->tx_fifo_depth,
+				tx_fifo_depth);
+		dev->rx_fifo_depth = min_t(u32, dev->rx_fifo_depth,
+				rx_fifo_depth);
+	}
+}
+
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -246,13 +264,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 				1000000);
 	}
 
-	if (!dev->tx_fifo_depth) {
-		u32 param1 = i2c_dw_read_comp_param(dev);
-
-		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
-		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
+	if (!dev->tx_fifo_depth)
 		dev->adapter.nr = pdev->id;
-	}
+	dw_i2c_set_fifo_size(dev);
 
 	adap = &dev->adapter;
 	adap->owner = THIS_MODULE;
-- 
1.7.1
