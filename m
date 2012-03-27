From: Karol Lewandowski <k.lewandowsk@samsung.com>
Subject: [PATCH 2/2] i2c: Dynamically assign adapter id if it wasn't explictly
 specified
Date: Tue, 27 Mar 2012 11:10:28 +0200
Message-ID: <1332839428-29705-3-git-send-email-k.lewandowsk@samsung.com>
References: <1332839428-29705-1-git-send-email-k.lewandowsk@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1332839428-29705-1-git-send-email-k.lewandowsk@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: w.sang@pengutronix.de
Cc: ben-linux@fluff.org, m.szyprowski@samsung.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, kyungmin.park@samsung.com, hskinnemoen@gmail.com, bigeasy@linutronix.de, dirk.brandewie@gmail.com, linux@arm.linux.org.uk, Karol Lewandowski <k.lewandowsk@samsung.com>
List-Id: linux-i2c@vger.kernel.org

Commit 488bf314b ("i2c: Allow i2c_add_numbered_adapter() to assign a
bus id") reworked i2c_add_numbered_adapter() to call i2c_add_adapter()
if requested bus was -1.

This allows to simplify driver's initialization procedure by using
just one function for static and dynamic adapter id registration.

This patch updates few more drivers (missed out in original patch)
to use this functionality.

Signed-off-by: Karol Lewandowski <k.lewandowsk@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/i2c/busses/i2c-gpio.c         |    7 +------
 drivers/i2c/busses/i2c-pca-platform.c |    2 +-
 drivers/i2c/busses/i2c-versatile.c    |    9 ++-------
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index a651779..50a2a94 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -144,12 +144,7 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
 	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->dev.parent = &pdev->dev;
 
-	/*
-	 * If "dev->id" is negative we consider it as zero.
-	 * The reason to do so is to avoid sysfs names that only make
-	 * sense when there are multiple adapters.
-	 */
-	adap->nr = (pdev->id != -1) ? pdev->id : 0;
+	adap->nr = pdev->id;
 	ret = i2c_bit_add_numbered_bus(adap);
 	if (ret)
 		goto err_add_bus;
diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 2adbf1a..675878f 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -171,7 +171,7 @@ static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
 	i2c->io_size = resource_size(res);
 	i2c->irq = irq;
 
-	i2c->adap.nr = pdev->id >= 0 ? pdev->id : 0;
+	i2c->adap.nr = pdev->id;
 	i2c->adap.owner = THIS_MODULE;
 	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
 		 "PCA9564/PCA9665 at 0x%08lx",
diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-versatile.c
index 6055601..9458568 100644
--- a/drivers/i2c/busses/i2c-versatile.c
+++ b/drivers/i2c/busses/i2c-versatile.c
@@ -102,13 +102,8 @@ static int i2c_versatile_probe(struct platform_device *dev)
 	i2c->algo = i2c_versatile_algo;
 	i2c->algo.data = i2c;
 
-	if (dev->id >= 0) {
-		/* static bus numbering */
-		i2c->adap.nr = dev->id;
-		ret = i2c_bit_add_numbered_bus(&i2c->adap);
-	} else
-		/* dynamic bus numbering */
-		ret = i2c_bit_add_bus(&i2c->adap);
+	i2c->adap.nr = dev->id;
+	ret = i2c_bit_add_numbered_bus(&i2c->adap);
 	if (ret >= 0) {
 		platform_set_drvdata(dev, i2c);
 		return 0;
-- 
1.7.9.1
