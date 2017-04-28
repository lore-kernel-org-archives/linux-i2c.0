From: Tim Sander <tim@krieglstein.org>
Subject: RFC: i2c designware gpio recovery
Date: Fri, 28 Apr 2017 17:43:30 +0200
Message-ID: <2259005.m0altzP21Z@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi

I have tried to add a gpio recovery gpio controller to the designware i2c driver. The attempt is
attached below. I have a Intel(Altera) Cyclone V SOC Platform attached to a buggy power
supply which gives a lockup on the i2c controller as a external device gives to much noise
on the signal and destroys a clock signal on its way to a i2c device.
I don't care to much about this buggy power supply but as the cable to one i2c-slave is
rather long i fear that power surge conformance tests might give also some problems.
So i would like to be safe than sorry and recover from this problem.

I have created two gpio ports in fpga and have routed the designware pins through the fpga.
I can now read SDA input status and control SCL via these gpios. The recovery gets triggered
and after that i get lots of:
i2c_designware ffc05000.i2c: controller timed out
so i guess that my i2c_dw_unprepare_recovery does not enought to get the controller back.

I have also noticed that there does not seem do be a reset controller in the standard configuration.
so reset_control_(de)assert(i_dev->rst) seems to do nothing.

I have verified that the recovery of the bus works and if i do a warm reboot the i2c-bus is working
again. Which it doesn't without recovery. So i am pretty sure that the recovery works as far as the
i2c-slave is not pulling down SDA and that my gpio pins are in the correct state that they would not
interfere with the i2c-operation of the controller.

Any ideas what i can do to get the controller back up running with some special treatment in
i2c_dw_(un)prepare_recovery without having to resort to a warm reboot?

Best regards
Tim
---
 drivers/i2c/busses/i2c-designware-core.c    | 15 ++++++--
 drivers/i2c/busses/i2c-designware-core.h    |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 60 ++++++++++++++++++++++++++++-
 drivers/i2c/i2c-core.c                      | 10 ++++-
 4 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 7a3faa551cf8..b98fab40ce9a 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -317,6 +317,7 @@ static void i2c_dw_release_lock(struct dw_i2c_dev *dev)
                dev->release_lock(dev);
 }
 
+
 /**
  * i2c_dw_init() - initialize the designware i2c master hardware
  * @dev: device private data
@@ -463,7 +464,11 @@ static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
        while (dw_readl(dev, DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
                if (timeout <= 0) {
                        dev_warn(dev->dev, "timeout waiting for bus ready\n");
-                       return -ETIMEDOUT;
+                       i2c_recover_bus(&dev->adapter);
+
+                       if (dw_readl(dev, DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY)
+                               return -EIO;
+                       else return 0;
                }
                timeout--;
                usleep_range(1000, 1100);
@@ -719,9 +724,10 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
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
@@ -766,6 +772,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
        if (!wait_for_completion_timeout(&dev->cmd_complete, adap->timeout)) {
                dev_err(dev->dev, "controller timed out\n");
                /* i2c_dw_init implicitly disables the adapter */
+               //i2c_recover_bus(&dev->adapter); 
                i2c_dw_init(dev);
                ret = -ETIMEDOUT;
                goto done;
@@ -825,7 +832,7 @@ static const struct i2c_algorithm i2c_dw_algo = {
        .functionality  = i2c_dw_func,
 };
 
