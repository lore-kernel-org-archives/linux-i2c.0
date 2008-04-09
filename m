From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.25-rc8] i2c: fix platform driver hotplug/coldplug
Date: Wed, 9 Apr 2008 13:54:07 -0700
Message-ID: <200804091354.07807.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
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
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>

Since 43cc71eed1250755986da4c0f9898f9a635cb3bf, the platform
modalias is prefixed with "platform:". Add MODULE_ALIAS() to the
hotpluggable I2C platform drivers, to allow module auto loading.

[ db: add some more drivers ]

Signed-off-by: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/i2c/busses/i2c-at91.c      |    2 +-
 drivers/i2c/busses/i2c-au1550.c    |    1 +
 drivers/i2c/busses/i2c-bfin-twi.c  |    1 +
 drivers/i2c/busses/i2c-davinci.c   |    3 +++
 drivers/i2c/busses/i2c-gpio.c      |    1 +
 drivers/i2c/busses/i2c-iop3xx.c    |    1 +
 drivers/i2c/busses/i2c-ixp2000.c   |    1 +
 drivers/i2c/busses/i2c-mpc.c       |    3 +++
 drivers/i2c/busses/i2c-ocores.c    |    3 +++
 drivers/i2c/busses/i2c-omap.c      |    1 +
 drivers/i2c/busses/i2c-pmcmsp.c    |    3 +++
 drivers/i2c/busses/i2c-pnx.c       |    1 +
 drivers/i2c/busses/i2c-powermac.c  |    3 +++
 drivers/i2c/busses/i2c-pxa.c       |    1 +
 drivers/i2c/busses/i2c-s3c2410.c   |    1 +
 drivers/i2c/busses/i2c-simtec.c    |    3 +++
 drivers/i2c/busses/i2c-versatile.c |    1 +
 17 files changed, 29 insertions(+), 1 deletion(-)

