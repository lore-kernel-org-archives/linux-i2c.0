From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v3 1/2] i2c: Add SDA and SCL pin numbers to i2c platform
 data
Date: Tue, 12 Jan 2010 16:47:11 +0530
Message-ID: <1263295031.3437.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>From cb3347e45449ff16a332aa164eae24ef6a2432e6 Mon Sep 17 00:00:00 2001
From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Date: Mon, 11 Jan 2010 15:53:31 +0530
Subject: [PATCH 1/2] Add SDA and SCL pin numbers to i2c platform data

Patch adds SDA and SCL pin numbers to the i2c platform data
structure for Davinci DM355 and DM6446. This at present is
used for i2c bus recovery.
TODO: Add SDA and SCL pin number information to include all
Davinci platforms such as dm355-leopard, dm365, dm646x, da8xx etc.

Signed-off-by: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
---
 arch/arm/mach-davinci/board-dm355-evm.c  |    2 ++
 arch/arm/mach-davinci/board-dm644x-evm.c |    2 ++
 arch/arm/mach-davinci/include/mach/i2c.h |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 077ecf4..aa48e3f 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -111,6 +111,8 @@ static struct platform_device davinci_nand_device = {
 static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_freq	= 400	/* kHz */,
 	.bus_delay	= 0	/* usec */,
+	.sda_pin        = 15,
+	.scl_pin        = 14,
 };
 
 static struct snd_platform_data dm355_evm_snd_data;
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index e9612cf..976e11b 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -629,6 +629,8 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_freq	= 20 /* kHz */,
 	.bus_delay	= 100 /* usec */,
+	.sda_pin        = 44,
+	.scl_pin        = 43,
 };
 
 static void __init evm_init_i2c(void)
diff --git a/arch/arm/mach-davinci/include/mach/i2c.h b/arch/arm/mach-davinci/include/mach/i2c.h
index c248e9b..39fdcea 100644
--- a/arch/arm/mach-davinci/include/mach/i2c.h
+++ b/arch/arm/mach-davinci/include/mach/i2c.h
@@ -16,6 +16,8 @@
 struct davinci_i2c_platform_data {
 	unsigned int	bus_freq;	/* standard bus frequency (kHz) */
 	unsigned int	bus_delay;	/* post-transaction delay (usec) */
+	unsigned int    sda_pin;        /* GPIO pin ID to use for SDA */
+	unsigned int    scl_pin;        /* GPIO pin ID to use for SCL */
 };
 
 /* for board setup code */
-- 
1.6.3.3.MVISTA
