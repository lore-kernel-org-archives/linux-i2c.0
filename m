From: Tim Sander <tim@krieglstein.org>
Subject: [PATCH] i2c-designware: add i2c gpio recovery option
Date: Wed, 10 May 2017 13:57:06 +0200
Message-ID: <32490844.DoY2McpBxU@dabox>
References: <2259005.m0altzP21Z@dabox> <1966782.aCEMFj2YWU@virgo> <4a84d6b1-2bba-6f01-8286-49661ef45576@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from krieglstein.org ([176.28.13.145]:39298 "EHLO krieglstein.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbdEJL5J (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 10 May 2017 07:57:09 -0400
In-Reply-To: <4a84d6b1-2bba-6f01-8286-49661ef45576@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

This patch contains much input from Phil Reid and has been tested
on Intel/Altera Cyclone V SOC Hardware with Altera GPIO's for the 
SCL and SDA GPIO's. I am still a little unsure about the recover
in the timeout case (i2c-designware-core.c:770) as i could not
test this codepath.

Signed-off-by: Tim Sander <tim@krieglstein.org>
---
 drivers/i2c/busses/i2c-designware-core.c    | 14 ++++-
 drivers/i2c/busses/i2c-designware-core.h    |  4 ++
 drivers/i2c/busses/i2c-designware-platdrv.c | 90 ++++++++++++++++++++++++++++-
 3 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 7a3faa551cf8..f955f29ff8e7 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -317,6 +317,7 @@ static void i2c_dw_release_lock(struct dw_i2c_dev *dev)
                dev->release_lock(dev);
 }
 
+
 /**
  * i2c_dw_init() - initialize the designware i2c master hardware
  * @dev: device private data
@@ -463,7 +464,12 @@ static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
        while (dw_readl(dev, DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
                if (timeout <= 0) {
                        dev_warn(dev->dev, "timeout waiting for bus ready\n");
-                       return -ETIMEDOUT;
+                       i2c_recover_bus(&dev->adapter);
+
+                       if (dw_readl(dev, DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY)
+                               return -ETIMEDOUT;
+                       else
+                               return 0;
                }
                timeout--;
                usleep_range(1000, 1100);
@@ -719,9 +725,10 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
        for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
                dev_err(dev->dev, "%s: %s\n", __func__, abort_sources[i]);
 
-       if (abort_source & DW_IC_TX_ARB_LOST)
+       if (abort_source & DW_IC_TX_ARB_LOST) {
+               i2c_recover_bus(&dev->adapter);
                return -EAGAIN;
-       else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
+       } else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
                return -EINVAL; /* wrong msgs[] data */
        else
                return -EIO;
@@ -766,6 +773,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
        if (!wait_for_completion_timeout(&dev->cmd_complete, adap->timeout)) {
                dev_err(dev->dev, "controller timed out\n");
                /* i2c_dw_init implicitly disables the adapter */
+               i2c_recover_bus(&dev->adapter);
                i2c_dw_init(dev);
                ret = -ETIMEDOUT;
                goto done;
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index d9aaf1790e0e..cedc895a795d 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -23,6 +23,7 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/gpio.h>
 
 #define DW_IC_DEFAULT_FUNCTIONALITY (I2C_FUNC_I2C |                    \
                                        I2C_FUNC_SMBUS_BYTE |           \
@@ -126,6 +127,9 @@ struct dw_i2c_dev {
        int                     (*acquire_lock)(struct dw_i2c_dev *dev);
        void                    (*release_lock)(struct dw_i2c_dev *dev);
        bool                    pm_runtime_disabled;
+       struct i2c_bus_recovery_info rinfo;
+       struct  gpio_desc       *gpio_sda;
+       struct  gpio_desc       *gpio_scl;
 };
 
 #define ACCESS_SWAP            0x00000001
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 79c4b4ea0539..b2d5adc8df2b 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -41,6 +41,7 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_data/i2c-designware.h>
 #include "i2c-designware-core.h"
 
@@ -174,6 +175,88 @@ static void dw_i2c_set_fifo_size(struct dw_i2c_dev *dev, int id)
        }
 }
 
