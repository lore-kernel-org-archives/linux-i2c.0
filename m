From: Vasanth Ananthan <vasanthananthan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: s3c2410 : Add polling mode support
Date: Tue, 29 Jan 2013 20:59:34 +0530
Message-ID: <1359473374-31890-1-git-send-email-vasanthananthan@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Vasanth Ananthan <vasanthananthan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vasanth Ananthan <vasanth.a-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch adds polling mode support for i2c-s3c2410 driver.
The I2C_SATAPHY controller in exynos5250 lacks an interrupt
line and the i2c-s3c2410 driver is only interrupt driven, thus
a polling mode support is required in the driver for supporting
this controller. This patch adds this support to the driver.
The SATAPHY bus is an internal bus with I2C controller as master
and SATA PHY controller as the slave.

Signed-off-by: Vasanth Ananthan <vasanth.a-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-s3c2410.txt        |    2 +
 drivers/i2c/busses/i2c-s3c2410.c                   |   68 ++++++++++++++++----
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt b/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
index f98d4c5..805a383 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
@@ -10,6 +10,8 @@ Required properties:
           inside HDMIPHY block found on several samsung SoCs
       (d) "samsung, exynos5440-i2c", for s3c2440-like i2c used
 	   on EXYNOS5440 which does not need GPIO configuration.
+      (e) "samsung, exynos5-sata-phy-i2c", for s3c2440-like i2c used as
+	   a host to SATA PHY controller on an internal bus.
   - reg: physical base address of the controller and length of memory mapped
     region.
   - interrupts: interrupt number to the cpu.
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 5e33df7..88d8e5e 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -49,6 +49,7 @@
 #define QUIRK_S3C2440		(1 << 0)
 #define QUIRK_HDMIPHY		(1 << 1)
 #define QUIRK_NO_GPIO		(1 << 2)
+#define QUIRK_POLL		(1 << 3)
 
 /* Max time to wait for bus to become idle after a xfer (in us) */
 #define S3C2410_IDLE_TIMEOUT	5000
@@ -105,6 +106,8 @@ static struct platform_device_id s3c24xx_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, s3c24xx_driver_ids);
 
+static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat);
+
 #ifdef CONFIG_OF
 static const struct of_device_id s3c24xx_i2c_match[] = {
 	{ .compatible = "samsung,s3c2410-i2c", .data = (void *)0 },
@@ -113,6 +116,8 @@ static const struct of_device_id s3c24xx_i2c_match[] = {
 	  .data = (void *)(QUIRK_S3C2440 | QUIRK_HDMIPHY | QUIRK_NO_GPIO) },
 	{ .compatible = "samsung,exynos5440-i2c",
 	  .data = (void *)(QUIRK_S3C2440 | QUIRK_NO_GPIO) },
+	{ .compatible = "samsung,exynos5-sata-phy-i2c",
+	  .data = (void *)(QUIRK_S3C2440 | QUIRK_POLL | QUIRK_NO_GPIO) },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_i2c_match);
@@ -151,7 +156,8 @@ static inline void s3c24xx_i2c_master_complete(struct s3c24xx_i2c *i2c, int ret)
 	if (ret)
 		i2c->msg_idx = ret;
 
-	wake_up(&i2c->wait);
+	if (!(i2c->quirks & QUIRK_POLL))
+		wake_up(&i2c->wait);
 }
 
 static inline void s3c24xx_i2c_disable_ack(struct s3c24xx_i2c *i2c)
@@ -188,6 +194,22 @@ static inline void s3c24xx_i2c_enable_irq(struct s3c24xx_i2c *i2c)
 	writel(tmp | S3C2410_IICCON_IRQEN, i2c->regs + S3C2410_IICCON);
 }
 
+static bool is_ack(struct s3c24xx_i2c *i2c)
+{
+	u32 time_out = i2c->tx_setup;
+
+	while (--time_out) {
+		if (readl(i2c->regs + S3C2410_IICCON)
+			& S3C2410_IICCON_IRQPEND) {
+			if (!(readl(i2c->regs + S3C2410_IICSTAT)
+				& S3C2410_IICSTAT_LASTBIT))
+				return true;
+		}
+		udelay(time_out);
+	}
+
+	return false;
+}
 
 /* s3c24xx_i2c_message_start
  *
@@ -232,6 +254,16 @@ static void s3c24xx_i2c_message_start(struct s3c24xx_i2c *i2c,
 
 	stat |= S3C2410_IICSTAT_START;
 	writel(stat, i2c->regs + S3C2410_IICSTAT);
+
+	if (i2c->quirks & QUIRK_POLL) {
+		while ((i2c->msg_num != 0) && is_ack(i2c)) {
+			i2c_s3c_irq_nextbyte(i2c, stat);
+			stat = readl(i2c->regs + S3C2410_IICSTAT);
+
+			if (stat & S3C2410_IICSTAT_ARBITR)
+				dev_err(i2c->dev, "deal with arbitration loss\n");
+		}
+	}
 }
 
 static inline void s3c24xx_i2c_stop(struct s3c24xx_i2c *i2c, int ret)
@@ -630,6 +662,15 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 	s3c24xx_i2c_enable_irq(i2c);
 	s3c24xx_i2c_message_start(i2c, msgs);
 
+	if (i2c->quirks & QUIRK_POLL) {
+		ret = i2c->msg_idx;
+
+		if (ret != num)
+			dev_dbg(i2c->dev, "incomplete xfer (%d)\n", ret);
+
+		goto out;
+	}
+
 	timeout = wait_event_timeout(i2c->wait, i2c->msg_num == 0, HZ * 5);
 
 	ret = i2c->msg_idx;
@@ -775,6 +816,9 @@ static int s3c24xx_i2c_clockrate(struct s3c24xx_i2c *i2c, unsigned int *got)
 	if (div1 == 512)
 		iiccon |= S3C2410_IICCON_TXDIV_512;
 
+	if (i2c->quirks & QUIRK_POLL)
+		iiccon |= S3C2410_IICCON_SCALE(2);
+
 	writel(iiccon, i2c->regs + S3C2410_IICCON);
 
 	if (i2c->quirks & QUIRK_S3C2440) {
@@ -1079,18 +1123,20 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	 * ensure no current IRQs pending
 	 */
 
-	i2c->irq = ret = platform_get_irq(pdev, 0);
-	if (ret <= 0) {
-		dev_err(&pdev->dev, "cannot find IRQ\n");
-		return ret;
-	}
+	if (!(i2c->quirks & QUIRK_POLL)) {
+		i2c->irq = ret = platform_get_irq(pdev, 0);
+		if (ret <= 0) {
+			dev_err(&pdev->dev, "cannot find IRQ\n");
+			return ret;
+		}
 
-	ret = devm_request_irq(&pdev->dev, i2c->irq, s3c24xx_i2c_irq, 0,
-			       dev_name(&pdev->dev), i2c);
+		ret = devm_request_irq(&pdev->dev, i2c->irq, s3c24xx_i2c_irq, 0,
+				dev_name(&pdev->dev), i2c);
 
-	if (ret != 0) {
-		dev_err(&pdev->dev, "cannot claim IRQ %d\n", i2c->irq);
-		return ret;
+		if (ret != 0) {
+			dev_err(&pdev->dev, "cannot claim IRQ %d\n", i2c->irq);
+			return ret;
+		}
 	}
 
 	ret = s3c24xx_i2c_register_cpufreq(i2c);
-- 
1.7.9.5
