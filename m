From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: I2C device board info
Date: Mon, 20 Jul 2009 08:20:34 +0200
Message-ID: <20090720062034.GV2714@pengutronix.de>
References: <20090718105600.GA29887@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090718105600.GA29887-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jul 18, 2009 at 11:56:00AM +0100, Russell King - ARM Linux wrote:
> Sascha,
> 
> I've noticed the following in i2c_board_info initializers:
> 
> arch/arm/mach-mx2/pcm038.c:             I2C_BOARD_INFO("rtc-pcf8563", 0x51),
> arch/arm/mach-mx2/pcm038.c-             .type = "pcf8563"
> 
> However, I2C_BOARD_INFO is defined as:
> 
> #define I2C_BOARD_INFO(dev_type, dev_addr) \
>         .type = dev_type, .addr = (dev_addr)
> 
> so you're initializing .type twice.  Only one of these will be used,
> so you may want to correct these entries.  (Looking at Realview, the
> one which is used is the second - so in the above case, .type will
> be initialized with current gcc to "pcf8563" not "rtc-pcf8563".)
> 

Ok, here we go:

>From 89b5958a911ddcf1079e0dd6bbf2287f04c358d9 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Mon, 20 Jul 2009 08:18:47 +0200
Subject: [PATCH] ARM: mxc: Fix i2c_board_info definitions

Fix i2c_board_info definitions - we were defining the 'type' field
of these structures twice since the first argument of I2C_BOARD_INFO
sets this field.  Move the second definition into I2C_BOARD_INFO().

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 arch/arm/mach-mx1/mx1ads.c          |    6 ++----
 arch/arm/mach-mx2/eukrea_cpuimx27.c |    3 +--
 arch/arm/mach-mx2/pcm038.c          |   12 ++++--------
 arch/arm/mach-mx3/pcm037.c          |    3 +--
 arch/arm/mach-mx3/pcm043.c          |    3 +--
 5 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-mx1/mx1ads.c b/arch/arm/mach-mx1/mx1ads.c
index 6af064d..30f04e5 100644
--- a/arch/arm/mach-mx1/mx1ads.c
+++ b/arch/arm/mach-mx1/mx1ads.c
@@ -104,12 +104,10 @@ static struct imxi2c_platform_data mx1ads_i2c_data = {
 
 static struct i2c_board_info mx1ads_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("pcf857x", 0x22),
-		.type = "pcf8575",
+		I2C_BOARD_INFO("pcf8575", 0x22),
 		.platform_data = &pcf857x_data[0],
 	}, {
-		I2C_BOARD_INFO("pcf857x", 0x24),
-		.type = "pcf8575",
+		I2C_BOARD_INFO("pcf8575", 0x24),
 		.platform_data = &pcf857x_data[1],
 	},
 };
diff --git a/arch/arm/mach-mx2/eukrea_cpuimx27.c b/arch/arm/mach-mx2/eukrea_cpuimx27.c
index a2c4181..7b18760 100644
--- a/arch/arm/mach-mx2/eukrea_cpuimx27.c
+++ b/arch/arm/mach-mx2/eukrea_cpuimx27.c
@@ -135,8 +135,7 @@ static struct imxi2c_platform_data eukrea_cpuimx27_i2c_1_data = {
 
 static struct i2c_board_info eukrea_cpuimx27_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("rtc-pcf8563", 0x51),
-		.type = "pcf8563"
+		I2C_BOARD_INFO("pcf8563", 0x51),
 	},
 };
 
diff --git a/arch/arm/mach-mx2/pcm038.c b/arch/arm/mach-mx2/pcm038.c
index 638d078..9a3483c 100644
--- a/arch/arm/mach-mx2/pcm038.c
+++ b/arch/arm/mach-mx2/pcm038.c
@@ -186,17 +186,13 @@ static struct at24_platform_data board_eeprom = {
 };
 
 static struct i2c_board_info pcm038_i2c_devices[] = {
-	[0] = {
+	{
 		I2C_BOARD_INFO("at24", 0x52), /* E0=0, E1=1, E2=0 */
 		.platform_data = &board_eeprom,
-	},
-	[1] = {
-		I2C_BOARD_INFO("rtc-pcf8563", 0x51),
-		.type = "pcf8563"
-	},
-	[2] = {
+	}, {
+		I2C_BOARD_INFO("pcf8563", 0x51),
+	}, {
 		I2C_BOARD_INFO("lm75", 0x4a),
-		.type = "lm75"
 	}
 };
 
diff --git a/arch/arm/mach-mx3/pcm037.c b/arch/arm/mach-mx3/pcm037.c
index 6a3a1a9..d307887 100644
--- a/arch/arm/mach-mx3/pcm037.c
+++ b/arch/arm/mach-mx3/pcm037.c
@@ -266,8 +266,7 @@ static struct i2c_board_info pcm037_i2c_devices[] = {
 		I2C_BOARD_INFO("at24", 0x52), /* E0=0, E1=1, E2=0 */
 		.platform_data = &board_eeprom,
 	}, {
-		I2C_BOARD_INFO("rtc-pcf8563", 0x51),
-		.type = "pcf8563",
+		I2C_BOARD_INFO("pcf8563", 0x51),
 	}
 };
 #endif
diff --git a/arch/arm/mach-mx3/pcm043.c b/arch/arm/mach-mx3/pcm043.c
index 7c7d3cc..e43276e 100644
--- a/arch/arm/mach-mx3/pcm043.c
+++ b/arch/arm/mach-mx3/pcm043.c
@@ -133,8 +133,7 @@ static struct i2c_board_info pcm043_i2c_devices[] = {
 		I2C_BOARD_INFO("at24", 0x52), /* E0=0, E1=1, E2=0 */
 		.platform_data = &board_eeprom,
 	}, {
-		I2C_BOARD_INFO("rtc-pcf8563", 0x51),
-		.type = "pcf8563",
+		I2C_BOARD_INFO("pcf8563", 0x51),
 	}
 };
 #endif
-- 
1.6.3.3

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
