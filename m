From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [next] i2c-s3c2410: Use platform data for gpio configuration
Date: Tue, 16 Dec 2008 21:04:40 +0000
Message-ID: <1229461483-1747-3-git-send-email-ben-linux@fluff.org>
References: <1229461483-1747-1-git-send-email-ben-linux@fluff.org>
 <1229461483-1747-2-git-send-email-ben-linux@fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1229461483-1747-2-git-send-email-ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add a callback to set the gpio configuration for the
i2c device instead of a set include. This also allows
the remvoal of the machine gpio and hardware files.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/busses/i2c-s3c2410.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index f5efece..0aa0142 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -35,11 +35,9 @@
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 
-#include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 
-#include <mach/regs-gpio.h>
 #include <asm/plat-s3c/regs-iic.h>
 #include <asm/plat-s3c/iic.h>
 
@@ -489,9 +487,6 @@ static int s3c24xx_i2c_set_master(struct s3c24xx_i2c *i2c)
 		msleep(1);
 	}
 
-	dev_dbg(i2c->dev, "timeout: GPEDAT is %08x\n",
-		__raw_readl(S3C2410_GPEDAT));
-
 	return -ETIMEDOUT;
 }
 
@@ -783,12 +778,12 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 
 	/* get the plafrom data */
 
-	pdata = s3c24xx_i2c_get_platformdata(i2c->adap.dev.parent);
+	pdata = s3c24xx_i2c_get_platformdata(i2c->dev);
 
 	/* inititalise the gpio */
 
-	s3c2410_gpio_cfgpin(S3C2410_GPE15, S3C2410_GPE15_IICSDA);
-	s3c2410_gpio_cfgpin(S3C2410_GPE14, S3C2410_GPE14_IICSCL);
+	if (pdata->cfg_gpio)
+		pdata->cfg_gpio(to_platform_device(i2c->dev));
 
 	/* write slave address */
 
-- 
1.5.6.5
