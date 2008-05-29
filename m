From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 2/8] I2C: S3C2410: Add MODULE_ALIAS() for s3c2440
	device.
Date: Thu, 29 May 2008 14:22:46 +0100
Message-ID: <20080529132406.186957190@fluff.org.uk>
References: <20080529132244.818543231@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-drivers-i2c-s3c2410-fixmodalias.patch
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

Add a MODULE_ALIAS() statement for the i2c-s3c2410 controller
to ensure that it can be autoloaded on the S3C2440 systems that
we support.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.26-rc4-quilt1/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux-2.6.26-rc4-quilt1.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-05-28 11:56:54.000000000 +0100
+++ linux-2.6.26-rc4-quilt1/drivers/i2c/busses/i2c-s3c2410.c	2008-05-28 11:57:12.000000000 +0100
@@ -947,3 +947,4 @@ MODULE_DESCRIPTION("S3C24XX I2C Bus driv
 MODULE_AUTHOR("Ben Dooks, <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:s3c2410-i2c");
+MODULE_ALIAS("platform:s3c2440-i2c");

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
