From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 4/8] I2C: S3C2410: Add a option of reducing the bus
	busy waiting time.
Date: Thu, 29 May 2008 14:22:48 +0100
Message-ID: <20080529132406.586501777@fluff.org.uk>
References: <20080529132244.818543231@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-drivers-i2c-s3c2410-singlemaster.patch
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

Add a single-master option to drasitcally reduce the time spent
waiting to check the bus is free and ready for another transfer.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.26-rc4-quilt2/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux-2.6.26-rc4-quilt2.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-05-28 12:27:38.000000000 +0100
+++ linux-2.6.26-rc4-quilt2/drivers/i2c/busses/i2c-s3c2410.c	2008-05-28 12:32:10.000000000 +0100
@@ -472,8 +472,15 @@ static irqreturn_t s3c24xx_i2c_irq(int i
 
 static int s3c24xx_i2c_set_master(struct s3c24xx_i2c *i2c)
 {
+	struct s3c2410_platform_i2c *pdata;
 	unsigned long iicstat;
-	int timeout = 400;
+	int timeout;
+
+	/* if we are a single master on this bus, reduce the delay awaiting
+	 * for bus traffic to a much lower value. */
+
+	pdata = s3c24xx_i2c_get_platformdata(i2c->dev);
+	timeout = (pdata->flags & S3C_IICFLG_SINGLE_MASTER) ? 10 : 400;
 
 	while (timeout-- > 0) {
 		iicstat = readl(i2c->regs + S3C2410_IICSTAT);
Index: linux-2.6.26-rc4-quilt2/include/asm-arm/plat-s3c/iic.h
===================================================================
--- linux-2.6.26-rc4-quilt2.orig/include/asm-arm/plat-s3c/iic.h	2008-05-28 12:28:00.000000000 +0100
+++ linux-2.6.26-rc4-quilt2/include/asm-arm/plat-s3c/iic.h	2008-05-28 12:32:10.000000000 +0100
@@ -13,7 +13,8 @@
 #ifndef __ASM_ARCH_IIC_H
 #define __ASM_ARCH_IIC_H __FILE__
 
-#define S3C_IICFLG_FILTER	(1<<0)	/* enable s3c2440 filter */
+#define S3C_IICFLG_FILTER	 (1<<0)	/* enable s3c2440 filter */
+#define S3C_IICFLG_SINGLE_MASTER (1<<1) /* s3c24xx is only bus master. */
 
 /* Notes:
  *	1) All frequencies are expressed in Hz

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
