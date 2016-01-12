From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] i2c: designware: remove redundant lock
Date: Tue, 12 Jan 2016 15:16:35 +0200
Message-ID: <f7d81178a0e65a19872a9e5207ccd8553e15c07d.1452604595.git.baruch@tkos.co.il>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:57292 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934137AbcALNSe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 12 Jan 2016 08:18:34 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Rongrong Zou <zourongrong@gmail.com>, Baruch Siach <baruch@tkos.co.il>

The per adapter bus_lock already projects from concurrent calls to the
master_xfer callback. No need to add a driver internal lock.

Also, rephrase a comment to drop mention of this lock.

Reported-by: Rongrong Zou <zourongrong@gmail.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
Based on i2c/for-next.
Build tested only.
---
 drivers/i2c/busses/i2c-designware-core.c | 14 ++++++--------
 drivers/i2c/busses/i2c-designware-core.h |  2 --
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index ba9732c236c5..99bc950f5d9d 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -634,7 +634,6 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
 
-	mutex_lock(&dev->lock);
 	pm_runtime_get_sync(dev->dev);
 
 	reinit_completion(&dev->cmd_complete);
@@ -673,11 +672,12 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	}
 
 	/*
-	 * We must disable the adapter before unlocking the &dev->lock mutex
-	 * below. Otherwise the hardware might continue generating interrupts
-	 * which in turn causes a race condition with the following transfer.
-	 * Needs some more investigation if the additional interrupts are
-	 * a hardware bug or this driver doesn't handle them correctly yet.
+	 * We must disable the adapter before returning and signaling the end
+	 * of the current transfer. Otherwise the hardware might continue
+	 * generating interrupts which in turn causes a race condition with
+	 * the following transfer.  Needs some more investigation if the
+	 * additional interrupts are a hardware bug or this driver doesn't
+	 * handle them correctly yet.
 	 */
 	__i2c_dw_enable(dev, false);
 
@@ -706,7 +706,6 @@ done:
 done_nolock:
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
-	mutex_unlock(&dev->lock);
 
 	return ret;
 }
@@ -860,7 +859,6 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	int r;
 
 	init_completion(&dev->cmd_complete);
-	mutex_init(&dev->lock);
 
 	r = i2c_dw_init(dev);
 	if (r)
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9ffb63a60f95..cd409e7fbc71 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -36,7 +36,6 @@
  * @dev: driver model device node
  * @base: IO registers pointer
  * @cmd_complete: tx completion indicator
- * @lock: protect this struct and IO registers
  * @clk: input reference clock
  * @cmd_err: run time hadware error code
  * @msgs: points to an array of messages currently being transfered
@@ -73,7 +72,6 @@ struct dw_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;
 	struct completion	cmd_complete;
-	struct mutex		lock;
 	struct clk		*clk;
 	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
 	struct dw_pci_controller *controller;
-- 
2.6.4
