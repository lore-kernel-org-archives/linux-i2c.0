From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 06/16] i2c: i2c-gpio: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:43 -0500
Message-ID: <1354049993-12718-7-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 257299a..f3fa433 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -85,7 +85,7 @@ static int i2c_gpio_getscl(void *data)
 	return gpio_get_value(pdata->scl_pin);
 }
 
-static int __devinit of_i2c_gpio_probe(struct device_node *np,
+static int of_i2c_gpio_probe(struct device_node *np,
 			     struct i2c_gpio_platform_data *pdata)
 {
 	u32 reg;
@@ -117,7 +117,7 @@ static int __devinit of_i2c_gpio_probe(struct device_node *np,
 	return 0;
 }
 
-static int __devinit i2c_gpio_probe(struct platform_device *pdev)
+static int i2c_gpio_probe(struct platform_device *pdev)
 {
 	struct i2c_gpio_private_data *priv;
 	struct i2c_gpio_platform_data *pdata;
@@ -218,7 +218,7 @@ err_request_sda:
 	return ret;
 }
 
-static int __devexit i2c_gpio_remove(struct platform_device *pdev)
+static int i2c_gpio_remove(struct platform_device *pdev)
 {
 	struct i2c_gpio_private_data *priv;
 	struct i2c_gpio_platform_data *pdata;
@@ -251,7 +251,7 @@ static struct platform_driver i2c_gpio_driver = {
 		.of_match_table	= of_match_ptr(i2c_gpio_dt_ids),
 	},
 	.probe		= i2c_gpio_probe,
-	.remove		= __devexit_p(i2c_gpio_remove),
+	.remove		= i2c_gpio_remove,
 };
 
 static int __init i2c_gpio_init(void)
-- 
1.8.0.1
