From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=201/4=5D=20MXS=3A=20Allow=20passing=20i2c=20bus=20speed=20via=20platform=20data?=
Date: Tue,  1 May 2012 04:00:18 +0200
Message-ID: <1335837621-14816-2-git-send-email-marex@denx.de>
References: <1335837621-14816-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335837621-14816-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Pass the I2C speed via platform data. This patch only adds the necessar=
y
facilities for the passing and fixes the board files to work with them.
The subsequent patch for i2c-mxs.c then implements the speed adjustment=
=2E

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
CC: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 arch/arm/mach-mxs/devices-mx28.h                |    3 ++-
 arch/arm/mach-mxs/devices/platform-mxs-i2c.c    |    9 ++++++---
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 +++-
 arch/arm/mach-mxs/mach-apx4devkit.c             |    7 ++++++-
 arch/arm/mach-mxs/mach-m28evk.c                 |    8 ++++++--
 arch/arm/mach-mxs/mach-mx28evk.c                |    7 ++++++-
 arch/arm/mach-mxs/mach-tx28.c                   |    7 ++++++-
 include/linux/i2c/mxs-i2c.h                     |   21 +++++++++++++++=
++++++
 8 files changed, 56 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/i2c/mxs-i2c.h

diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devic=
es-mx28.h
index 9dbeae1..8b3e735 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -39,7 +39,8 @@ extern const struct mxs_gpmi_nand_data mx28_gpmi_nand=
_data __initconst;
 	mxs_add_gpmi_nand(pdata, &mx28_gpmi_nand_data)
=20
 extern const struct mxs_mxs_i2c_data mx28_mxs_i2c_data[] __initconst;
-#define mx28_add_mxs_i2c(id)		mxs_add_mxs_i2c(&mx28_mxs_i2c_data[id])
+#define mx28_add_mxs_i2c(id, pdata)	\
+	mxs_add_mxs_i2c(&mx28_mxs_i2c_data[id], pdata)
=20
 extern const struct mxs_mxs_mmc_data mx28_mxs_mmc_data[] __initconst;
 #define mx28_add_mxs_mmc(id, pdata) \
diff --git a/arch/arm/mach-mxs/devices/platform-mxs-i2c.c b/arch/arm/ma=
ch-mxs/devices/platform-mxs-i2c.c
index 79222ec..bb325b9 100644
--- a/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
+++ b/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
@@ -9,6 +9,7 @@
 #include <asm/sizes.h>
 #include <mach/mx28.h>
 #include <mach/devices-common.h>