-static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
+u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 {
        u32 stat;
 
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index d9aaf1790e0e..8bdf51e19f21 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -126,6 +126,7 @@ struct dw_i2c_dev {
        int                     (*acquire_lock)(struct dw_i2c_dev *dev);
        void                    (*release_lock)(struct dw_i2c_dev *dev);
        bool                    pm_runtime_disabled;
+       struct                  i2c_bus_recovery_info rinfo;
 };
 
 #define ACCESS_SWAP            0x00000001
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 79c4b4ea0539..28ed9e886983 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -41,6 +41,7 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_data/i2c-designware.h>
 #include "i2c-designware-core.h"
 
@@ -174,6 +175,55 @@ static void dw_i2c_set_fifo_size(struct dw_i2c_dev *dev, int id)
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
+static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev, struct i2c_adapter *adap)
+{
+       struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
+
+       rinfo->recover_bus = i2c_generic_gpio_recovery;
+       rinfo->prepare_recovery = i2c_dw_prepare_recovery;
+       rinfo->unprepare_recovery = i2c_dw_unprepare_recovery;
+
+       dev->rinfo.scl_gpio = of_get_named_gpio(dev->dev->of_node, "scl-gpios", 0);
+       if ( dev->rinfo.scl_gpio == -EPROBE_DEFER ) {
+               return -EPROBE_DEFER;
+       }
+       dev->rinfo.sda_gpio = of_get_named_gpio(dev->dev->of_node, "sda-gpios", 0);
+       if ( dev->rinfo.sda_gpio == -EPROBE_DEFER ) {
+               return -EPROBE_DEFER;
+       }
+       if ( !gpio_is_valid(dev->rinfo.scl_gpio) || !gpio_is_valid(dev->rinfo.sda_gpio) )
+               return -ENODEV;
+
+       dev_info(dev->dev,"adapter: %s running with gpio recovery mode! scl:%i sda:%i\n",adap->name,dev->rinfo.scl_gpio,dev->rinfo.sda_gpio);
+       adap->bus_recovery_info = &dev->rinfo;
+
+       return 0;
+};
+
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
        struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -285,6 +335,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
        adap->class = I2C_CLASS_DEPRECATED;
        ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
        adap->dev.of_node = pdev->dev.of_node;
+        snprintf(adap->name, sizeof(adap->name), "Designware i2c adapter");
 
        if (dev->pm_runtime_disabled) {
                pm_runtime_forbid(&pdev->dev);
@@ -295,11 +346,16 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
                pm_runtime_enable(&pdev->dev);
        }
 
+        r = i2c_dw_init_recovery_info(dev,adap);
+        if (r  == -EPROBE_DEFER)
+          goto exit_probe ;
+
+
        r = i2c_dw_probe(dev);
        if (r)
-               goto exit_probe;
+          goto exit_probe;
 
-       return r;
+       return 0 ;
 
 exit_probe:
        if (!dev->pm_runtime_disabled)
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d2402bbf6729..e1fc1d2a9548 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -739,6 +739,7 @@ static int get_scl_gpio_value(struct i2c_adapter *adap)
 
 static void set_scl_gpio_value(struct i2c_adapter *adap, int val)
 {
+       dev_err(&adap->dev,"set scl:%i value: %i\n",adap->bus_recovery_info->scl_gpio, val);
        gpio_set_value(adap->bus_recovery_info->scl_gpio, val);
 }
 
@@ -753,7 +754,7 @@ static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
        struct device *dev = &adap->dev;
        int ret = 0;
 
-       ret = gpio_request_one(bri->scl_gpio, GPIOF_OPEN_DRAIN |
+       ret = gpio_request_one(bri->scl_gpio, //GPIOF_OPEN_DRAIN |
                        GPIOF_OUT_INIT_HIGH, "i2c-scl");
        if (ret) {
                dev_warn(dev, "Can't get SCL gpio: %d\n", bri->scl_gpio);
@@ -807,8 +808,10 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
        while (i++ < RECOVERY_CLK_CNT * 2) {
                if (val) {
                        /* Break if SDA is high */
-                       if (bri->get_sda && bri->get_sda(adap))
+                       if (bri->get_sda && bri->get_sda(adap)) {
+                                       dev_err(&adap->dev,"sda is high done\n");
                                        break;
+                       }
                        /* SCL shouldn't be low here */
                        if (!bri->get_scl(adap)) {
                                dev_err(&adap->dev,
@@ -823,6 +826,7 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
                ndelay(RECOVERY_NDELAY);
        }
 
+       dev_err(&adap->dev,"recovery cycle\n");
        if (bri->unprepare_recovery)
                bri->unprepare_recovery(adap);
 
@@ -839,10 +843,12 @@ int i2c_generic_gpio_recovery(struct i2c_adapter *adap)
 {
        int ret;
 
+
        ret = i2c_get_gpios_for_recovery(adap);
        if (ret)
                return ret;
 
+       dev_err(&adap->dev,"i2c_generic_gpio_recovery have gpios\n");
        ret = i2c_generic_recovery(adap);
        i2c_put_gpios_for_recovery(adap);
 
-- 
2.7.4
