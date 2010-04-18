From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH V2] mach-pxa/viper: Fix timeout usage for I2C
Date: Sun, 18 Apr 2010 13:48:29 +0200
Message-ID: <1271591309-22567-1-git-send-email-w.sang@pengutronix.de>
References: <20100412213235.1688dda8@hyperion.delvare>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100412213235.1688dda8-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>, Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The timeout value is in jiffies, so it should be using HZ, not a plain
number. Assume with HZ=100 '100' means 1s here and adapt accordingly.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>
Cc: Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---

Changes since V1:

* Don't assume 100 means 100ms

Thanks for the comments!

Admitted, the first try was a really bad guess. Maybe I got distracted from the
previous patch for another arch where the value was 10000.

While this may still not be the favoured solution for Eric, I think it is at
least better than before, so it might be worth applying after all?

Janitorial fix, not tested due to no hardware.

 arch/arm/mach-pxa/viper.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 1dd1334..12cf38c 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -33,6 +33,7 @@
 #include <linux/pm.h>
 #include <linux/sched.h>
 #include <linux/gpio.h>
+#include <linux/jiffies.h>
 #include <linux/i2c-gpio.h>
 #include <linux/serial_8250.h>
 #include <linux/smc91x.h>
@@ -453,7 +454,7 @@ static struct i2c_gpio_platform_data i2c_bus_data = {
 	.sda_pin = VIPER_RTC_I2C_SDA_GPIO,
 	.scl_pin = VIPER_RTC_I2C_SCL_GPIO,
 	.udelay  = 10,
-	.timeout = 100,
+	.timeout = HZ,
 };
 
 static struct platform_device i2c_bus_device = {
@@ -778,7 +779,7 @@ static void __init viper_tpm_init(void)
 		.sda_pin = VIPER_TPM_I2C_SDA_GPIO,
 		.scl_pin = VIPER_TPM_I2C_SCL_GPIO,
 		.udelay  = 10,
-		.timeout = 100,
+		.timeout = HZ,
 	};
 	char *errstr;
 
-- 
1.7.0
