From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH 1/5] I2C driver for MXC
Date: Wed, 1 Apr 2009 13:58:21 +0200
Message-ID: <200904011358.21191.hs4233@mail.mn-solutions.de>
References: <49C89E13.7040801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <49C89E13.7040801@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Darius <augulis.darius@gmail.com>, linux-i2c@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

[PATCH] imx21: activate i2c

Set the correct clkdev-name for the i2c clock.

It also get's rid of the ARCH_NR_GPIOS define on the rationale
that isn't an ARCH-wide setting anyway. If a device has two
pca953x devices, the reserved number will be wrong.

Signed-off-by: Holger Schurig <hs4233@mail.mn-solutions.de>

---

This patch applies on top Darius' patch "[PATCH 1/5] I2C driver for MXC" from
24th march.

--- linux.orig/arch/arm/plat-mxc/include/mach/mx21.h
+++ linux/arch/arm/plat-mxc/include/mach/mx21.h
@@ -54,9 +54,6 @@
 
 #define IRAM_BASE_ADDR          0xFFFFE800	/* internal ram */
 
-/* this CPU supports up to 192 GPIOs (don't forget the baseboard!) */
-#define ARCH_NR_GPIOS		(6*32 + 16)
-
 /* fixed interrupt numbers */
 #define MXC_INT_USBCTRL         58
 #define MXC_INT_USBCTRL         58
--- linux.orig/arch/arm/mach-mx2/clock_imx21.c
+++ linux/arch/arm/mach-mx2/clock_imx21.c
@@ -931,7 +931,7 @@
 	_REGISTER_CLOCK(NULL, "slcdc", slcdc_clk[0])
 	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
 	_REGISTER_CLOCK(NULL, "gpio", gpio_clk)
-	_REGISTER_CLOCK(NULL, "i2c", i2c_clk)
+	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
 	_REGISTER_CLOCK("mxc-keypad", NULL, kpp_clk)
 	_REGISTER_CLOCK(NULL, "owire", owire_clk)
 	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)




-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
