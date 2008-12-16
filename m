From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [next] i2c-s3c2410: Allow more than one i2c-s3c2410 adapter
Date: Tue, 16 Dec 2008 21:04:42 +0000
Message-ID: <1229461483-1747-5-git-send-email-ben-linux@fluff.org>
References: <1229461483-1747-1-git-send-email-ben-linux@fluff.org>
 <1229461483-1747-2-git-send-email-ben-linux@fluff.org>
 <1229461483-1747-3-git-send-email-ben-linux@fluff.org>
 <1229461483-1747-4-git-send-email-ben-linux@fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1229461483-1747-4-git-send-email-ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Newer SoCs such as the S3C6410 have 2 instances of this i2c
controller block in and thus require the ability to create
two seperate busses from this.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/busses/i2c-s3c2410.c |   33 +++++++++++++++++++--------------
 1 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index d6343e2..f14007f 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -559,19 +559,6 @@ static const struct i2c_algorithm s3c24xx_i2c_algorithm = {
 	.functionality		= s3c24xx_i2c_func,
 };
 
-static struct s3c24xx_i2c s3c24xx_i2c = {
-	.lock		= __SPIN_LOCK_UNLOCKED(s3c24xx_i2c.lock),
-	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER(s3c24xx_i2c.wait),
-	.tx_setup	= 50,
-	.adap		= {
-		.name			= "s3c2410-i2c",
-		.owner			= THIS_MODULE,
-		.algo			= &s3c24xx_i2c_algorithm,
-		.retries		= 2,
-		.class			= I2C_CLASS_HWMON | I2C_CLASS_SPD,
-	},
-};
-
 /* s3c24xx_i2c_calcdivisor
  *
  * return the divisor settings for a given frequency
@@ -797,7 +784,7 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 
 static int s3c24xx_i2c_probe(struct platform_device *pdev)
 {
-	struct s3c24xx_i2c *i2c = &s3c24xx_i2c;
+	struct s3c24xx_i2c *i2c;
 	struct s3c2410_platform_i2c *pdata;
 	struct resource *res;
 	int ret;
@@ -808,6 +795,22 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	i2c = kzalloc(sizeof(struct s3c24xx_i2c), GFP_KERNEL);
+	if (!i2c) {
+		dev_err(&pdev->dev, "no memory for state\n");
+		return -ENOMEM;
+	}
+
+	strlcpy(i2c->adap.name, "s3c2410-i2c", sizeof(i2c->adap.name));
+	i2c->adap.owner   = THIS_MODULE;
+	i2c->adap.algo    = &s3c24xx_i2c_algorithm;
+	i2c->adap.retries = 2;
+	i2c->adap.class   = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	i2c->tx_setup     = 50;
+
+	spin_lock_init(&i2c->lock);
+	init_waitqueue_head(&i2c->wait);
+
 	/* find the clock and enable it */
 
 	i2c->dev = &pdev->dev;
@@ -929,6 +932,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	clk_put(i2c->clk);
 
  err_noclk:
+	kfree(i2c);
 	return ret;
 }
 
@@ -953,6 +957,7 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
 
 	release_resource(i2c->ioarea);
 	kfree(i2c->ioarea);
+	kfree(i2c);
 
 	return 0;
 }
-- 
1.5.6.5
