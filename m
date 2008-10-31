From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 7/9] i2c-s3c2410: Allow more than one i2c-s3c2410 adapter
Date: Fri, 31 Oct 2008 16:04:27 +0000
Message-ID: <20081031160438.015437012@fluff.org.uk>
References: <20081031160420.164160051@fluff.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=simtec/s3c64xx/i2c-allow-multiple-instances.patch
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Newer SoCs such as the S3C6410 have 2 instances of this i2c
controller block in and thus require the ability to create
two seperate busses from this. 

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux.git/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux.git.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-10-31 11:56:08.000000000 +0000
+++ linux.git/drivers/i2c/busses/i2c-s3c2410.c	2008-10-31 11:56:12.000000000 +0000
@@ -560,19 +560,6 @@ static const struct i2c_algorithm s3c24x
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
@@ -798,7 +785,7 @@ static int s3c24xx_i2c_init(struct s3c24
 
 static int s3c24xx_i2c_probe(struct platform_device *pdev)
 {
-	struct s3c24xx_i2c *i2c = &s3c24xx_i2c;
+	struct s3c24xx_i2c *i2c;
 	struct s3c2410_platform_i2c *pdata;
 	struct resource *res;
 	int ret;
@@ -809,6 +796,22 @@ static int s3c24xx_i2c_probe(struct plat
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
@@ -930,6 +933,7 @@ static int s3c24xx_i2c_probe(struct plat
 	clk_put(i2c->clk);
 
  err_noclk:
+	kfree(i2c);
 	return ret;
 }
 
@@ -954,6 +958,7 @@ static int s3c24xx_i2c_remove(struct pla
 
 	release_resource(i2c->ioarea);
 	kfree(i2c->ioarea);
+	kfree(i2c);
 
 	return 0;
 }

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
