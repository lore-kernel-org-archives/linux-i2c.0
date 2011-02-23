From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [PULL] Please pull bjdooks' i2c fixes
Date: Wed, 23 Feb 2011 00:52:05 +0000
Message-ID: <E1Ps2xZ-0001nJ-1A@freya>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernrel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit d8204a37baf5474d3154eb536c936369be2bd5c0:
  Linus Torvalds (1):
        Merge branch 'urgent' of git://git.kernel.org/.../brodo/pcmcia-2.6

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-2639-rc4/i2c-fixes

Balaji T K (1):
      i2c-omap: fix build for !CONFIG_SUSPEND

Ben Dooks (1):
      i2c-omap: fixup commit cb527ede1bf6ff2008a025606f25344b8ed7b4ac whitespace

Kevin Hilman (1):
      i2c-omap: fix static suspend vs. runtime suspend

Richard woodruff (1):
      i2c-omap: Double clear of ARDY status in IRQ handler

Wolfram Sang (1):
      i2c-stu300: make sure adapter-name is terminated

 drivers/i2c/busses/i2c-omap.c   |   35 ++++++++++++++++++++++++++++++++++-
 drivers/i2c/busses/i2c-stu300.c |    2 +-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b605ff3..829a2a1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -847,11 +847,15 @@ complete:
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
 		}
+		/*
+		 * ProDB0017052: Clear ARDY bit twice
+		 */
 		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
 					OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, stat &
 				(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
-				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
+				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR |
+				OMAP_I2C_STAT_ARDY));
 			omap_i2c_complete_cmd(dev, err);
 			return IRQ_HANDLED;
 		}
@@ -1137,12 +1141,41 @@ omap_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_SUSPEND
+static int omap_i2c_suspend(struct device *dev)
+{
+	if (!pm_runtime_suspended(dev))
+		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
+			dev->bus->pm->runtime_suspend(dev);
+
+	return 0;
+}
+
+static int omap_i2c_resume(struct device *dev)
+{
+	if (!pm_runtime_suspended(dev))
+		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume)
+			dev->bus->pm->runtime_resume(dev);
+
+	return 0;
+}
+
+static struct dev_pm_ops omap_i2c_pm_ops = {
+	.suspend = omap_i2c_suspend,
+	.resume = omap_i2c_resume,
+};
+#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
+#else
+#define OMAP_I2C_PM_OPS NULL
+#endif
+
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
 	.remove		= omap_i2c_remove,
 	.driver		= {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
+		.pm	= OMAP_I2C_PM_OPS,
 	},
 };
 
diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 495be45..266135d 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -942,7 +942,7 @@ stu300_probe(struct platform_device *pdev)
 	adap->owner = THIS_MODULE;
 	/* DDC class but actually often used for more generic I2C */
 	adap->class = I2C_CLASS_DDC;
-	strncpy(adap->name, "ST Microelectronics DDC I2C adapter",
+	strlcpy(adap->name, "ST Microelectronics DDC I2C adapter",
 		sizeof(adap->name));
 	adap->nr = bus_nr;
 	adap->algo = &stu300_algo;
