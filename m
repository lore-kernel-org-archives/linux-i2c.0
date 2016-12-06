From: Tin Huynh <tnhuynh@apm.com>
Subject: [PATCH V2] i2c: designware: fix wrong tx/rx fifo for ACPI
Date: Tue,  6 Dec 2016 14:57:53 +0700
Message-ID: <1481011073-29143-1-git-send-email-tnhuynh@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com, Tin Huynh <tnhuynh@apm.com>
List-Id: linux-i2c@vger.kernel.org

ACPI always sets txfifo and rxfifo to 32. This configuration will
cause problem if the IP core supports a fifo size of less than 32.
The driver should read the fifo size from the IP and select the 
smaller one of the two.

Signed-off-by: Tin Huynh <tnhuynh@apm.com>

---
 drivers/i2c/busses/i2c-designware-platdrv.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

Change from V1:
 -Revert the default 32 for fifo, read parameter from IP core
 and pick the smaller one of the two.
 -Correct the title to describe new approach.

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0b42a12..76b061f 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -153,6 +153,7 @@ static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	u32 param1, tx_fifo_depth, rx_fifo_depth;
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
 	struct resource *mem;
@@ -246,12 +247,18 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 				1000000);
 	}
 
+	param1 = i2c_dw_read_comp_param(dev);
+	tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
+	rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
 	if (!dev->tx_fifo_depth) {
-		u32 param1 = i2c_dw_read_comp_param(dev);
-
-		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
-		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
+		dev->tx_fifo_depth = tx_fifo_depth;
+		dev->rx_fifo_depth = rx_fifo_depth;
 		dev->adapter.nr = pdev->id;
+	} else if (tx_fifo_depth) {
+		dev->tx_fifo_depth = min_t(u32, dev->tx_fifo_depth,
+							tx_fifo_depth);
+		dev->rx_fifo_depth = min_t(u32, dev->rx_fifo_depth,
+							rx_fifo_depth);
 	}
 
 	adap = &dev->adapter;
-- 
1.7.1