+/*
+ * This routine does i2c bus recovery by using i2c_generic_gpio_recovery
+ * which is provided by I2C Bus recovery infrastructure.
+ */
+static void i2c_dw_prepare_recovery(struct i2c_adapter *adap)
+{
+       struct platform_device *pdev = to_platform_device(&adap->dev);
+       struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+
+       i2c_dw_disable(i_dev);
+       reset_control_assert(i_dev->rst);
+       i2c_dw_plat_prepare_clk(i_dev, false);
+}
+
+void i2c_dw_unprepare_recovery(struct i2c_adapter *adap)
+{
+       struct platform_device *pdev = to_platform_device(&adap->dev);
+       struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+
+       i2c_dw_plat_prepare_clk(i_dev, true);
+       reset_control_deassert(i_dev->rst);
+       i2c_dw_init(i_dev);
+}
+
+
+static int i2c_dw_get_scl(struct i2c_adapter *adap)
+{
+       struct platform_device *pdev = to_platform_device(&adap->dev);
+       struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+
+       return gpiod_get_value_cansleep(dev->gpio_scl);
+}
+
+static void i2c_dw_set_scl(struct i2c_adapter *adap, int val)
+{
+       struct platform_device *pdev = to_platform_device(&adap->dev);
+       struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+
+       gpiod_set_value_cansleep(dev->gpio_scl, val);
+}
+
+static int i2c_dw_get_sda(struct i2c_adapter *adap)
+{
+       struct platform_device *pdev = to_platform_device(&adap->dev);
+       struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+
+       return gpiod_get_value_cansleep(dev->gpio_sda);
+}
+
+static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev,
+                                    struct i2c_adapter *adap)
+{
+       struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
+
+       dev->gpio_scl = devm_gpiod_get_optional(dev->dev,
+                                               "scl",
+                                               GPIOD_OUT_HIGH);
+       if (IS_ERR_OR_NULL(dev->gpio_scl))
+               return PTR_ERR(dev->gpio_scl);
+
+       dev->gpio_sda = devm_gpiod_get_optional(dev->dev, "sda", GPIOD_IN);
+       if (IS_ERR_OR_NULL(dev->gpio_sda))
+               return PTR_ERR(dev->gpio_sda);
+
+       rinfo->scl_gpio = desc_to_gpio(dev->gpio_scl);
+       rinfo->sda_gpio = desc_to_gpio(dev->gpio_sda);
+       rinfo->set_scl  = i2c_dw_set_scl;
+       rinfo->get_scl  = i2c_dw_get_scl;
+       rinfo->get_sda  = i2c_dw_get_sda;
+
+       rinfo->recover_bus = i2c_generic_scl_recovery;
+       rinfo->prepare_recovery = i2c_dw_prepare_recovery;
+       rinfo->unprepare_recovery = i2c_dw_unprepare_recovery;
+       adap->bus_recovery_info = rinfo;
+
+       dev_info(dev->dev,
+               "adapter: %s running with gpio recovery mode! scl:%i sda:%i \n",
+               adap->name, rinfo->scl_gpio, rinfo->sda_gpio);
+
+       return 0;
+};
+
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
        struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -285,6 +368,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
        adap->class = I2C_CLASS_DEPRECATED;
        ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
        adap->dev.of_node = pdev->dev.of_node;
+       snprintf(adap->name, sizeof(adap->name), "Designware i2c adapter");
 
        if (dev->pm_runtime_disabled) {
                pm_runtime_forbid(&pdev->dev);
@@ -295,11 +379,15 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
                pm_runtime_enable(&pdev->dev);
        }
 
+       r = i2c_dw_init_recovery_info(dev, adap);
+       if (r  == -EPROBE_DEFER)
+               goto exit_probe;
+
        r = i2c_dw_probe(dev);
        if (r)
                goto exit_probe;
 
-       return r;
+       return 0;
 
 exit_probe:
        if (!dev->pm_runtime_disabled)
-- 
2.7.4
