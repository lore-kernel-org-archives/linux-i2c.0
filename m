From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: i2c-s3c2410: fix check for being in suspend.
Date: Fri, 31 Oct 2008 15:42:21 +0000
Message-ID: <20081031154221.295466680@fluff.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=simtec/i2c-fix-sleep-usage.patch
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As noted by Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>, we can never
trigger the check for being in suspend due to the result
of !readl(i2c->regs + S3C2410_IICCON) & S3C2410_IICCON_IRQEN
always being 0.

Add suspend/resume hooks to stop i2c transactions happening
until the driver has been resumed.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux.git/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux.git.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-10-31 15:07:10.000000000 +0000
+++ linux.git/drivers/i2c/busses/i2c-s3c2410.c	2008-10-31 15:14:14.000000000 +0000
@@ -56,6 +56,7 @@ enum s3c24xx_i2c_state {
 struct s3c24xx_i2c {
 	spinlock_t		lock;
 	wait_queue_head_t	wait;
+	unsigned int		suspended:1;
 
 	struct i2c_msg		*msg;
 	unsigned int		msg_num;
@@ -507,7 +508,7 @@ static int s3c24xx_i2c_doxfer(struct s3c
 	unsigned long timeout;
 	int ret;
 
-	if (!(readl(i2c->regs + S3C2410_IICCON) & S3C2410_IICCON_IRQEN))
+	if (i2c->suspended)
 		return -EIO;
 
 	ret = s3c24xx_i2c_set_master(i2c);
@@ -986,17 +987,26 @@ static int s3c24xx_i2c_remove(struct pla
 }
 
 #ifdef CONFIG_PM
+static int s3c24xx_i2c_suspend_late(struct platform_device *dev,
+				    pm_message_t msg)
+{
+	struct s3c24xx_i2c *i2c = platform_get_drvdata(dev);
+	i2c->suspended = 1;
+	return 0;
+}
+
 static int s3c24xx_i2c_resume(struct platform_device *dev)
 {
 	struct s3c24xx_i2c *i2c = platform_get_drvdata(dev);
 
-	if (i2c != NULL)
-		s3c24xx_i2c_init(i2c);
+	i2c->suspended = 0;
+	s3c24xx_i2c_init(i2c);
 
 	return 0;
 }
 
 #else
+#define s3c24xx_i2c_suspend_late NULL
 #define s3c24xx_i2c_resume NULL
 #endif
 
@@ -1005,6 +1015,7 @@ static int s3c24xx_i2c_resume(struct pla
 static struct platform_driver s3c2410_i2c_driver = {
 	.probe		= s3c24xx_i2c_probe,
 	.remove		= s3c24xx_i2c_remove,
+	.suspend_late	= s3c24xx_i2c_suspend_late,
 	.resume		= s3c24xx_i2c_resume,
 	.driver		= {
 		.owner	= THIS_MODULE,
@@ -1015,6 +1026,7 @@ static struct platform_driver s3c2410_i2
 static struct platform_driver s3c2440_i2c_driver = {
 	.probe		= s3c24xx_i2c_probe,
 	.remove		= s3c24xx_i2c_remove,
+	.suspend_late	= s3c24xx_i2c_suspend_late,
 	.resume		= s3c24xx_i2c_resume,
 	.driver		= {
 		.owner	= THIS_MODULE,

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