+#include <linux/i2c/mxs-i2c.h>
=20
 #define mxs_i2c_data_entry_single(soc, _id)				\
 	{								\
@@ -29,7 +30,8 @@ const struct mxs_mxs_i2c_data mx28_mxs_i2c_data[] __i=
nitconst =3D {
 #endif
=20
 struct platform_device *__init mxs_add_mxs_i2c(
-		const struct mxs_mxs_i2c_data *data)
+		const struct mxs_mxs_i2c_data *data,
+		const struct mxs_i2c_platform_data *pdata)
 {
 	struct resource res[] =3D {
 		{
@@ -47,6 +49,7 @@ struct platform_device *__init mxs_add_mxs_i2c(
 		},
 	};
=20
-	return mxs_add_platform_device("mxs-i2c", data->id, res,
-					ARRAY_SIZE(res), NULL, 0);
+	return mxs_add_platform_device("mxs-i2c", data->id,
+					res, ARRAY_SIZE(res),
+					pdata, sizeof(*pdata));
 }
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm=
/mach-mxs/include/mach/devices-common.h
index f2e3839..7bf2894 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -77,6 +77,7 @@ mxs_add_gpmi_nand(const struct gpmi_nand_platform_dat=
a *pdata,
 		const struct mxs_gpmi_nand_data *data);
=20
 /* i2c */
+#include <linux/i2c/mxs-i2c.h>
 struct mxs_mxs_i2c_data {
 	int id;
 	resource_size_t iobase;
@@ -84,7 +85,8 @@ struct mxs_mxs_i2c_data {
 	resource_size_t dmairq;
 };
 struct platform_device * __init mxs_add_mxs_i2c(
-		const struct mxs_mxs_i2c_data *data);
+		const struct mxs_mxs_i2c_data *data,
+		const struct mxs_i2c_platform_data *pdata);
=20
 /* mmc */
 #include <mach/mmc.h>
diff --git a/arch/arm/mach-mxs/mach-apx4devkit.c b/arch/arm/mach-mxs/ma=
ch-apx4devkit.c
index 48a7fab..cfa5390 100644
--- a/arch/arm/mach-mxs/mach-apx4devkit.c
+++ b/arch/arm/mach-mxs/mach-apx4devkit.c
@@ -26,6 +26,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 #include <linux/micrel_phy.h>
+#include <linux/i2c/mxs-i2c.h>
=20
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -146,6 +147,10 @@ static const struct i2c_board_info apx4devkit_i2c_=
boardinfo[] __initconst =3D {
 	{ I2C_BOARD_INFO("pcf8563", 0x51) }, /* RTC */
 };
=20
+static struct mxs_i2c_platform_data apx4devkit_i2c_pdata =3D {
+	.speed_khz =3D 100,
+};
+
 #if defined(CONFIG_REGULATOR_FIXED_VOLTAGE) || \
 		defined(CONFIG_REGULATOR_FIXED_VOLTAGE_MODULE)
 static struct regulator_consumer_supply apx4devkit_audio_consumer_supp=
lies[] =3D {
@@ -235,7 +240,7 @@ static void __init apx4devkit_init(void)
=20
 	apx4devkit_add_regulators();
=20
-	mx28_add_mxs_i2c(0);
+	mx28_add_mxs_i2c(0, &apx4devkit_i2c_pdata);
 	i2c_register_board_info(0, apx4devkit_i2c_boardinfo,
 			ARRAY_SIZE(apx4devkit_i2c_boardinfo));
=20
diff --git a/arch/arm/mach-mxs/mach-m28evk.c b/arch/arm/mach-mxs/mach-m=
28evk.c
index 06d7996..f8eb2b9 100644
--- a/arch/arm/mach-mxs/mach-m28evk.c
+++ b/arch/arm/mach-mxs/mach-m28evk.c
@@ -24,7 +24,7 @@
 #include <linux/clk.h>
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
-
+#include <linux/i2c/mxs-i2c.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -305,6 +305,10 @@ static struct i2c_board_info m28_stk5v3_i2c_boardi=
nfo[] __initdata =3D {
 	},
 };
=20
+static struct mxs_i2c_platform_data m28_i2c_pdata =3D {
+	.speed_khz	=3D 400,
+};
+
 static struct mxs_mmc_platform_data m28evk_mmc_pdata[] __initdata =3D =
{
 	{
 		/* mmc0 */
@@ -341,7 +345,7 @@ static void __init m28evk_init(void)
 	gpio_led_register_device(0, &m28evk_led_data);
=20
 	/* I2C */
-	mx28_add_mxs_i2c(0);
+	mx28_add_mxs_i2c(0, &m28_i2c_pdata);
 	i2c_register_board_info(0, m28_stk5v3_i2c_boardinfo,
 			ARRAY_SIZE(m28_stk5v3_i2c_boardinfo));
 }
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-=
mx28evk.c
index e386c14..a2792cf 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -20,6 +20,7 @@
 #include <linux/i2c.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
+#include <linux/i2c/mxs-i2c.h>
=20
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -349,6 +350,10 @@ static struct i2c_board_info mxs_i2c0_board_info[]=
 __initdata =3D {
 	},
 };
=20
+static struct mxs_i2c_platform_data mxs_i2c_pdata =3D {
+	.speed_khz =3D 100,
+};
+
 #if defined(CONFIG_REGULATOR_FIXED_VOLTAGE) || defined(CONFIG_REGULATO=
R_FIXED_VOLTAGE_MODULE)
 static struct regulator_consumer_supply mx28evk_audio_consumer_supplie=
s[] =3D {
 	REGULATOR_SUPPLY("VDDA", "0-000a"),
@@ -439,7 +444,7 @@ static void __init mx28evk_init(void)
 	mx28_add_saif(0, &mx28evk_mxs_saif_pdata[0]);
 	mx28_add_saif(1, &mx28evk_mxs_saif_pdata[1]);
=20
-	mx28_add_mxs_i2c(0);
+	mx28_add_mxs_i2c(0, &mxs_i2c_pdata);
 	i2c_register_board_info(0, mxs_i2c0_board_info,
 				ARRAY_SIZE(mxs_i2c0_board_info));
=20
diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx2=
8.c
index 2c0862e..9c85376 100644
--- a/arch/arm/mach-mxs/mach-tx28.c
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -15,6 +15,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_gpio.h>
 #include <linux/i2c.h>
+#include <linux/i2c/mxs-i2c.h>
=20
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -139,6 +140,10 @@ static struct i2c_board_info tx28_stk5v3_i2c_board=
info[] __initdata =3D {
 	},
 };
=20
+static struct mxs_i2c_platform_data tx28_i2c_pdata =3D {
+	.speed_khz =3D 100,
+};
+
 static struct mxs_mmc_platform_data tx28_mmc0_pdata __initdata =3D {
        .wp_gpio =3D -EINVAL,
        .flags =3D SLOTF_4_BIT_CAPABLE,
@@ -157,7 +162,7 @@ static void __init tx28_stk5v3_init(void)
 	spi_register_board_info(tx28_spi_board_info,
 			ARRAY_SIZE(tx28_spi_board_info));
 	gpio_led_register_device(0, &tx28_stk5v3_led_data);
-	mx28_add_mxs_i2c(0);
+	mx28_add_mxs_i2c(0, &tx28_i2c_pdata);
 	i2c_register_board_info(0, tx28_stk5v3_i2c_boardinfo,
 			ARRAY_SIZE(tx28_stk5v3_i2c_boardinfo));
 	mx28_add_mxs_mmc(0, &tx28_mmc0_pdata);
diff --git a/include/linux/i2c/mxs-i2c.h b/include/linux/i2c/mxs-i2c.h
new file mode 100644
index 0000000..781b080
--- /dev/null
+++ b/include/linux/i2c/mxs-i2c.h
@@ -0,0 +1,21 @@
+/*
+ * Freescale MXS I2C bus driver shared data
+ *
+ * Copyright (C) 2012
+ * Marek Vasut, DENX Software Engineering, <marex-ynQEQJNshbs@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef __INCLUDE_LINUX_I2C_MXS_I2C_H__
+#define __INCLUDE_LINUX_I2C_MXS_I2C_H__
+
+struct mxs_i2c_platform_data {
+	uint16_t	speed_khz;
+};
+
+#endif	/* __INCLUDE_LINUX_I2C_MXS_I2C_H__ */
--=20
1.7.10
