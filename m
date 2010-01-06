From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 3/4] i2c: davinci: Add suspend/resume support
Date: Wed,  6 Jan 2010 14:54:59 +0530
Message-ID: <1262769900-2710-4-git-send-email-chaithrika@ti.com>
References: <1262769900-2710-1-git-send-email-chaithrika@ti.com>
	<1262769900-2710-2-git-send-email-chaithrika@ti.com>
	<1262769900-2710-3-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1262769900-2710-3-git-send-email-chaithrika-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add suspend and resume callbacks to DaVinci I2C driver.
This has been tested on DA850/OMAP-L138 EVM. The SoC specific
suspend-to-RAM support patch series [1] is needed to test this feature.

[1] http://linux.davincidsp.com/pipermail/davinci-linux-open-source/
2009-November/016958.html

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 81c1049..d2a4844 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -622,6 +622,41 @@ static int davinci_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int davinci_i2c_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct davinci_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
+
+	/* put I2C into reset */
+	davinci_i2c_reset_ctrl(i2c_dev, 0);
+	clk_disable(i2c_dev->clk);
+
+	return 0;
+}
+
+static int davinci_i2c_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct davinci_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
+
+	clk_enable(i2c_dev->clk);
+	/* take I2C out of reset */
+	davinci_i2c_reset_ctrl(i2c_dev, 1);
+
+	return 0;
+}
+
+static struct dev_pm_ops davinci_i2c_pm = {
+	.suspend        = davinci_i2c_suspend,
+	.resume         = davinci_i2c_resume,
+};
+
+#define davinci_i2c_pm_ops (&davinci_i2c_pm)
+#else
+#define davinci_i2c_pm_ops NULL
+#endif
+
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:i2c_davinci");
 
@@ -631,6 +666,7 @@ static struct platform_driver davinci_i2c_driver = {
 	.driver		= {
 		.name	= "i2c_davinci",
 		.owner	= THIS_MODULE,
+		.pm	= davinci_i2c_pm_ops,
 	},
 };
 
-- 
1.5.6
