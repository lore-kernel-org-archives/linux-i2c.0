From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 1/2] I2C: S3C2410: Pass the I2C bus number via drivers
	platform data
Date: Wed, 09 Jul 2008 13:51:48 +0100
Message-ID: <20080709125215.590626489@fluff.org>
References: <20080709125147.721679556@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-drivers-i2c-s3c2410-busnum.patch
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Allow the platform data to specify the bus bumber that the
new I2C bus will be given. This is to allow the use of the
board registration mechanism to specify the new style of
I2C device registration which allows boards to provide a
list of attached devices.

Note, as discussed on the mailing list, we have dropped
backwards compatibility of adding an dynamic bus number
as it should not affect most boards to have the bus pinned
to 0 if they have either not specified platform data for
driver. Any board supplying platform data will automatically
have the bus_num field set to 0, and anyone who needs the
driver on a different bus number can supply platform data
to set bus_num.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.26-rc4-quilt3/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux-2.6.26-rc4-quilt3.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-06-02 22:55:20.000000000 +0100
+++ linux-2.6.26-rc4-quilt3/drivers/i2c/busses/i2c-s3c2410.c	2008-06-02 22:55:29.000000000 +0100
@@ -752,9 +752,12 @@ static int s3c24xx_i2c_init(struct s3c24
 static int s3c24xx_i2c_probe(struct platform_device *pdev)
 {
 	struct s3c24xx_i2c *i2c = &s3c24xx_i2c;
+	struct s3c2410_platform_i2c *pdata;
 	struct resource *res;
 	int ret;
 
+	pdata = s3c24xx_i2c_get_platformdata(&pdev->dev);
+
 	/* find the clock and enable it */
 
 	i2c->dev = &pdev->dev;
@@ -832,7 +835,15 @@ static int s3c24xx_i2c_probe(struct plat
 	dev_dbg(&pdev->dev, "irq resource %p (%lu)\n", res,
 		(unsigned long)res->start);
 
-	ret = i2c_add_adapter(&i2c->adap);
+	/* Note, previous versions of the driver used i2c_add_adapter()
+	 * to add an bus at any number. We now pass the bus number via
+	 * the platform data, so if unset it will now default to always
+	 * being bus 0.
+	 */
+
+	i2c->adap.nr = pdata->bus_num;
+	ret = i2c_add_numbered_adapter(&i2c->adap);
+
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
 		goto err_irq;
Index: linux-2.6.26-rc4-quilt3/include/asm-arm/plat-s3c/iic.h
===================================================================
--- linux-2.6.26-rc4-quilt3.orig/include/asm-arm/plat-s3c/iic.h	2008-06-02 20:12:47.000000000 +0100
+++ linux-2.6.26-rc4-quilt3/include/asm-arm/plat-s3c/iic.h	2008-06-02 22:55:29.000000000 +0100
@@ -21,6 +21,7 @@
 */
 
 struct s3c2410_platform_i2c {
+	int		bus_num;	/* bus number to use */
 	unsigned int	flags;
 	unsigned int	slave_addr;	/* slave address for controller */
 	unsigned long	bus_freq;	/* standard bus frequency */

-- 

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
