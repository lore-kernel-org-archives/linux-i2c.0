From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC PATCH] i2c-designware-core: disable adapter before fill dev structure
Date: Fri,  7 Jun 2013 12:30:01 +0300
Message-ID: <1370597401-22501-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <CAHp75VfwSTO7UoEGVpd7qdFVSFNYrBG6aXx1Oj8UAkgbmi=1XQ@mail.gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VfwSTO7UoEGVpd7qdFVSFNYrBG6aXx1Oj8UAkgbmi=1XQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index c41ca63..a1d3d95 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -366,9 +366,6 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	struct i2c_msg *msgs = dev->msgs;
 	u32 ic_con;
 
-	/* Disable the adapter */
-	__i2c_dw_enable(dev, false);
-
 	/* set the slave (target) address */
 	dw_writel(dev, msgs[dev->msg_write_idx].addr, DW_IC_TAR);
 
@@ -561,6 +558,13 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	mutex_lock(&dev->lock);
 	pm_runtime_get_sync(dev->dev);
 
+	ret = i2c_dw_wait_bus_not_busy(dev);
+	if (ret < 0)
+		goto done;
+
+	/* Disable the adapter */
+	__i2c_dw_enable(dev, false);
+
 	INIT_COMPLETION(dev->cmd_complete);
 	dev->msgs = msgs;
 	dev->msgs_num = num;
@@ -572,10 +576,6 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	dev->abort_source = 0;
 	dev->rx_outstanding = 0;
 
-	ret = i2c_dw_wait_bus_not_busy(dev);
-	if (ret < 0)
-		goto done;
-
 	/* start the transfers */
 	i2c_dw_xfer_init(dev);
 
-- 
1.8.2.rc0.22.gb3600c3
