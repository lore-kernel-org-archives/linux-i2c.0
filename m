From: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2] i2c: s3c2410: Add fix for i2c suspend/resume
Date: Mon, 19 Nov 2012 14:30:26 +0530
Message-ID: <1353315626-31194-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The I2C driver makes a gpio_request during initialization. This request
happens again on resume and fails due to the earlier successful request.
Re-factor the code to only initialize the gpios during probe.

Errors on resume without this:
[   16.020000] s3c-i2c s3c2440-i2c.0: gpio [42] request failed
[   16.020000] s3c-i2c s3c2440-i2c.1: gpio [44] request failed
[   16.020000] s3c-i2c s3c2440-i2c.2: gpio [6] request failed

Signed-off-by: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
Changes from v1:
Refactor code to initialize gpios only during probe

 drivers/i2c/busses/i2c-s3c2410.c |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 081e261..0ca321b 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -856,6 +856,7 @@ static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
 			dev_err(i2c->dev, "invalid gpio[%d]: %d\n", idx, gpio);
 			goto free_gpio;
 		}
+		i2c->gpios[idx] = gpio;
 
 		ret = gpio_request(gpio, "i2c-bus");
 		if (ret) {
@@ -892,6 +893,18 @@ static void s3c24xx_i2c_dt_gpio_free(struct s3c24xx_i2c *i2c)
 }
 #endif
 
+static int s3c24xx_i2c_cfg_gpio(struct s3c24xx_i2c *i2c)
+{
+	struct s3c2410_platform_i2c *pdata = i2c->pdata;
+
+	if (pdata->cfg_gpio)
+		pdata->cfg_gpio(to_platform_device(i2c->dev));
+	else if (IS_ERR(i2c->pctrl) && s3c24xx_i2c_parse_dt_gpio(i2c))
+		return -EINVAL;
+
+	return 0;
+}
+
 /* s3c24xx_i2c_init
  *
  * initialise the controller, set the IO lines and frequency
@@ -907,13 +920,6 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 
 	pdata = i2c->pdata;
 
-	/* inititalise the gpio */
-
-	if (pdata->cfg_gpio)
-		pdata->cfg_gpio(to_platform_device(i2c->dev));
-	else if (IS_ERR(i2c->pctrl) && s3c24xx_i2c_parse_dt_gpio(i2c))
-		return -EINVAL;
-
 	/* write slave address */
 
 	writeb(pdata->slave_addr, i2c->regs + S3C2410_IICADD);
@@ -1054,6 +1060,12 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 
 	i2c->pctrl = devm_pinctrl_get_select_default(i2c->dev);
 
+	/* inititalise the i2c gpio lines */
+
+	ret = s3c24xx_i2c_cfg_gpio(i2c);
+	if (ret != 0)
+		goto err_clk;
+
 	/* initialise the i2c controller */
 
 	ret = s3c24xx_i2c_init(i2c);
-- 
1.6.6.1
