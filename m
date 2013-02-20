From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] I2C: i2c-pxa - remove incorrect __exit annotations
Date: Wed, 20 Feb 2013 00:50:10 -0800
Message-ID: <20130220085008.GA11025@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The remove() methods should not be marked __exit unless we are using
platform_driver_probe() which disables unbinding device from driver
via sysfs.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Compiled only, no hardware.

 drivers/i2c/busses/i2c-pxa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 1034d93..4a79e76 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1215,7 +1215,7 @@ emalloc:
 	return ret;
 }
 
-static int __exit i2c_pxa_remove(struct platform_device *dev)
+static int i2c_pxa_remove(struct platform_device *dev)
 {
 	struct pxa_i2c *i2c = platform_get_drvdata(dev);
 
@@ -1269,7 +1269,7 @@ static const struct dev_pm_ops i2c_pxa_dev_pm_ops = {
 
 static struct platform_driver i2c_pxa_driver = {
 	.probe		= i2c_pxa_probe,
-	.remove		= __exit_p(i2c_pxa_remove),
+	.remove		= i2c_pxa_remove,
 	.driver		= {
 		.name	= "pxa2xx-i2c",
 		.owner	= THIS_MODULE,
-- 
1.7.11.7


-- 
Dmitry
