From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] i2c: davinci: Add suspend/resume support
Date: Mon,  7 Dec 2009 14:58:55 +0530
Message-ID: <1260178136-26416-3-git-send-email-chaithrika@ti.com>
References: <1260178136-26416-1-git-send-email-chaithrika@ti.com>
 <1260178136-26416-2-git-send-email-chaithrika@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1260178136-26416-2-git-send-email-chaithrika-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add suspend and resume callbacks to DaVinci I2C driver.
This has been tested on DA850/OMAP-L138 EVM. The SoC specific
suspend-to-RAM support patch series [1] is needed to test this feature.

[1] http://linux.davincidsp.com/pipermail/davinci-linux-open-source/
2009-November/016958.html

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 5f3838c..5f0888d 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -623,6 +623,36 @@ static int davinci_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int davinci_i2c_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct davinci_i2c_dev *dev = platform_get_drvdata(pdev);
+
+	/* put I2C into reset */
+	davinci_i2c_reset_ctrl(dev, 0);
+
+	clk_disable(dev->clk);
+
+	return 0;
+}
+
+static int davinci_i2c_resume(struct platform_device *pdev)
+{
+	struct davinci_i2c_dev *dev = platform_get_drvdata(pdev);
+
+	clk_enable(dev->clk);
+
+	/* take I2C out of reset */
+	davinci_i2c_reset_ctrl(dev, 1);
+
+	return 0;
+}
+
+#else
+#define davinci_i2c_suspend NULL
+#define davinci_i2c_resume NULL
+#endif
+
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:i2c_davinci");
 
@@ -633,6 +663,8 @@ static struct platform_driver davinci_i2c_driver = {
 		.name	= "i2c_davinci",
 		.owner	= THIS_MODULE,
 	},
+	.suspend	= davinci_i2c_suspend,
+	.resume		= davinci_i2c_resume,
 };
 
 /* I2C may be needed to bring up other drivers */
-- 
1.5.6