--- g26.orig/drivers/i2c/busses/i2c-at91.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-at91.c	2008-04-09 13:13:24.000000000 -0700
@@ -298,7 +298,7 @@ static int at91_i2c_resume(struct platfo
 #endif
 
 /* work with "modprobe at91_i2c" from hotplugging or coldplugging */
-MODULE_ALIAS("at91_i2c");
+MODULE_ALIAS("platform:at91_i2c");
 
 static struct platform_driver at91_i2c_driver = {
 	.probe		= at91_i2c_probe,
--- g26.orig/drivers/i2c/busses/i2c-au1550.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-au1550.c	2008-04-09 13:13:24.000000000 -0700
@@ -472,6 +472,7 @@ i2c_au1550_exit(void)
 MODULE_AUTHOR("Dan Malek, Embedded Edge, LLC.");
 MODULE_DESCRIPTION("SMBus adapter Alchemy pb1550");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:au1xpsc_smbus");
 
 module_init (i2c_au1550_init);
 module_exit (i2c_au1550_exit);
--- g26.orig/drivers/i2c/busses/i2c-bfin-twi.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-bfin-twi.c	2008-04-09 13:13:24.000000000 -0700
@@ -624,6 +624,7 @@ static void __exit i2c_bfin_twi_exit(voi
 MODULE_AUTHOR("Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for Blackfin TWI");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:i2c-bfin-twi");
 
 module_init(i2c_bfin_twi_init);
 module_exit(i2c_bfin_twi_exit);
--- g26.orig/drivers/i2c/busses/i2c-davinci.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-davinci.c	2008-04-09 13:13:24.000000000 -0700
@@ -558,6 +558,9 @@ static int davinci_i2c_remove(struct pla
 	return 0;
 }
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:i2c_davinci");
+
 static struct platform_driver davinci_i2c_driver = {
 	.probe		= davinci_i2c_probe,
 	.remove		= davinci_i2c_remove,
--- g26.orig/drivers/i2c/busses/i2c-gpio.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-gpio.c	2008-04-09 13:13:24.000000000 -0700
@@ -226,3 +226,4 @@ module_exit(i2c_gpio_exit);
 MODULE_AUTHOR("Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>");
 MODULE_DESCRIPTION("Platform-independent bitbanging I2C driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:i2c-gpio");
--- g26.orig/drivers/i2c/busses/i2c-iop3xx.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-iop3xx.c	2008-04-09 13:13:24.000000000 -0700
@@ -550,3 +550,4 @@ module_exit (i2c_iop3xx_exit);
 MODULE_AUTHOR("D-TACQ Solutions Ltd <www.d-tacq.com>");
 MODULE_DESCRIPTION("IOP3xx iic algorithm and driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:IOP3xx-I2C");
--- g26.orig/drivers/i2c/busses/i2c-ixp2000.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-ixp2000.c	2008-04-09 13:13:24.000000000 -0700
@@ -164,4 +164,5 @@ module_exit(ixp2000_i2c_exit);
 MODULE_AUTHOR ("Deepak Saxena <dsaxena-k7pgMgclrJvR7s880joybQ@public.gmane.org>");
 MODULE_DESCRIPTION("IXP2000 GPIO-based I2C bus driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:IXP2000-I2C");
 
--- g26.orig/drivers/i2c/busses/i2c-mpc.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-mpc.c	2008-04-09 13:13:24.000000000 -0700
@@ -392,6 +392,9 @@ static int fsl_i2c_remove(struct platfor
 	return 0;
 };
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:fsl-i2c");
+
 /* Structure for a device driver */
 static struct platform_driver fsl_i2c_driver = {
 	.probe = fsl_i2c_probe,
--- g26.orig/drivers/i2c/busses/i2c-ocores.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-ocores.c	2008-04-09 13:13:24.000000000 -0700
@@ -312,6 +312,9 @@ static int __devexit ocores_i2c_remove(s
 	return 0;
 }
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:ocores-i2c");
+
 static struct platform_driver ocores_i2c_driver = {
 	.probe  = ocores_i2c_probe,
 	.remove = __devexit_p(ocores_i2c_remove),
--- g26.orig/drivers/i2c/busses/i2c-omap.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-omap.c	2008-04-09 13:13:24.000000000 -0700
@@ -693,3 +693,4 @@ module_exit(omap_i2c_exit_driver);
 MODULE_AUTHOR("MontaVista Software, Inc. (and others)");
 MODULE_DESCRIPTION("TI OMAP I2C bus adapter");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:i2c_omap");
--- g26.orig/drivers/i2c/busses/i2c-pmcmsp.c	2008-04-09 13:03:24.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-pmcmsp.c	2008-04-09 13:13:24.000000000 -0700
@@ -627,6 +627,9 @@ static struct i2c_adapter pmcmsptwi_adap
 	.name		= DRV_NAME,
 };
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:" DRV_NAME);
+
 static struct platform_driver pmcmsptwi_driver = {
 	.probe  = pmcmsptwi_probe,
 	.remove	= __devexit_p(pmcmsptwi_remove),
--- g26.orig/drivers/i2c/busses/i2c-pnx.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-pnx.c	2008-04-09 13:13:24.000000000 -0700
@@ -697,6 +697,7 @@ static void __exit i2c_adap_pnx_exit(voi
 MODULE_AUTHOR("Vitaly Wool, Dennis Kovalev <source-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>");
 MODULE_DESCRIPTION("I2C driver for Philips IP3204-based I2C busses");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pnx-i2c");
 
 /* We need to make sure I2C is initialized before USB */
 subsys_initcall(i2c_adap_pnx_init);
--- g26.orig/drivers/i2c/busses/i2c-powermac.c	2008-04-09 13:03:24.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-powermac.c	2008-04-09 13:13:24.000000000 -0700
@@ -263,6 +263,9 @@ static int __devexit i2c_powermac_probe(
 }
 
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:i2c-powermac");
+
 static struct platform_driver i2c_powermac_driver = {
 	.probe = i2c_powermac_probe,
 	.remove = __devexit_p(i2c_powermac_remove),
--- g26.orig/drivers/i2c/busses/i2c-pxa.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-pxa.c	2008-04-09 13:13:24.000000000 -0700
@@ -1131,6 +1131,7 @@ static void __exit i2c_adap_pxa_exit(voi
 }
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pxa2xx-i2c");
 
 module_init(i2c_adap_pxa_init);
 module_exit(i2c_adap_pxa_exit);
--- g26.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-s3c2410.c	2008-04-09 13:13:24.000000000 -0700
@@ -948,3 +948,4 @@ module_exit(i2c_adap_s3c_exit);
 MODULE_DESCRIPTION("S3C24XX I2C Bus driver");
 MODULE_AUTHOR("Ben Dooks, <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:s3c2410-i2c");
--- g26.orig/drivers/i2c/busses/i2c-simtec.c	2008-04-09 13:03:24.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-simtec.c	2008-04-09 13:13:24.000000000 -0700
@@ -159,6 +159,9 @@ static int simtec_i2c_remove(struct plat
 
 /* device driver */
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:simtec-i2c");
+
 static struct platform_driver simtec_i2c_driver = {
 	.driver		= {
 		.name		= "simtec-i2c",
--- g26.orig/drivers/i2c/busses/i2c-versatile.c	2008-04-09 13:12:59.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-versatile.c	2008-04-09 13:13:24.000000000 -0700
@@ -151,3 +151,4 @@ module_exit(i2c_versatile_exit);
 
 MODULE_DESCRIPTION("ARM Versatile I2C bus driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:versatile-i2c");

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
