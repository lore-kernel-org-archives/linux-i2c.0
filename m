From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 02/16] i2c: mux-gpio: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:39 -0500
Message-ID: <1354049993-12718-3-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 3b7bc06..9f50ef0 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -53,14 +53,14 @@ static int i2c_mux_gpio_deselect(struct i2c_adapter *adap, void *data, u32 chan)
 	return 0;
 }
 
-static int __devinit match_gpio_chip_by_label(struct gpio_chip *chip,
+static int match_gpio_chip_by_label(struct gpio_chip *chip,
 					      void *data)
 {
 	return !strcmp(chip->label, data);
 }
 
 #ifdef CONFIG_OF
-static int __devinit i2c_mux_gpio_probe_dt(struct gpiomux *mux,
+static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 					struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -125,14 +125,14 @@ static int __devinit i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 	return 0;
 }
 #else
-static int __devinit i2c_mux_gpio_probe_dt(struct gpiomux *mux,
+static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 					struct platform_device *pdev)
 {
 	return 0;
 }
 #endif
 
-static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
+static int i2c_mux_gpio_probe(struct platform_device *pdev)
 {
 	struct gpiomux *mux;
 	struct i2c_adapter *parent;
@@ -239,7 +239,7 @@ alloc_failed:
 	return ret;
 }
 
-static int __devexit i2c_mux_gpio_remove(struct platform_device *pdev)
+static int i2c_mux_gpio_remove(struct platform_device *pdev)
 {
 	struct gpiomux *mux = platform_get_drvdata(pdev);
 	int i;
@@ -256,7 +256,7 @@ static int __devexit i2c_mux_gpio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id i2c_mux_gpio_of_match[] __devinitconst = {
+static const struct of_device_id i2c_mux_gpio_of_match[] = {
 	{ .compatible = "i2c-mux-gpio", },
 	{},
 };
@@ -264,7 +264,7 @@ MODULE_DEVICE_TABLE(of, i2c_mux_gpio_of_match);
 
 static struct platform_driver i2c_mux_gpio_driver = {
 	.probe	= i2c_mux_gpio_probe,
-	.remove	= __devexit_p(i2c_mux_gpio_remove),
+	.remove	= i2c_mux_gpio_remove,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "i2c-mux-gpio",
-- 
1.8.0.1
