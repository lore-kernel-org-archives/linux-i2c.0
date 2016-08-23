From: Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v4 2/4] i2c: designware: add common functions for locking
Date: Tue, 23 Aug 2016 19:18:54 -0300
Message-ID: <1471990736-30190-3-git-send-email-lucas.demarchi@intel.com>
References: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Christian Ruppert <christian.ruppert@alitech.com>, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Lucas De Marchi <lucas.demarchi@intel.com>
List-Id: linux-i2c@vger.kernel.org

These are used in 2 places and will be needed in more.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/i2c/busses/i2c-designware-core.c | 52 ++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 2c61585..79f33b3 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -287,6 +287,28 @@ static unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
 	return dev->get_clk_rate_khz(dev);
 }
 
+static int i2c_dw_acquire_lock(struct dw_i2c_dev *dev)
+{
+	int ret;
+
+	if (!dev->acquire_lock)
+		return 0;
+
+	ret = dev->acquire_lock(dev);
+	if (!ret)
+		return 0;
+
+	dev_err(dev->dev, "couldn't acquire bus ownership\n");
+
+	return ret;
+}
+
+static void i2c_dw_release_lock(struct dw_i2c_dev *dev)
+{
+	if (dev->release_lock)
+		dev->release_lock(dev);
+}
+
 /**
  * i2c_dw_init() - initialize the designware i2c master hardware
  * @dev: device private data
@@ -302,13 +324,9 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	u32 sda_falling_time, scl_falling_time;
 	int ret;
 
-	if (dev->acquire_lock) {
-		ret = dev->acquire_lock(dev);
-		if (ret) {
-			dev_err(dev->dev, "couldn't acquire bus ownership\n");
-			return ret;
-		}
-	}
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
 
 	reg = dw_readl(dev, DW_IC_COMP_TYPE);
 	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
@@ -320,8 +338,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
 		dev_err(dev->dev, "Unknown Synopsys component type: "
 			"0x%08x\n", reg);
-		if (dev->release_lock)
-			dev->release_lock(dev);
+		i2c_dw_release_lock(dev);
 		return -ENODEV;
 	}
 
@@ -388,8 +405,8 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	/* configure the i2c master */
 	dw_writel(dev, dev->master_cfg , DW_IC_CON);
 
-	if (dev->release_lock)
-		dev->release_lock(dev);
+	i2c_dw_release_lock(dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(i2c_dw_init);
@@ -652,13 +669,9 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	dev->abort_source = 0;
 	dev->rx_outstanding = 0;
 
-	if (dev->acquire_lock) {
-		ret = dev->acquire_lock(dev);
-		if (ret) {
-			dev_err(dev->dev, "couldn't acquire bus ownership\n");
-			goto done_nolock;
-		}
-	}
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		goto done_nolock;
 
 	ret = i2c_dw_wait_bus_not_busy(dev);
 	if (ret < 0)
@@ -705,8 +718,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	ret = -EIO;
 
 done:
-	if (dev->release_lock)
-		dev->release_lock(dev);
+	i2c_dw_release_lock(dev);
 
 done_nolock:
 	pm_runtime_mark_last_busy(dev->dev);
-- 
2.7.4
