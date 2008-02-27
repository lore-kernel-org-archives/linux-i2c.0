From: Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [2.6 patch] I2C_ELEKTOR must depend on HAS_IOPORT
Date: Wed, 27 Feb 2008 09:37:28 +0200
Message-ID: <20080227073728.GD10603@cs181133002.pp.htv.fi>
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
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch fixes the following compile error on m32r:

<--  snip  -->

...
  CC [M]  drivers/i2c/busses/i2c-elektor.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/i2c/busses/i2c-elektor.c: In function 'pcf_isa_setbyte':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/i2c/busses/i2c-elektor.c:80: error: implicit declaration of function 'iowrite8'
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/i2c/busses/i2c-elektor.c: In function 'pcf_isa_getbyte':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/i2c/busses/i2c-elektor.c:90: error: implicit declaration of function 'ioread8'
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/i2c/busses/i2c-elektor.c: In function 'pcf_isa_init':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/i2c/busses/i2c-elektor.c:153: error: implicit declaration of function 'ioport_map'
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/i2c/busses/i2c-elektor.c:153: warning: assignment makes pointer from integer without a cast
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/i2c/busses/i2c-elektor.c: In function 'elektor_probe':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/i2c/busses/i2c-elektor.c:290: error: implicit declaration of function 'ioport_unmap'
make[4]: *** [drivers/i2c/busses/i2c-elektor.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <adrian.bunk-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>

---
c8a75f0dd2390ae8c8f91c451ff6b0e113d0ebd0 diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 476b0bb..3bed6b9 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -129,7 +129,7 @@ config I2C_DAVINCI
 
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
-	depends on ISA && BROKEN_ON_SMP
+	depends on ISA && HAS_IOPORT && BROKEN_ON_SMP
 	select I2C_ALGOPCF
 	help
 	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
