From: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 2/2] i2c: xiic: Implement Power management
Date: Thu, 3 Mar 2016 14:15:10 +0530
Message-ID: <CAKfKVtH6wPTkYy0JmxOsF+gqc9R0cBK71WJCxnv42d3a4+_9Ow@mail.gmail.com>
References: <1456920247-37291-1-git-send-email-shubhraj@xilinx.com>
	<1456920247-37291-2-git-send-email-shubhraj@xilinx.com>
	<20160303083131.GB1552@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160303083131.GB1552@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 3, 2016 at 2:01 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Wed, Mar 02, 2016 at 05:34:07PM +0530, Shubhrajyoti Datta wrote:
>> Enable power management. This patch enables the clocks
>> before transfer and disables after the transfer.
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-xiic.c |   88 +++++++++++++++++++++++++++++++++++++---
>>  1 files changed, 81 insertions(+), 7 deletions(-)
>
> Changelog?
>
Missed it.Updated patch below.

From: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Date: Tue, 24 Nov 2015 16:21:37 +0530
Subject: [PATCHv2 2/2] i2c: xiic: Implement Power management

Enable power management. This patch enables the clocks
before transfer and disables after the transfer.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
v2 changes:
changes the order clk and pm_runtime calls
bailout on clock_prepare_enable failure
there was a missout of the i2c->dev copy fix the same
by copying the device str at probe

 drivers/i2c/busses/i2c-xiic.c |   88 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 6efd200..74f54f2 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -37,6 +37,8 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/pm_runtime.h>

 #define DRIVER_NAME "xiic-i2c"

@@ -66,6 +68,7 @@ enum xiic_endian {
  * @endianness: big/little-endian byte order
  */
 struct xiic_i2c {
+ struct device *dev;
  void __iomem *base;
  wait_queue_head_t wait;
  struct i2c_adapter adap;
@@ -77,6 +80,7 @@ struct xiic_i2c {
  struct i2c_msg *rx_msg;
  int rx_pos;
  enum xiic_endian endianness;
+ struct clk *clk;
 };


@@ -164,6 +168,7 @@ struct xiic_i2c {

 #define XIIC_RESET_MASK             0xAUL

+#define XIIC_PM_TIMEOUT 1000 /* ms */
 /*
  * The following constant is used for the device global interrupt enable
  * register, to enable all interrupts for the device, this is the only bit
@@ -676,9 +681,13 @@ static int xiic_xfer(struct i2c_adapter *adap,
struct i2c_msg *msgs, int num)
  dev_dbg(adap->dev.parent, "%s entry SR: 0x%x\n", __func__,
  xiic_getreg8(i2c, XIIC_SR_REG_OFFSET));

+ err = pm_runtime_get_sync(i2c->dev);
+ if (err < 0)
+ return err;
+
  err = xiic_busy(i2c);
  if (err)
- return err;
+ goto out;

  i2c->tx_msg = msgs;
  i2c->nmsgs = num;
@@ -686,14 +695,20 @@ static int xiic_xfer(struct i2c_adapter *adap,
struct i2c_msg *msgs, int num)
  xiic_start_xfer(i2c);

  if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
- (i2c->state == STATE_DONE), HZ))
- return (i2c->state == STATE_DONE) ? num : -EIO;
- else {
+ (i2c->state == STATE_DONE), HZ)) {
+ err = (i2c->state == STATE_DONE) ? num : -EIO;
+ goto out;
+ } else {
  i2c->tx_msg = NULL;
  i2c->rx_msg = NULL;
  i2c->nmsgs = 0;
- return -ETIMEDOUT;
+ err = -ETIMEDOUT;
+ goto out;
  }
+out:
+ pm_runtime_mark_last_busy(i2c->dev);
+ pm_runtime_put_autosuspend(i2c->dev);
+ return err;
 }

 static u32 xiic_func(struct i2c_adapter *adap)
@@ -748,13 +763,28 @@ static int xiic_i2c_probe(struct platform_device *pdev)
  mutex_init(&i2c->lock);
  init_waitqueue_head(&i2c->wait);

+ i2c->clk = devm_clk_get(&pdev->dev, NULL);
+ if (IS_ERR(i2c->clk)) {
+ dev_err(&pdev->dev, "input clock not found.\n");
+ return PTR_ERR(i2c->clk);
+ }
+ ret = clk_prepare_enable(i2c->clk);
+ if (ret) {
+ dev_err(&pdev->dev, "Unable to enable clock.\n");
+ return ret;
+ }
+ i2c->dev = &pdev->dev;
+ pm_runtime_enable(i2c->dev);
+ pm_runtime_set_autosuspend_delay(i2c->dev, XIIC_PM_TIMEOUT);
+ pm_runtime_use_autosuspend(i2c->dev);
+ pm_runtime_set_active(i2c->dev);
  ret = devm_request_threaded_irq(&pdev->dev, irq, xiic_isr,
  xiic_process, IRQF_ONESHOT,
  pdev->name, i2c);

  if (ret < 0) {
  dev_err(&pdev->dev, "Cannot claim IRQ\n");
- return ret;
+ goto err_clk_dis;
  }

  /*
@@ -776,7 +806,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
  if (ret) {
  dev_err(&pdev->dev, "Failed to add adapter\n");
  xiic_deinit(i2c);
- return ret;
+ goto err_clk_dis;
  }

  if (pdata) {
@@ -786,16 +816,30 @@ static int xiic_i2c_probe(struct platform_device *pdev)
  }

  return 0;
+
+err_clk_dis:
+ pm_runtime_set_suspended(&pdev->dev);
+ pm_runtime_disable(&pdev->dev);
+ clk_disable_unprepare(i2c->clk);
+ return ret;
 }

 static int xiic_i2c_remove(struct platform_device *pdev)
 {
  struct xiic_i2c *i2c = platform_get_drvdata(pdev);
+ int ret;

  /* remove adapter & data */
  i2c_del_adapter(&i2c->adap);

+ ret = clk_prepare_enable(i2c->clk);
+ if (ret) {
+ dev_err(&pdev->dev, "Unable to enable clock.\n");
+ return ret;
+ }
  xiic_deinit(i2c);
+ clk_disable_unprepare(i2c->clk);
+ pm_runtime_disable(&pdev->dev);

  return 0;
 }
@@ -808,12 +852,42 @@ static const struct of_device_id xiic_of_match[] = {
 MODULE_DEVICE_TABLE(of, xiic_of_match);
 #endif

+static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
+{
+ struct platform_device *pdev = to_platform_device(dev);
+ struct xiic_i2c *i2c = platform_get_drvdata(pdev);
+
+ clk_disable(i2c->clk);
+
+ return 0;
+}
+
+static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
+{
+ struct platform_device *pdev = to_platform_device(dev);
+ struct xiic_i2c *i2c = platform_get_drvdata(pdev);
+ int ret;
+
+ ret = clk_enable(i2c->clk);
+ if (ret) {
+ dev_err(dev, "Cannot enable clock.\n");
+ return ret;
+ }
+
+ return 0;
+}
+
+static const struct dev_pm_ops xiic_dev_pm_ops = {
+ SET_RUNTIME_PM_OPS(cdns_i2c_runtime_suspend,
+   cdns_i2c_runtime_resume, NULL)
+};
 static struct platform_driver xiic_i2c_driver = {
  .probe   = xiic_i2c_probe,
  .remove  = xiic_i2c_remove,
  .driver  = {
  .name = DRIVER_NAME,
  .of_match_table = of_match_ptr(xiic_of_match),
+ .pm = &xiic_dev_pm_ops,
  },
 };

-- 
1.7.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
