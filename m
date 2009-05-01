From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c/chips: move max6875 to drivers/misc/eeprom
Date: Fri,  1 May 2009 22:23:29 +0200
Message-ID: <1241209409-29378-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This driver only reads the user EEPROM of that chip, so we can move it
to the eeprom-directory in order to further clean up (and later remove)
drivers/i2c/chips.

The Kconfig text was updated to match the current functionality,
dropping the meanwhile obsoleted parts.

Defconfigs have been adapted.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---

This is against linus-git of today. Jean, do you think such a patch 
can make it at this point of the release cycle? It is a bit
annoying because of all the defconfigs.

Ben, are you fine with these changes?

 arch/arm/configs/acs5k_defconfig                  |    2 +-
 arch/arm/configs/acs5k_tiny_defconfig             |    2 +-
 arch/arm/configs/afeb9260_defconfig               |    2 +-
 arch/arm/configs/ams_delta_defconfig              |    2 +-
 arch/arm/configs/at91cap9adk_defconfig            |    2 +-
 arch/arm/configs/at91rm9200dk_defconfig           |    2 +-
 arch/arm/configs/at91rm9200ek_defconfig           |    2 +-
 arch/arm/configs/at91sam9260ek_defconfig          |    2 +-
 arch/arm/configs/at91sam9261ek_defconfig          |    2 +-
 arch/arm/configs/at91sam9263ek_defconfig          |    2 +-
 arch/arm/configs/at91sam9rlek_defconfig           |    2 +-
 arch/arm/configs/ateb9200_defconfig               |    2 +-
 arch/arm/configs/cam60_defconfig                  |    2 +-
 arch/arm/configs/cm_x2xx_defconfig                |    2 +-
 arch/arm/configs/cm_x300_defconfig                |    2 +-
 arch/arm/configs/colibri_pxa270_defconfig         |    2 +-
 arch/arm/configs/corgi_defconfig                  |    2 +-
 arch/arm/configs/csb337_defconfig                 |    2 +-
 arch/arm/configs/csb637_defconfig                 |    2 +-
 arch/arm/configs/ecbat91_defconfig                |    2 +-
 arch/arm/configs/em_x270_defconfig                |    2 +-
 arch/arm/configs/ep93xx_defconfig                 |    2 +-
 arch/arm/configs/ezx_defconfig                    |    2 +-
 arch/arm/configs/iop13xx_defconfig                |    2 +-
 arch/arm/configs/iop32x_defconfig                 |    2 +-
 arch/arm/configs/iop33x_defconfig                 |    2 +-
 arch/arm/configs/ixp2000_defconfig                |    2 +-
 arch/arm/configs/ixp23xx_defconfig                |    2 +-
 arch/arm/configs/ixp4xx_defconfig                 |    2 +-
 arch/arm/configs/kafa_defconfig                   |    2 +-
 arch/arm/configs/kirkwood_defconfig               |    2 +-
 arch/arm/configs/loki_defconfig                   |    2 +-
 arch/arm/configs/magician_defconfig               |    2 +-
 arch/arm/configs/msm_defconfig                    |    2 +-
 arch/arm/configs/mv78xx0_defconfig                |    2 +-
 arch/arm/configs/mx1_defconfig                    |    2 +-
 arch/arm/configs/mx27_defconfig                   |    2 +-
 arch/arm/configs/mx3_defconfig                    |    2 +-
 arch/arm/configs/n770_defconfig                   |    2 +-
 arch/arm/configs/neocore926_defconfig             |    2 +-
 arch/arm/configs/omap3_beagle_defconfig           |    2 +-
 arch/arm/configs/omap3_pandora_defconfig          |    2 +-
 arch/arm/configs/omap_2430sdp_defconfig           |    2 +-
 arch/arm/configs/omap_3430sdp_defconfig           |    2 +-
 arch/arm/configs/omap_generic_1510_defconfig      |    2 +-
 arch/arm/configs/omap_generic_1610_defconfig      |    2 +-
 arch/arm/configs/omap_h2_1610_defconfig           |    2 +-
 arch/arm/configs/omap_h4_2420_defconfig           |    2 +-
 arch/arm/configs/omap_innovator_1510_defconfig    |    2 +-
 arch/arm/configs/omap_ldp_defconfig               |    2 +-
 arch/arm/configs/omap_osk_5912_defconfig          |    2 +-
 arch/arm/configs/onearm_defconfig                 |    2 +-
 arch/arm/configs/orion5x_defconfig                |    2 +-
 arch/arm/configs/overo_defconfig                  |    2 +-
 arch/arm/configs/palmz72_defconfig                |    2 +-
 arch/arm/configs/pcm027_defconfig                 |    2 +-
 arch/arm/configs/picotux200_defconfig             |    2 +-
 arch/arm/configs/pnx4008_defconfig                |    2 +-
 arch/arm/configs/qil-a9260_defconfig              |    2 +-
 arch/arm/configs/rpc_defconfig                    |    2 +-
 arch/arm/configs/rx51_defconfig                   |    2 +-
 arch/arm/configs/s3c2410_defconfig                |    2 +-
 arch/arm/configs/s3c6400_defconfig                |    2 +-
 arch/arm/configs/spitz_defconfig                  |    2 +-
 arch/arm/configs/sx1_defconfig                    |    2 +-
 arch/arm/configs/trizeps4_defconfig               |    2 +-
 arch/arm/configs/versatile_defconfig              |    2 +-
 arch/arm/configs/viper_defconfig                  |    2 +-
 arch/avr32/configs/atngw100_defconfig             |    2 +-
 arch/avr32/configs/atngw100_evklcd100_defconfig   |    2 +-
 arch/avr32/configs/atngw100_evklcd101_defconfig   |    2 +-
 arch/avr32/configs/atstk1002_defconfig            |    2 +-
 arch/avr32/configs/atstk1003_defconfig            |    2 +-
 arch/avr32/configs/atstk1006_defconfig            |    2 +-
 arch/avr32/configs/favr-32_defconfig              |    2 +-
 arch/avr32/configs/hammerhead_defconfig           |    2 +-
 arch/avr32/configs/merisc_defconfig               |    2 +-
 arch/avr32/configs/mimc200_defconfig              |    2 +-
 arch/blackfin/configs/BF518F-EZBRD_defconfig      |    2 +-
 arch/blackfin/configs/BF526-EZBRD_defconfig       |    2 +-
 arch/blackfin/configs/BF527-EZKIT_defconfig       |    2 +-
 arch/blackfin/configs/BF533-STAMP_defconfig       |    2 +-
 arch/blackfin/configs/BF537-STAMP_defconfig       |    2 +-
 arch/blackfin/configs/BF538-EZKIT_defconfig       |    2 +-
 arch/blackfin/configs/BF548-EZKIT_defconfig       |    2 +-
 arch/blackfin/configs/BlackStamp_defconfig        |    2 +-
 arch/blackfin/configs/CM-BF527_defconfig          |    2 +-
 arch/blackfin/configs/CM-BF548_defconfig          |    2 +-
 arch/blackfin/configs/PNAV-10_defconfig           |    2 +-
 arch/blackfin/configs/SRV1_defconfig              |    2 +-
 arch/ia64/configs/bigsur_defconfig                |    2 +-
 arch/ia64/configs/xen_domu_defconfig              |    2 +-
 arch/ia64/configs/zx1_defconfig                   |    2 +-
 arch/m32r/configs/m32104ut_defconfig              |    2 +-
 arch/mips/configs/bigsur_defconfig                |    2 +-
 arch/mips/configs/fulong_defconfig                |    2 +-
 arch/mips/configs/markeins_defconfig              |    2 +-
 arch/mips/configs/msp71xx_defconfig               |    2 +-
 arch/mips/configs/mtx1_defconfig                  |    2 +-
 arch/mips/configs/pnx8335-stb225_defconfig        |    2 +-
 arch/powerpc/configs/44x/canyonlands_defconfig    |    2 +-
 arch/powerpc/configs/44x/redwood_defconfig        |    2 +-
 arch/powerpc/configs/44x/sam440ep_defconfig       |    2 +-
 arch/powerpc/configs/44x/warp_defconfig           |    2 +-
 arch/powerpc/configs/52xx/cm5200_defconfig        |    2 +-
 arch/powerpc/configs/52xx/lite5200b_defconfig     |    2 +-
 arch/powerpc/configs/52xx/motionpro_defconfig     |    2 +-
 arch/powerpc/configs/52xx/pcm030_defconfig        |    2 +-
 arch/powerpc/configs/52xx/tqm5200_defconfig       |    2 +-
 arch/powerpc/configs/83xx/asp8347_defconfig       |    2 +-
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |    2 +-
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |    2 +-
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |    2 +-
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |    2 +-
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |    2 +-
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |    2 +-
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |    2 +-
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |    2 +-
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |    2 +-
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |    2 +-
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |    2 +-
 arch/powerpc/configs/83xx/sbc834x_defconfig       |    2 +-
 arch/powerpc/configs/85xx/socrates_defconfig      |    2 +-
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |    2 +-
 arch/powerpc/configs/85xx/tqm8540_defconfig       |    2 +-
 arch/powerpc/configs/85xx/tqm8541_defconfig       |    2 +-
 arch/powerpc/configs/85xx/tqm8548_defconfig       |    2 +-
 arch/powerpc/configs/85xx/tqm8555_defconfig       |    2 +-
 arch/powerpc/configs/85xx/tqm8560_defconfig       |    2 +-
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig     |    2 +-
 arch/powerpc/configs/86xx/gef_sbc310_defconfig    |    2 +-
 arch/powerpc/configs/86xx/gef_sbc610_defconfig    |    2 +-
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |    2 +-
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |    2 +-
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |    2 +-
 arch/powerpc/configs/amigaone_defconfig           |    2 +-
 arch/powerpc/configs/c2k_defconfig                |    2 +-
 arch/powerpc/configs/cell_defconfig               |    2 +-
 arch/powerpc/configs/celleb_defconfig             |    2 +-
 arch/powerpc/configs/chrp32_defconfig             |    2 +-
 arch/powerpc/configs/g5_defconfig                 |    2 +-
 arch/powerpc/configs/linkstation_defconfig        |    2 +-
 arch/powerpc/configs/maple_defconfig              |    2 +-
 arch/powerpc/configs/mpc5200_defconfig            |    2 +-
 arch/powerpc/configs/mpc83xx_defconfig            |    2 +-
 arch/powerpc/configs/mpc85xx_defconfig            |    2 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig        |    2 +-
 arch/powerpc/configs/mpc86xx_defconfig            |    2 +-
 arch/powerpc/configs/pasemi_defconfig             |    2 +-
 arch/powerpc/configs/pmac32_defconfig             |    2 +-
 arch/powerpc/configs/ppc40x_defconfig             |    2 +-
 arch/powerpc/configs/ppc44x_defconfig             |    2 +-
 arch/powerpc/configs/ppc64_defconfig              |    2 +-
 arch/powerpc/configs/ppc6xx_defconfig             |    2 +-
 arch/powerpc/configs/prpmc2800_defconfig          |    2 +-
 arch/powerpc/configs/pseries_defconfig            |    2 +-
 arch/powerpc/configs/storcenter_defconfig         |    2 +-
 arch/sh/configs/ap325rxa_defconfig                |    2 +-
 arch/sh/configs/cayman_defconfig                  |    2 +-
 arch/sh/configs/edosk7760_defconfig               |    2 +-
 arch/sh/configs/migor_defconfig                   |    2 +-
 arch/sh/configs/r7780mp_defconfig                 |    2 +-
 arch/sh/configs/r7785rp_defconfig                 |    2 +-
 arch/sh/configs/se7343_defconfig                  |    2 +-
 arch/sh/configs/sh7785lcr_32bit_defconfig         |    2 +-
 arch/sh/configs/sh7785lcr_defconfig               |    2 +-
 arch/sh/configs/shx3_defconfig                    |    2 +-
 arch/sh/configs/urquell_defconfig                 |    2 +-
 arch/sparc/configs/sparc64_defconfig              |    2 +-
 arch/x86/configs/i386_defconfig                   |    2 +-
 arch/x86/configs/x86_64_defconfig                 |    2 +-
 drivers/i2c/chips/Kconfig                         |   15 --
 drivers/i2c/chips/Makefile                        |    1 -
 drivers/i2c/chips/max6875.c                       |  246 ---------------------
 drivers/misc/eeprom/Kconfig                       |   14 ++
 drivers/misc/eeprom/Makefile                      |    1 +
 drivers/misc/eeprom/max6875.c                     |  246 +++++++++++++++++++++
 177 files changed, 432 insertions(+), 433 deletions(-)
 delete mode 100644 drivers/i2c/chips/max6875.c
 create mode 100644 drivers/misc/eeprom/max6875.c

diff --git a/arch/arm/configs/acs5k_defconfig b/arch/arm/configs/acs5k_defconfig
index 1cab4e7..55de73f 100644
--- a/arch/arm/configs/acs5k_defconfig
+++ b/arch/arm/configs/acs5k_defconfig
@@ -725,7 +725,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/acs5k_tiny_defconfig b/arch/arm/configs/acs5k_tiny_defconfig
index 8e3d084..05e3c2c 100644
--- a/arch/arm/configs/acs5k_tiny_defconfig
+++ b/arch/arm/configs/acs5k_tiny_defconfig
@@ -607,7 +607,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/afeb9260_defconfig b/arch/arm/configs/afeb9260_defconfig
index f7a272c..6d8f45b 100644
--- a/arch/arm/configs/afeb9260_defconfig
+++ b/arch/arm/configs/afeb9260_defconfig
@@ -725,7 +725,7 @@ CONFIG_EEPROM_AT24=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/ams_delta_defconfig b/arch/arm/configs/ams_delta_defconfig
index 7647325..5bb0306 100644
--- a/arch/arm/configs/ams_delta_defconfig
+++ b/arch/arm/configs/ams_delta_defconfig
@@ -773,7 +773,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
 # CONFIG_SENSORS_TLV320AIC23 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/arm/configs/at91cap9adk_defconfig b/arch/arm/configs/at91cap9adk_defconfig
index bc6bd9f..7753cff 100644
--- a/arch/arm/configs/at91cap9adk_defconfig
+++ b/arch/arm/configs/at91cap9adk_defconfig
@@ -680,7 +680,7 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/at91rm9200dk_defconfig b/arch/arm/configs/at91rm9200dk_defconfig
index 238b218..c5bbf49 100644
--- a/arch/arm/configs/at91rm9200dk_defconfig
+++ b/arch/arm/configs/at91rm9200dk_defconfig
@@ -641,7 +641,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_RTC8564 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_RTC_X1205_I2C is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/at91rm9200ek_defconfig b/arch/arm/configs/at91rm9200ek_defconfig
index 9f7a99a..2d5a18c 100644
--- a/arch/arm/configs/at91rm9200ek_defconfig
+++ b/arch/arm/configs/at91rm9200ek_defconfig
@@ -615,7 +615,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_RTC8564 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_RTC_X1205_I2C is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/at91sam9260ek_defconfig b/arch/arm/configs/at91sam9260ek_defconfig
index 98e2f3d..d026a5c 100644
--- a/arch/arm/configs/at91sam9260ek_defconfig
+++ b/arch/arm/configs/at91sam9260ek_defconfig
@@ -586,7 +586,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/at91sam9261ek_defconfig b/arch/arm/configs/at91sam9261ek_defconfig
index 1494561..6dc35c7 100644
--- a/arch/arm/configs/at91sam9261ek_defconfig
+++ b/arch/arm/configs/at91sam9261ek_defconfig
@@ -664,7 +664,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/at91sam9263ek_defconfig b/arch/arm/configs/at91sam9263ek_defconfig
index 21599f3..41c560b 100644
--- a/arch/arm/configs/at91sam9263ek_defconfig
+++ b/arch/arm/configs/at91sam9263ek_defconfig
@@ -674,7 +674,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/at91sam9rlek_defconfig b/arch/arm/configs/at91sam9rlek_defconfig
index e2df81a..4ff7708 100644
--- a/arch/arm/configs/at91sam9rlek_defconfig
+++ b/arch/arm/configs/at91sam9rlek_defconfig
@@ -570,7 +570,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/ateb9200_defconfig b/arch/arm/configs/ateb9200_defconfig
index a19e824..1dd9930 100644
--- a/arch/arm/configs/ateb9200_defconfig
+++ b/arch/arm/configs/ateb9200_defconfig
@@ -727,7 +727,7 @@ CONFIG_I2C_GPIO=m
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/arm/configs/cam60_defconfig b/arch/arm/configs/cam60_defconfig
index 8448108..99a4208 100644
--- a/arch/arm/configs/cam60_defconfig
+++ b/arch/arm/configs/cam60_defconfig
@@ -726,7 +726,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/cm_x2xx_defconfig b/arch/arm/configs/cm_x2xx_defconfig
index 797b790..b6927fc 100644
--- a/arch/arm/configs/cm_x2xx_defconfig
+++ b/arch/arm/configs/cm_x2xx_defconfig
@@ -1031,7 +1031,7 @@ CONFIG_I2C_PXA=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/cm_x300_defconfig b/arch/arm/configs/cm_x300_defconfig
index 227da08..466948d 100644
--- a/arch/arm/configs/cm_x300_defconfig
+++ b/arch/arm/configs/cm_x300_defconfig
@@ -769,7 +769,7 @@ CONFIG_I2C_PXA=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/colibri_pxa270_defconfig b/arch/arm/configs/colibri_pxa270_defconfig
index 4cf3bde..e0ae83a 100644
--- a/arch/arm/configs/colibri_pxa270_defconfig
+++ b/arch/arm/configs/colibri_pxa270_defconfig
@@ -884,7 +884,7 @@ CONFIG_I2C_HELPER_AUTO=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
index d6cd165..7d5306d 100644
--- a/arch/arm/configs/corgi_defconfig
+++ b/arch/arm/configs/corgi_defconfig
@@ -989,7 +989,7 @@ CONFIG_I2C_PXA=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/csb337_defconfig b/arch/arm/configs/csb337_defconfig
index 29f68c2..2a5c141 100644
--- a/arch/arm/configs/csb337_defconfig
+++ b/arch/arm/configs/csb337_defconfig
@@ -683,7 +683,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/csb637_defconfig b/arch/arm/configs/csb637_defconfig
index f7b60ce..f6cf84f 100644
--- a/arch/arm/configs/csb637_defconfig
+++ b/arch/arm/configs/csb637_defconfig
@@ -709,7 +709,7 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/ecbat91_defconfig b/arch/arm/configs/ecbat91_defconfig
index ca52073..d368c1e 100644
--- a/arch/arm/configs/ecbat91_defconfig
+++ b/arch/arm/configs/ecbat91_defconfig
@@ -725,7 +725,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/arm/configs/em_x270_defconfig b/arch/arm/configs/em_x270_defconfig
index e9955b7..69bd9f1 100644
--- a/arch/arm/configs/em_x270_defconfig
+++ b/arch/arm/configs/em_x270_defconfig
@@ -817,7 +817,7 @@ CONFIG_I2C_PXA=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 3f89d5f..eb2e04c 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -685,7 +685,7 @@ CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 CONFIG_I2C_DEBUG_CORE=y
 CONFIG_I2C_DEBUG_ALGO=y
 CONFIG_I2C_DEBUG_BUS=y
diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index d5ee16e..ef7eda4 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -882,7 +882,7 @@ CONFIG_I2C_PXA=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/iop13xx_defconfig b/arch/arm/configs/iop13xx_defconfig
index 89c1776..f1756ba 100644
--- a/arch/arm/configs/iop13xx_defconfig
+++ b/arch/arm/configs/iop13xx_defconfig
@@ -748,7 +748,7 @@ CONFIG_I2C_IOP3XX=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/iop32x_defconfig b/arch/arm/configs/iop32x_defconfig
index d70177b..341dd4c 100644
--- a/arch/arm/configs/iop32x_defconfig
+++ b/arch/arm/configs/iop32x_defconfig
@@ -851,7 +851,7 @@ CONFIG_I2C_IOP3XX=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/iop33x_defconfig b/arch/arm/configs/iop33x_defconfig
index eec4882..85e6be9 100644
--- a/arch/arm/configs/iop33x_defconfig
+++ b/arch/arm/configs/iop33x_defconfig
@@ -750,7 +750,7 @@ CONFIG_I2C_IOP3XX=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/ixp2000_defconfig b/arch/arm/configs/ixp2000_defconfig
index 57526c1..799f011 100644
--- a/arch/arm/configs/ixp2000_defconfig
+++ b/arch/arm/configs/ixp2000_defconfig
@@ -772,7 +772,7 @@ CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/arm/configs/ixp23xx_defconfig b/arch/arm/configs/ixp23xx_defconfig
index ef97561..23cdf81 100644
--- a/arch/arm/configs/ixp23xx_defconfig
+++ b/arch/arm/configs/ixp23xx_defconfig
@@ -904,7 +904,7 @@ CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
index 95cd8df..21f5996 100644
--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -1087,7 +1087,7 @@ CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/kafa_defconfig b/arch/arm/configs/kafa_defconfig
index 9f92fc5..f21cb11 100644
--- a/arch/arm/configs/kafa_defconfig
+++ b/arch/arm/configs/kafa_defconfig
@@ -607,7 +607,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index c367ae4..9de3862 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -983,7 +983,7 @@ CONFIG_I2C_MV64XXX=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/loki_defconfig b/arch/arm/configs/loki_defconfig
index b720fcf..e638d13 100644
--- a/arch/arm/configs/loki_defconfig
+++ b/arch/arm/configs/loki_defconfig
@@ -658,7 +658,7 @@ CONFIG_I2C_MV64XXX=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
index f56837f..3d91f31 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -759,7 +759,7 @@ CONFIG_I2C_PXA=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/msm_defconfig b/arch/arm/configs/msm_defconfig
index cc3b06e..c4a3c7f 100644
--- a/arch/arm/configs/msm_defconfig
+++ b/arch/arm/configs/msm_defconfig
@@ -585,7 +585,7 @@ CONFIG_I2C_MSM=y
 # CONFIG_SENSORS_PCA9539 is not set
 CONFIG_SENSORS_PCA9633=y
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 CONFIG_SENSORS_AKM8976=y
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index b069872..db4f90f 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -837,7 +837,7 @@ CONFIG_I2C_MV64XXX=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/mx1_defconfig b/arch/arm/configs/mx1_defconfig
index 0200d67..839eb62 100644
--- a/arch/arm/configs/mx1_defconfig
+++ b/arch/arm/configs/mx1_defconfig
@@ -623,7 +623,7 @@ CONFIG_I2C_IMX=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/mx27_defconfig b/arch/arm/configs/mx27_defconfig
index 083516c..cf12cf5 100644
--- a/arch/arm/configs/mx27_defconfig
+++ b/arch/arm/configs/mx27_defconfig
@@ -668,7 +668,7 @@ CONFIG_I2C_IMX=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/mx3_defconfig b/arch/arm/configs/mx3_defconfig
index 72a8201..6766eb3 100644
--- a/arch/arm/configs/mx3_defconfig
+++ b/arch/arm/configs/mx3_defconfig
@@ -633,7 +633,7 @@ CONFIG_I2C_IMX=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/n770_defconfig b/arch/arm/configs/n770_defconfig
index 672f6db..4a10da9 100644
--- a/arch/arm/configs/n770_defconfig
+++ b/arch/arm/configs/n770_defconfig
@@ -775,7 +775,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_TPS65010 is not set
 CONFIG_SENSORS_TLV320AIC23=y
 # CONFIG_GPIOEXPANDER_OMAP is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/neocore926_defconfig b/arch/arm/configs/neocore926_defconfig
index e0e4e98..f343606 100644
--- a/arch/arm/configs/neocore926_defconfig
+++ b/arch/arm/configs/neocore926_defconfig
@@ -780,7 +780,7 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index 4c6fb7e..fb54ebf 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -695,7 +695,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_ISP1301_OMAP is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/omap3_pandora_defconfig b/arch/arm/configs/omap3_pandora_defconfig
index b54ad2e..007fe9b 100644
--- a/arch/arm/configs/omap3_pandora_defconfig
+++ b/arch/arm/configs/omap3_pandora_defconfig
@@ -721,7 +721,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_ISP1301_OMAP is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/omap_2430sdp_defconfig b/arch/arm/configs/omap_2430sdp_defconfig
index 640e9af..e7ed10a 100644
--- a/arch/arm/configs/omap_2430sdp_defconfig
+++ b/arch/arm/configs/omap_2430sdp_defconfig
@@ -719,7 +719,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_GPIOEXPANDER_OMAP is not set
 CONFIG_TWL4030_CORE=y
 CONFIG_TWL4030_GPIO=y
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_MENELAUS is not set
 # CONFIG_I2C_DEBUG_CORE is not set
diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 8fb918d..95202a0 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -926,7 +926,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/omap_generic_1510_defconfig b/arch/arm/configs/omap_generic_1510_defconfig
index ccdc661..b42dab0 100644
--- a/arch/arm/configs/omap_generic_1510_defconfig
+++ b/arch/arm/configs/omap_generic_1510_defconfig
@@ -642,7 +642,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/omap_generic_1610_defconfig b/arch/arm/configs/omap_generic_1610_defconfig
index 0c42c89..97ec428 100644
--- a/arch/arm/configs/omap_generic_1610_defconfig
+++ b/arch/arm/configs/omap_generic_1610_defconfig
@@ -648,7 +648,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_ISP1301_OMAP is not set
 # CONFIG_TPS65010 is not set
 # CONFIG_GPIOEXPANDER_OMAP is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/omap_h2_1610_defconfig b/arch/arm/configs/omap_h2_1610_defconfig
index 74dbdc6..6abb0de 100644
--- a/arch/arm/configs/omap_h2_1610_defconfig
+++ b/arch/arm/configs/omap_h2_1610_defconfig
@@ -708,7 +708,7 @@ CONFIG_ISP1301_OMAP=y
 CONFIG_TPS65010=y
 # CONFIG_SENSORS_TLV320AIC23 is not set
 # CONFIG_GPIOEXPANDER_OMAP is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/omap_h4_2420_defconfig b/arch/arm/configs/omap_h4_2420_defconfig
index a4aab8e..b25d46a 100644
--- a/arch/arm/configs/omap_h4_2420_defconfig
+++ b/arch/arm/configs/omap_h4_2420_defconfig
@@ -690,7 +690,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_SENSORS_TLV320AIC23 is not set
 CONFIG_GPIOEXPANDER_OMAP=y
 # CONFIG_TWL4030_CORE is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 CONFIG_MENELAUS=y
 # CONFIG_I2C_DEBUG_CORE is not set
diff --git a/arch/arm/configs/omap_innovator_1510_defconfig b/arch/arm/configs/omap_innovator_1510_defconfig
index 0cfe363..8bcf7c1 100644
--- a/arch/arm/configs/omap_innovator_1510_defconfig
+++ b/arch/arm/configs/omap_innovator_1510_defconfig
@@ -636,7 +636,7 @@ CONFIG_I2C_BOARDINFO=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
index 679a4a3..ef216e7 100644
--- a/arch/arm/configs/omap_ldp_defconfig
+++ b/arch/arm/configs/omap_ldp_defconfig
@@ -657,7 +657,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_ISP1301_OMAP is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/omap_osk_5912_defconfig b/arch/arm/configs/omap_osk_5912_defconfig
index 6b3b5c6..7a0bbea 100644
--- a/arch/arm/configs/omap_osk_5912_defconfig
+++ b/arch/arm/configs/omap_osk_5912_defconfig
@@ -719,7 +719,7 @@ CONFIG_I2C_OMAP=y
 CONFIG_TPS65010=y
 # CONFIG_SENSORS_TLV320AIC23 is not set
 # CONFIG_GPIOEXPANDER_OMAP is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/onearm_defconfig b/arch/arm/configs/onearm_defconfig
index f8701fa..a42f29a 100644
--- a/arch/arm/configs/onearm_defconfig
+++ b/arch/arm/configs/onearm_defconfig
@@ -702,7 +702,7 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 020e6a8..a5ac3cb 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -892,7 +892,7 @@ CONFIG_I2C_MV64XXX=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/overo_defconfig b/arch/arm/configs/overo_defconfig
index a57f9e4..ecbd971 100644
--- a/arch/arm/configs/overo_defconfig
+++ b/arch/arm/configs/overo_defconfig
@@ -866,7 +866,7 @@ CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_ISP1301_OMAP is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/palmz72_defconfig b/arch/arm/configs/palmz72_defconfig
index a0dc37c..4f5bf49 100644
--- a/arch/arm/configs/palmz72_defconfig
+++ b/arch/arm/configs/palmz72_defconfig
@@ -534,7 +534,7 @@ CONFIG_I2C_PXA=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/pcm027_defconfig b/arch/arm/configs/pcm027_defconfig
index 05ad96a..9ba32c4 100644
--- a/arch/arm/configs/pcm027_defconfig
+++ b/arch/arm/configs/pcm027_defconfig
@@ -610,7 +610,7 @@ CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/picotux200_defconfig b/arch/arm/configs/picotux200_defconfig
index 9018f0f..8e682dd 100644
--- a/arch/arm/configs/picotux200_defconfig
+++ b/arch/arm/configs/picotux200_defconfig
@@ -748,7 +748,7 @@ CONFIG_EEPROM_LEGACY=m
 CONFIG_SENSORS_PCF8574=m
 CONFIG_SENSORS_PCA9539=m
 CONFIG_SENSORS_PCF8591=m
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/arm/configs/pnx4008_defconfig b/arch/arm/configs/pnx4008_defconfig
index 67b5f1e..8d6ec18 100644
--- a/arch/arm/configs/pnx4008_defconfig
+++ b/arch/arm/configs/pnx4008_defconfig
@@ -919,7 +919,7 @@ CONFIG_EEPROM_LEGACY=m
 CONFIG_SENSORS_PCF8574=m
 # CONFIG_SENSORS_PCA9539 is not set
 CONFIG_SENSORS_PCF8591=m
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/arm/configs/qil-a9260_defconfig b/arch/arm/configs/qil-a9260_defconfig
index 9b32d0e..75515a0 100644
--- a/arch/arm/configs/qil-a9260_defconfig
+++ b/arch/arm/configs/qil-a9260_defconfig
@@ -691,7 +691,7 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
index a29d61f..13136d3 100644
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -594,7 +594,7 @@ CONFIG_I2C_ACORN=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index 593102d..e50c051 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -889,7 +889,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index 2d58b8f..5f72164 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -1260,7 +1260,7 @@ CONFIG_I2C_SIMTEC=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index 2e8fa50..39d6d26 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -472,7 +472,7 @@ CONFIG_EEPROM_AT24=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index 745c68f..3c7857c 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -984,7 +984,7 @@ CONFIG_I2C_PXA=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/arm/configs/sx1_defconfig b/arch/arm/configs/sx1_defconfig
index 25b007f..f6ef3a7 100644
--- a/arch/arm/configs/sx1_defconfig
+++ b/arch/arm/configs/sx1_defconfig
@@ -616,7 +616,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
 # CONFIG_SENSORS_TLV320AIC23 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/arm/configs/trizeps4_defconfig b/arch/arm/configs/trizeps4_defconfig
index b6f8381..03d3e8a 100644
--- a/arch/arm/configs/trizeps4_defconfig
+++ b/arch/arm/configs/trizeps4_defconfig
@@ -952,7 +952,7 @@ CONFIG_I2C_PXA_SLAVE=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index b11c5da..cf2596a 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -615,7 +615,7 @@ CONFIG_EEPROM_LEGACY=m
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/arm/configs/viper_defconfig b/arch/arm/configs/viper_defconfig
index 30f463d..6c59168 100644
--- a/arch/arm/configs/viper_defconfig
+++ b/arch/arm/configs/viper_defconfig
@@ -867,7 +867,7 @@ CONFIG_I2C_PXA=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/avr32/configs/atngw100_defconfig b/arch/avr32/configs/atngw100_defconfig
index 574aca9..378c281 100644
--- a/arch/avr32/configs/atngw100_defconfig
+++ b/arch/avr32/configs/atngw100_defconfig
@@ -651,7 +651,7 @@ CONFIG_EEPROM_AT24=m
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/avr32/configs/atngw100_evklcd100_defconfig b/arch/avr32/configs/atngw100_evklcd100_defconfig
index 86a45b5..80e3c94 100644
--- a/arch/avr32/configs/atngw100_evklcd100_defconfig
+++ b/arch/avr32/configs/atngw100_evklcd100_defconfig
@@ -676,7 +676,7 @@ CONFIG_I2C_GPIO=m
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/avr32/configs/atngw100_evklcd101_defconfig b/arch/avr32/configs/atngw100_evklcd101_defconfig
index a96b68e..62e8f8b 100644
--- a/arch/avr32/configs/atngw100_evklcd101_defconfig
+++ b/arch/avr32/configs/atngw100_evklcd101_defconfig
@@ -676,7 +676,7 @@ CONFIG_I2C_GPIO=m
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/avr32/configs/atstk1002_defconfig b/arch/avr32/configs/atstk1002_defconfig
index 0abe90a..c7e8f81 100644
--- a/arch/avr32/configs/atstk1002_defconfig
+++ b/arch/avr32/configs/atstk1002_defconfig
@@ -670,7 +670,7 @@ CONFIG_EEPROM_AT24=m
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/avr32/configs/atstk1003_defconfig b/arch/avr32/configs/atstk1003_defconfig
index 101972f..2453758 100644
--- a/arch/avr32/configs/atstk1003_defconfig
+++ b/arch/avr32/configs/atstk1003_defconfig
@@ -618,7 +618,7 @@ CONFIG_EEPROM_AT24=m
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/avr32/configs/atstk1006_defconfig b/arch/avr32/configs/atstk1006_defconfig
index c1603c4..40771fc 100644
--- a/arch/avr32/configs/atstk1006_defconfig
+++ b/arch/avr32/configs/atstk1006_defconfig
@@ -691,7 +691,7 @@ CONFIG_I2C_GPIO=m
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/avr32/configs/favr-32_defconfig b/arch/avr32/configs/favr-32_defconfig
index 4c3ac06..4cb7c18 100644
--- a/arch/avr32/configs/favr-32_defconfig
+++ b/arch/avr32/configs/favr-32_defconfig
@@ -640,7 +640,7 @@ CONFIG_I2C_GPIO=m
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/avr32/configs/hammerhead_defconfig b/arch/avr32/configs/hammerhead_defconfig
index 3970fcc..f96637b 100644
--- a/arch/avr32/configs/hammerhead_defconfig
+++ b/arch/avr32/configs/hammerhead_defconfig
@@ -723,7 +723,7 @@ CONFIG_I2C_GPIO=m
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/avr32/configs/merisc_defconfig b/arch/avr32/configs/merisc_defconfig
index 41554db..977520d 100644
--- a/arch/avr32/configs/merisc_defconfig
+++ b/arch/avr32/configs/merisc_defconfig
@@ -641,7 +641,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/avr32/configs/mimc200_defconfig b/arch/avr32/configs/mimc200_defconfig
index 1a58ffb..a59339a 100644
--- a/arch/avr32/configs/mimc200_defconfig
+++ b/arch/avr32/configs/mimc200_defconfig
@@ -572,7 +572,7 @@ CONFIG_EEPROM_AT24=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_DS28CM00 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
diff --git a/arch/blackfin/configs/BF518F-EZBRD_defconfig b/arch/blackfin/configs/BF518F-EZBRD_defconfig
index c121d6e..6506e16 100644
--- a/arch/blackfin/configs/BF518F-EZBRD_defconfig
+++ b/arch/blackfin/configs/BF518F-EZBRD_defconfig
@@ -777,7 +777,7 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/blackfin/configs/BF526-EZBRD_defconfig b/arch/blackfin/configs/BF526-EZBRD_defconfig
index 3e562b2..6070369 100644
--- a/arch/blackfin/configs/BF526-EZBRD_defconfig
+++ b/arch/blackfin/configs/BF526-EZBRD_defconfig
@@ -807,7 +807,7 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/blackfin/configs/BF527-EZKIT_defconfig b/arch/blackfin/configs/BF527-EZKIT_defconfig
index 911b5db..a31edeb 100644
--- a/arch/blackfin/configs/BF527-EZKIT_defconfig
+++ b/arch/blackfin/configs/BF527-EZKIT_defconfig
@@ -850,7 +850,7 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/blackfin/configs/BF533-STAMP_defconfig b/arch/blackfin/configs/BF533-STAMP_defconfig
index 9c482cd..578927c 100644
--- a/arch/blackfin/configs/BF533-STAMP_defconfig
+++ b/arch/blackfin/configs/BF533-STAMP_defconfig
@@ -756,7 +756,7 @@ CONFIG_I2C_HELPER_AUTO=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/blackfin/configs/BF537-STAMP_defconfig b/arch/blackfin/configs/BF537-STAMP_defconfig
index 591f6ed..afb8361 100644
--- a/arch/blackfin/configs/BF537-STAMP_defconfig
+++ b/arch/blackfin/configs/BF537-STAMP_defconfig
@@ -798,7 +798,7 @@ CONFIG_SENSORS_AD5252=m
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/blackfin/configs/BF538-EZKIT_defconfig b/arch/blackfin/configs/BF538-EZKIT_defconfig
index 1a8e8c3..68ccd25 100644
--- a/arch/blackfin/configs/BF538-EZKIT_defconfig
+++ b/arch/blackfin/configs/BF538-EZKIT_defconfig
@@ -808,7 +808,7 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/blackfin/configs/BF548-EZKIT_defconfig b/arch/blackfin/configs/BF548-EZKIT_defconfig
index 2cd1c2b..e27b92c 100644
--- a/arch/blackfin/configs/BF548-EZKIT_defconfig
+++ b/arch/blackfin/configs/BF548-EZKIT_defconfig
@@ -952,7 +952,7 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/blackfin/configs/BlackStamp_defconfig b/arch/blackfin/configs/BlackStamp_defconfig
index ef1a2c8..c41af29 100644
--- a/arch/blackfin/configs/BlackStamp_defconfig
+++ b/arch/blackfin/configs/BlackStamp_defconfig
@@ -695,7 +695,7 @@ CONFIG_I2C_GPIO=m
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/blackfin/configs/CM-BF527_defconfig b/arch/blackfin/configs/CM-BF527_defconfig
index e2fc588..234c850 100644
--- a/arch/blackfin/configs/CM-BF527_defconfig
+++ b/arch/blackfin/configs/CM-BF527_defconfig
@@ -759,7 +759,7 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/blackfin/configs/CM-BF548_defconfig b/arch/blackfin/configs/CM-BF548_defconfig
index 035b635..1bbfb17 100644
--- a/arch/blackfin/configs/CM-BF548_defconfig
+++ b/arch/blackfin/configs/CM-BF548_defconfig
@@ -804,7 +804,7 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # CONFIG_SENSORS_PCA9543 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/blackfin/configs/PNAV-10_defconfig b/arch/blackfin/configs/PNAV-10_defconfig
index 78e2408..a5d5fd3 100644
--- a/arch/blackfin/configs/PNAV-10_defconfig
+++ b/arch/blackfin/configs/PNAV-10_defconfig
@@ -767,7 +767,7 @@ CONFIG_SENSORS_PCF8574=m
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/blackfin/configs/SRV1_defconfig b/arch/blackfin/configs/SRV1_defconfig
index 2bc0779..e40c187 100644
--- a/arch/blackfin/configs/SRV1_defconfig
+++ b/arch/blackfin/configs/SRV1_defconfig
@@ -804,7 +804,7 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # CONFIG_SENSORS_PCA9543 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/ia64/configs/bigsur_defconfig b/arch/ia64/configs/bigsur_defconfig
index ace4109..05b76e4 100644
--- a/arch/ia64/configs/bigsur_defconfig
+++ b/arch/ia64/configs/bigsur_defconfig
@@ -757,7 +757,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_RTC8564 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_RTC_X1205_I2C is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/ia64/configs/xen_domu_defconfig b/arch/ia64/configs/xen_domu_defconfig
index 0bb0714..8d17789 100644
--- a/arch/ia64/configs/xen_domu_defconfig
+++ b/arch/ia64/configs/xen_domu_defconfig
@@ -919,7 +919,7 @@ CONFIG_I2C_ALGOBIT=m
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/ia64/configs/zx1_defconfig b/arch/ia64/configs/zx1_defconfig
index 514f063..f190f08 100644
--- a/arch/ia64/configs/zx1_defconfig
+++ b/arch/ia64/configs/zx1_defconfig
@@ -845,7 +845,7 @@ CONFIG_I2C_ALGOPCF=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/m32r/configs/m32104ut_defconfig b/arch/m32r/configs/m32104ut_defconfig
index 6f54b00..fb81ffb 100644
--- a/arch/m32r/configs/m32104ut_defconfig
+++ b/arch/m32r/configs/m32104ut_defconfig
@@ -625,7 +625,7 @@ CONFIG_I2C_ELEKTOR=m
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 783da85..d6d35b2 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -963,7 +963,7 @@ CONFIG_EEPROM_LEGACY=y
 CONFIG_SENSORS_PCF8574=y
 # CONFIG_PCF8575 is not set
 CONFIG_SENSORS_PCF8591=y
-CONFIG_SENSORS_MAX6875=y
+CONFIG_EEPROM_MAX6875=y
 # CONFIG_SENSORS_TSL2550 is not set
 CONFIG_I2C_DEBUG_CORE=y
 CONFIG_I2C_DEBUG_ALGO=y
diff --git a/arch/mips/configs/fulong_defconfig b/arch/mips/configs/fulong_defconfig
index 786a9bc..59d39a7 100644
--- a/arch/mips/configs/fulong_defconfig
+++ b/arch/mips/configs/fulong_defconfig
@@ -1012,7 +1012,7 @@ CONFIG_I2C_VIAPRO=m
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/mips/configs/markeins_defconfig b/arch/mips/configs/markeins_defconfig
index bad8901..f39be66 100644
--- a/arch/mips/configs/markeins_defconfig
+++ b/arch/mips/configs/markeins_defconfig
@@ -1000,7 +1000,7 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 CONFIG_I2C_DEBUG_CORE=y
 # CONFIG_I2C_DEBUG_ALGO is not set
 CONFIG_I2C_DEBUG_BUS=y
diff --git a/arch/mips/configs/msp71xx_defconfig b/arch/mips/configs/msp71xx_defconfig
index 84d6491..99fb07d 100644
--- a/arch/mips/configs/msp71xx_defconfig
+++ b/arch/mips/configs/msp71xx_defconfig
@@ -934,7 +934,7 @@ CONFIG_I2C_PMCMSP=y
 CONFIG_PMCTWILED=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index 8426d3b..fadb351 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -1849,7 +1849,7 @@ CONFIG_EEPROM_LEGACY=m
 CONFIG_SENSORS_PCF8574=m
 CONFIG_SENSORS_PCA9539=m
 CONFIG_SENSORS_PCF8591=m
-CONFIG_SENSORS_MAX6875=m
+CONFIG_EEPROM_MAX6875=m
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/mips/configs/pnx8335-stb225_defconfig b/arch/mips/configs/pnx8335-stb225_defconfig
index 2728caa..c5663b1 100644
--- a/arch/mips/configs/pnx8335-stb225_defconfig
+++ b/arch/mips/configs/pnx8335-stb225_defconfig
@@ -646,7 +646,7 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/44x/canyonlands_defconfig b/arch/powerpc/configs/44x/canyonlands_defconfig
index f9a08ee..14246de 100644
--- a/arch/powerpc/configs/44x/canyonlands_defconfig
+++ b/arch/powerpc/configs/44x/canyonlands_defconfig
@@ -609,7 +609,7 @@ CONFIG_I2C_IBM_IIC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/44x/redwood_defconfig b/arch/powerpc/configs/44x/redwood_defconfig
index e665433..851650a 100644
--- a/arch/powerpc/configs/44x/redwood_defconfig
+++ b/arch/powerpc/configs/44x/redwood_defconfig
@@ -795,7 +795,7 @@ CONFIG_I2C_IBM_IIC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 CONFIG_I2C_DEBUG_CORE=y
 CONFIG_I2C_DEBUG_ALGO=y
diff --git a/arch/powerpc/configs/44x/sam440ep_defconfig b/arch/powerpc/configs/44x/sam440ep_defconfig
index 70d5c3f..45a3422 100644
--- a/arch/powerpc/configs/44x/sam440ep_defconfig
+++ b/arch/powerpc/configs/44x/sam440ep_defconfig
@@ -753,7 +753,7 @@ CONFIG_I2C_IBM_IIC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 3b77f09..33f80db 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -691,7 +691,7 @@ CONFIG_EEPROM_LEGACY=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/52xx/cm5200_defconfig b/arch/powerpc/configs/52xx/cm5200_defconfig
index 3838b77..9eac3c2 100644
--- a/arch/powerpc/configs/52xx/cm5200_defconfig
+++ b/arch/powerpc/configs/52xx/cm5200_defconfig
@@ -669,7 +669,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/52xx/lite5200b_defconfig b/arch/powerpc/configs/52xx/lite5200b_defconfig
index 29b0f34..1f2f4d3 100644
--- a/arch/powerpc/configs/52xx/lite5200b_defconfig
+++ b/arch/powerpc/configs/52xx/lite5200b_defconfig
@@ -815,7 +815,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/52xx/motionpro_defconfig b/arch/powerpc/configs/52xx/motionpro_defconfig
index 07b6b26..4f90ef9 100644
--- a/arch/powerpc/configs/52xx/motionpro_defconfig
+++ b/arch/powerpc/configs/52xx/motionpro_defconfig
@@ -679,7 +679,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/52xx/pcm030_defconfig b/arch/powerpc/configs/52xx/pcm030_defconfig
index afb1a3d..c9881e4 100644
--- a/arch/powerpc/configs/52xx/pcm030_defconfig
+++ b/arch/powerpc/configs/52xx/pcm030_defconfig
@@ -779,7 +779,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/52xx/tqm5200_defconfig b/arch/powerpc/configs/52xx/tqm5200_defconfig
index 8585c7c..3ffa26c 100644
--- a/arch/powerpc/configs/52xx/tqm5200_defconfig
+++ b/arch/powerpc/configs/52xx/tqm5200_defconfig
@@ -688,7 +688,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/83xx/asp8347_defconfig b/arch/powerpc/configs/83xx/asp8347_defconfig
index fc4a39a..131fb0b 100644
--- a/arch/powerpc/configs/83xx/asp8347_defconfig
+++ b/arch/powerpc/configs/83xx/asp8347_defconfig
@@ -765,7 +765,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
index 409d017..a00be2f 100644
--- a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
@@ -895,7 +895,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
index 03db97c..a1e3ef8 100644
--- a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
@@ -956,7 +956,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
index fb17de5..5659501 100644
--- a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
@@ -759,7 +759,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
index a012ce2..a90ba6b 100644
--- a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
@@ -774,7 +774,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
index 4bcc4a1..18a0282 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
@@ -933,7 +933,7 @@ CONFIG_SENSORS_PCF8574=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
index 9ba5518..a24727a 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
@@ -813,7 +813,7 @@ CONFIG_SENSORS_PCF8574=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
index 18e4bc0..3255b85 100644
--- a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
@@ -700,7 +700,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
index 76db813..06e6ef6 100644
--- a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
@@ -841,7 +841,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
index 0dc11c4..901ddb0 100644
--- a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
@@ -755,7 +755,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
index e42f6b3..9a1a34b 100644
--- a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
@@ -817,7 +817,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
index 408022f..20dc221 100644
--- a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
@@ -817,7 +817,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/83xx/sbc834x_defconfig b/arch/powerpc/configs/83xx/sbc834x_defconfig
index a0c42fb..e74863b 100644
--- a/arch/powerpc/configs/83xx/sbc834x_defconfig
+++ b/arch/powerpc/configs/83xx/sbc834x_defconfig
@@ -666,7 +666,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/85xx/socrates_defconfig b/arch/powerpc/configs/85xx/socrates_defconfig
index 0cc9048..8aad7ce 100644
--- a/arch/powerpc/configs/85xx/socrates_defconfig
+++ b/arch/powerpc/configs/85xx/socrates_defconfig
@@ -772,7 +772,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/85xx/stx_gp3_defconfig b/arch/powerpc/configs/85xx/stx_gp3_defconfig
index eb4ba7a..5f22fce 100644
--- a/arch/powerpc/configs/85xx/stx_gp3_defconfig
+++ b/arch/powerpc/configs/85xx/stx_gp3_defconfig
@@ -909,7 +909,7 @@ CONFIG_I2C_ALGOBIT=m
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/85xx/tqm8540_defconfig b/arch/powerpc/configs/85xx/tqm8540_defconfig
index f4379b1..4561bf1 100644
--- a/arch/powerpc/configs/85xx/tqm8540_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8540_defconfig
@@ -822,7 +822,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/85xx/tqm8541_defconfig b/arch/powerpc/configs/85xx/tqm8541_defconfig
index b866923..0a1233a 100644
--- a/arch/powerpc/configs/85xx/tqm8541_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8541_defconfig
@@ -831,7 +831,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/85xx/tqm8548_defconfig b/arch/powerpc/configs/85xx/tqm8548_defconfig
index 43030fe..4367990 100644
--- a/arch/powerpc/configs/85xx/tqm8548_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8548_defconfig
@@ -786,7 +786,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/85xx/tqm8555_defconfig b/arch/powerpc/configs/85xx/tqm8555_defconfig
index d5a864d..c5c5a6d 100644
--- a/arch/powerpc/configs/85xx/tqm8555_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8555_defconfig
@@ -831,7 +831,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/85xx/tqm8560_defconfig b/arch/powerpc/configs/85xx/tqm8560_defconfig
index a250091..b3133fa 100644
--- a/arch/powerpc/configs/85xx/tqm8560_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8560_defconfig
@@ -831,7 +831,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
index df2c163..1b5cbfc 100644
--- a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
+++ b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
@@ -1123,7 +1123,7 @@ CONFIG_DS1682=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/86xx/gef_sbc310_defconfig b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
index bd236b3..c24fa2e 100644
--- a/arch/powerpc/configs/86xx/gef_sbc310_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
@@ -895,7 +895,7 @@ CONFIG_DS1682=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/86xx/gef_sbc610_defconfig b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
index 1ab5aba..88af8f0 100644
--- a/arch/powerpc/configs/86xx/gef_sbc610_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
@@ -1119,7 +1119,7 @@ CONFIG_DS1682=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
index bbdf4bf..fd4daf5 100644
--- a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
@@ -935,7 +935,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
index 92acfdf..3ade0b0 100644
--- a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
+++ b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
@@ -881,7 +881,7 @@ CONFIG_EEPROM_LEGACY=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/86xx/sbc8641d_defconfig b/arch/powerpc/configs/86xx/sbc8641d_defconfig
index 04797e7..993dde4 100644
--- a/arch/powerpc/configs/86xx/sbc8641d_defconfig
+++ b/arch/powerpc/configs/86xx/sbc8641d_defconfig
@@ -991,7 +991,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/amigaone_defconfig b/arch/powerpc/configs/amigaone_defconfig
index b63cc38..bad10a1 100644
--- a/arch/powerpc/configs/amigaone_defconfig
+++ b/arch/powerpc/configs/amigaone_defconfig
@@ -913,7 +913,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_defconfig
index 5103319..374f4a1 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -1156,7 +1156,7 @@ CONFIG_SENSORS_PCF8574=m
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 CONFIG_SENSORS_PCF8591=m
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index c6d2baa..2153924 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -1017,7 +1017,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/celleb_defconfig b/arch/powerpc/configs/celleb_defconfig
index d212377..2b69529 100644
--- a/arch/powerpc/configs/celleb_defconfig
+++ b/arch/powerpc/configs/celleb_defconfig
@@ -839,7 +839,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
index 5094a65..d7bbcd1 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -947,7 +947,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index fc90592..913677d 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -1000,7 +1000,7 @@ CONFIG_I2C_POWERMAC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index 15900dc..490d60e 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -1051,7 +1051,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index 8b24400..958eca0 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -872,7 +872,7 @@ CONFIG_I2C_AMD8111=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index aaa4416..1c04d9f 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -913,7 +913,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 45f03ca..b953613 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -938,7 +938,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index c162724..e4058e7 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -927,7 +927,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 1aa1c50..f6b1e41 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -931,7 +931,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/mpc86xx_defconfig b/arch/powerpc/configs/mpc86xx_defconfig
index adc756e..a90946c 100644
--- a/arch/powerpc/configs/mpc86xx_defconfig
+++ b/arch/powerpc/configs/mpc86xx_defconfig
@@ -885,7 +885,7 @@ CONFIG_EEPROM_LEGACY=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 4f8681c..7a64a34 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -988,7 +988,7 @@ CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index 5339bb4..bb727aa 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -1238,7 +1238,7 @@ CONFIG_I2C_POWERMAC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/ppc40x_defconfig b/arch/powerpc/configs/ppc40x_defconfig
index 326205c..58fee58 100644
--- a/arch/powerpc/configs/ppc40x_defconfig
+++ b/arch/powerpc/configs/ppc40x_defconfig
@@ -776,7 +776,7 @@ CONFIG_I2C_IBM_IIC=m
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index 5e6d55f..7b712e1 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -827,7 +827,7 @@ CONFIG_I2C_IBM_IIC=m
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 2524018..1392ef7 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -1267,7 +1267,7 @@ CONFIG_I2C_PASEMI=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 7d044df..12dc7c4 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -1808,7 +1808,7 @@ CONFIG_PCF8575=m
 CONFIG_SENSORS_PCA9539=m
 CONFIG_SENSORS_PCF8591=m
 # CONFIG_TPS65010 is not set
-CONFIG_SENSORS_MAX6875=m
+CONFIG_EEPROM_MAX6875=m
 CONFIG_SENSORS_TSL2550=m
 CONFIG_MCU_MPC8349EMITX=m
 # CONFIG_I2C_DEBUG_CORE is not set
diff --git a/arch/powerpc/configs/prpmc2800_defconfig b/arch/powerpc/configs/prpmc2800_defconfig
index e971db1..8e264c0 100644
--- a/arch/powerpc/configs/prpmc2800_defconfig
+++ b/arch/powerpc/configs/prpmc2800_defconfig
@@ -981,7 +981,7 @@ CONFIG_I2C_MV64XXX=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index f1889ab..87617b6 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -1061,7 +1061,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/powerpc/configs/storcenter_defconfig b/arch/powerpc/configs/storcenter_defconfig
index 9490346..6fe4f81 100644
--- a/arch/powerpc/configs/storcenter_defconfig
+++ b/arch/powerpc/configs/storcenter_defconfig
@@ -832,7 +832,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/sh/configs/ap325rxa_defconfig b/arch/sh/configs/ap325rxa_defconfig
index c8d982a..b6eb566 100644
--- a/arch/sh/configs/ap325rxa_defconfig
+++ b/arch/sh/configs/ap325rxa_defconfig
@@ -746,7 +746,7 @@ CONFIG_I2C_SH_MOBILE=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/sh/configs/cayman_defconfig b/arch/sh/configs/cayman_defconfig
index fa5fc1e..72c1630 100644
--- a/arch/sh/configs/cayman_defconfig
+++ b/arch/sh/configs/cayman_defconfig
@@ -750,7 +750,7 @@ CONFIG_I2C_HELPER_AUTO=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/sh/configs/edosk7760_defconfig b/arch/sh/configs/edosk7760_defconfig
index 7825c26..b9cd11e 100644
--- a/arch/sh/configs/edosk7760_defconfig
+++ b/arch/sh/configs/edosk7760_defconfig
@@ -667,7 +667,7 @@ CONFIG_I2C_SH7760=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 CONFIG_I2C_DEBUG_CORE=y
 CONFIG_I2C_DEBUG_ALGO=y
diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index a8720f9..0abd06c 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -738,7 +738,7 @@ CONFIG_I2C_SH_MOBILE=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/sh/configs/r7780mp_defconfig b/arch/sh/configs/r7780mp_defconfig
index 7def4df..3031c8b 100644
--- a/arch/sh/configs/r7780mp_defconfig
+++ b/arch/sh/configs/r7780mp_defconfig
@@ -891,7 +891,7 @@ CONFIG_I2C_HIGHLANDER=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/sh/configs/r7785rp_defconfig b/arch/sh/configs/r7785rp_defconfig
index cb134ff..3a5aba2 100644
--- a/arch/sh/configs/r7785rp_defconfig
+++ b/arch/sh/configs/r7785rp_defconfig
@@ -895,7 +895,7 @@ CONFIG_I2C_HIGHLANDER=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/sh/configs/se7343_defconfig b/arch/sh/configs/se7343_defconfig
index fbb72d0..107e9da 100644
--- a/arch/sh/configs/se7343_defconfig
+++ b/arch/sh/configs/se7343_defconfig
@@ -692,7 +692,7 @@ CONFIG_I2C_SH_MOBILE=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
index a6cf450..3cca8ef 100644
--- a/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -859,7 +859,7 @@ CONFIG_I2C_PCA_PLATFORM=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/sh/configs/sh7785lcr_defconfig b/arch/sh/configs/sh7785lcr_defconfig
index e4fac2e..d06ced6 100644
--- a/arch/sh/configs/sh7785lcr_defconfig
+++ b/arch/sh/configs/sh7785lcr_defconfig
@@ -857,7 +857,7 @@ CONFIG_I2C_PCA_PLATFORM=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/sh/configs/shx3_defconfig b/arch/sh/configs/shx3_defconfig
index e3651f5..af7fa48 100644
--- a/arch/sh/configs/shx3_defconfig
+++ b/arch/sh/configs/shx3_defconfig
@@ -696,7 +696,7 @@ CONFIG_I2C_HELPER_AUTO=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index d174b1a..8a1d50e 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -751,7 +751,7 @@ CONFIG_I2C_PCA_PLATFORM=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index b5d63bd..18e83fa 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -888,7 +888,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 235b81d..a146e80 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -1391,7 +1391,7 @@ CONFIG_I2C_I801=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 9fe5d21..9578a96 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -1383,7 +1383,7 @@ CONFIG_I2C_I801=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 8f8c81e..02d746c 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -64,21 +64,6 @@ config SENSORS_PCA9539
 	  This driver is deprecated and will be dropped soon. Use
 	  drivers/gpio/pca953x.c instead.
 
-config SENSORS_MAX6875
-	tristate "Maxim MAX6875 Power supply supervisor"
-	depends on EXPERIMENTAL
-	help
-	  If you say yes here you get support for the Maxim MAX6875
-	  EEPROM-programmable, quad power-supply sequencer/supervisor.
-
-	  This provides an interface to program the EEPROM and reset the chip.
-
-	  This driver also supports the Maxim MAX6874 hex power-supply
-	  sequencer/supervisor if found at a compatible address.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called max6875.
-
 config SENSORS_TSL2550
 	tristate "Taos TSL2550 ambient light sensor"
 	depends on EXPERIMENTAL
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 55a3760..f4680d1 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -11,7 +11,6 @@
 #
 
 obj-$(CONFIG_DS1682)		+= ds1682.o
-obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
 obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_PCF8575)		+= pcf8575.o
diff --git a/drivers/i2c/chips/max6875.c b/drivers/i2c/chips/max6875.c
deleted file mode 100644
index 033d9d8..0000000
--- a/drivers/i2c/chips/max6875.c
+++ /dev/null
@@ -1,246 +0,0 @@
-/*
-    max6875.c - driver for MAX6874/MAX6875
-
-    Copyright (C) 2005 Ben Gardner <bgardner-ohtLXRgXiI/QT0dZR+AlfA@public.gmane.org>
-
-    Based on i2c/chips/eeprom.c
-
-    The MAX6875 has a bank of registers and two banks of EEPROM.
-    Address ranges are defined as follows:
-     * 0x0000 - 0x0046 = configuration registers
-     * 0x8000 - 0x8046 = configuration EEPROM
-     * 0x8100 - 0x82FF = user EEPROM
-
-    This driver makes the user EEPROM available for read.
-
-    The registers & config EEPROM should be accessed via i2c-dev.
-
-    The MAX6875 ignores the lowest address bit, so each chip responds to
-    two addresses - 0x50/0x51 and 0x52/0x53.
-
-    Note that the MAX6875 uses i2c_smbus_write_byte_data() to set the read
-    address, so this driver is destructive if loaded for the wrong EEPROM chip.
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; version 2 of the License.
-*/
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/mutex.h>
-
-/* Do not scan - the MAX6875 access method will write to some EEPROM chips */
-static const unsigned short normal_i2c[] = { I2C_CLIENT_END };
-
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(max6875);
-
-/* The MAX6875 can only read/write 16 bytes at a time */
-#define SLICE_SIZE			16
-#define SLICE_BITS			4
-
-/* USER EEPROM is at addresses 0x8100 - 0x82FF */
-#define USER_EEPROM_BASE		0x8100
-#define USER_EEPROM_SIZE		0x0200
-#define USER_EEPROM_SLICES		32
-
-/* MAX6875 commands */
-#define MAX6875_CMD_BLK_READ		0x84
-
-/* Each client has this additional data */
-struct max6875_data {
-	struct i2c_client	*fake_client;
-	struct mutex		update_lock;
-
-	u32			valid;
-	u8			data[USER_EEPROM_SIZE];
-	unsigned long		last_updated[USER_EEPROM_SLICES];
-};
-
-static void max6875_update_slice(struct i2c_client *client, int slice)
-{
-	struct max6875_data *data = i2c_get_clientdata(client);
-	int i, j, addr;
-	u8 *buf;
-
-	if (slice >= USER_EEPROM_SLICES)
-		return;
-
-	mutex_lock(&data->update_lock);
-
-	buf = &data->data[slice << SLICE_BITS];
-
-	if (!(data->valid & (1 << slice)) ||
-	    time_after(jiffies, data->last_updated[slice])) {
-
-		dev_dbg(&client->dev, "Starting update of slice %u\n", slice);
-
-		data->valid &= ~(1 << slice);
-
-		addr = USER_EEPROM_BASE + (slice << SLICE_BITS);
-
-		/* select the eeprom address */
-		if (i2c_smbus_write_byte_data(client, addr >> 8, addr & 0xFF)) {
-			dev_err(&client->dev, "address set failed\n");
-			goto exit_up;
-		}
-
-		if (i2c_check_functionality(client->adapter,
-					    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
-			if (i2c_smbus_read_i2c_block_data(client,
-							  MAX6875_CMD_BLK_READ,
-							  SLICE_SIZE,
-							  buf) != SLICE_SIZE) {
-				goto exit_up;
-			}
-		} else {
-			for (i = 0; i < SLICE_SIZE; i++) {
-				j = i2c_smbus_read_byte(client);
-				if (j < 0) {
-					goto exit_up;
-				}
-				buf[i] = j;
-			}
-		}
-		data->last_updated[slice] = jiffies;
-		data->valid |= (1 << slice);
-	}
-exit_up:
-	mutex_unlock(&data->update_lock);
-}
-
-static ssize_t max6875_read(struct kobject *kobj,
-			    struct bin_attribute *bin_attr,
-			    char *buf, loff_t off, size_t count)
-{
-	struct i2c_client *client = kobj_to_i2c_client(kobj);
-	struct max6875_data *data = i2c_get_clientdata(client);
-	int slice, max_slice;
-
-	if (off > USER_EEPROM_SIZE)
-		return 0;
-
-	if (off + count > USER_EEPROM_SIZE)
-		count = USER_EEPROM_SIZE - off;
-
-	/* refresh slices which contain requested bytes */
-	max_slice = (off + count - 1) >> SLICE_BITS;
-	for (slice = (off >> SLICE_BITS); slice <= max_slice; slice++)
-		max6875_update_slice(client, slice);
-
-	memcpy(buf, &data->data[off], count);
-
-	return count;
-}
-
-static struct bin_attribute user_eeprom_attr = {
-	.attr = {
-		.name = "eeprom",
-		.mode = S_IRUGO,
-	},
-	.size = USER_EEPROM_SIZE,
-	.read = max6875_read,
-};
-
-/* Return 0 if detection is successful, -ENODEV otherwise */
-static int max6875_detect(struct i2c_client *client, int kind,
-			  struct i2c_board_info *info)
-{
-	struct i2c_adapter *adapter = client->adapter;
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE_DATA
-				     | I2C_FUNC_SMBUS_READ_BYTE))
-		return -ENODEV;
-
-	/* Only check even addresses */
-	if (client->addr & 1)
-		return -ENODEV;
-
-	strlcpy(info->type, "max6875", I2C_NAME_SIZE);
-
-	return 0;
-}
-
-static int max6875_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
-{
-	struct max6875_data *data;
-	int err;
-
-	if (!(data = kzalloc(sizeof(struct max6875_data), GFP_KERNEL)))
-		return -ENOMEM;
-
-	/* A fake client is created on the odd address */
-	data->fake_client = i2c_new_dummy(client->adapter, client->addr + 1);
-	if (!data->fake_client) {
-		err = -ENOMEM;
-		goto exit_kfree;
-	}
-
-	/* Init real i2c_client */
-	i2c_set_clientdata(client, data);
-	mutex_init(&data->update_lock);
-
-	err = sysfs_create_bin_file(&client->dev.kobj, &user_eeprom_attr);
-	if (err)
-		goto exit_remove_fake;
-
-	return 0;
-
-exit_remove_fake:
-	i2c_unregister_device(data->fake_client);
-exit_kfree:
-	kfree(data);
-	return err;
-}
-
-static int max6875_remove(struct i2c_client *client)
-{
-	struct max6875_data *data = i2c_get_clientdata(client);
-
-	i2c_unregister_device(data->fake_client);
-
-	sysfs_remove_bin_file(&client->dev.kobj, &user_eeprom_attr);
-	kfree(data);
-
-	return 0;
-}
-
-static const struct i2c_device_id max6875_id[] = {
-	{ "max6875", 0 },
-	{ }
-};
-
-static struct i2c_driver max6875_driver = {
-	.driver = {
-		.name	= "max6875",
-	},
-	.probe		= max6875_probe,
-	.remove		= max6875_remove,
-	.id_table	= max6875_id,
-
-	.detect		= max6875_detect,
-	.address_data	= &addr_data,
-};
-
-static int __init max6875_init(void)
-{
-	return i2c_add_driver(&max6875_driver);
-}
-
-static void __exit max6875_exit(void)
-{
-	i2c_del_driver(&max6875_driver);
-}
-
-
-MODULE_AUTHOR("Ben Gardner <bgardner-ohtLXRgXiI/QT0dZR+AlfA@public.gmane.org>");
-MODULE_DESCRIPTION("MAX6875 driver");
-MODULE_LICENSE("GPL");
-
-module_init(max6875_init);
-module_exit(max6875_exit);
diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 89fec05..e23f0ec 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -48,6 +48,20 @@ config EEPROM_LEGACY
 	  This driver can also be built as a module.  If so, the module
 	  will be called eeprom.
 
+config EEPROM_MAX6875
+	tristate "Maxim MAX6874/5 power supply supervisor"
+	depends on EXPERIMENTAL
+	help
+	  If you say yes here you get read-only support for the user EEPROM of
+	  the Maxim MAX6874/5 EEPROM-programmable, quad power-supply
+	  sequencer/supervisor.
+
+	  All other features of this chip should be accessed via i2c-dev.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max6875.
+
+
 config EEPROM_93CX6
 	tristate "EEPROM 93CX6 support"
 	help
diff --git a/drivers/misc/eeprom/Makefile b/drivers/misc/eeprom/Makefile
index 539dd8f..df3d68f 100644
--- a/drivers/misc/eeprom/Makefile
+++ b/drivers/misc/eeprom/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_EEPROM_AT24)	+= at24.o
 obj-$(CONFIG_EEPROM_AT25)	+= at25.o
 obj-$(CONFIG_EEPROM_LEGACY)	+= eeprom.o
+obj-$(CONFIG_EEPROM_MAX6875)	+= max6875.o
 obj-$(CONFIG_EEPROM_93CX6)	+= eeprom_93cx6.o
diff --git a/drivers/misc/eeprom/max6875.c b/drivers/misc/eeprom/max6875.c
new file mode 100644
index 0000000..033d9d8
--- /dev/null
+++ b/drivers/misc/eeprom/max6875.c
@@ -0,0 +1,246 @@
+/*
+    max6875.c - driver for MAX6874/MAX6875
+
+    Copyright (C) 2005 Ben Gardner <bgardner-ohtLXRgXiI/QT0dZR+AlfA@public.gmane.org>
+
+    Based on i2c/chips/eeprom.c
+
+    The MAX6875 has a bank of registers and two banks of EEPROM.
+    Address ranges are defined as follows:
+     * 0x0000 - 0x0046 = configuration registers
+     * 0x8000 - 0x8046 = configuration EEPROM
+     * 0x8100 - 0x82FF = user EEPROM
+
+    This driver makes the user EEPROM available for read.
+
+    The registers & config EEPROM should be accessed via i2c-dev.
+
+    The MAX6875 ignores the lowest address bit, so each chip responds to
+    two addresses - 0x50/0x51 and 0x52/0x53.
+
+    Note that the MAX6875 uses i2c_smbus_write_byte_data() to set the read
+    address, so this driver is destructive if loaded for the wrong EEPROM chip.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; version 2 of the License.
+*/
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+
+/* Do not scan - the MAX6875 access method will write to some EEPROM chips */
+static const unsigned short normal_i2c[] = { I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(max6875);
+
+/* The MAX6875 can only read/write 16 bytes at a time */
+#define SLICE_SIZE			16
+#define SLICE_BITS			4
+
+/* USER EEPROM is at addresses 0x8100 - 0x82FF */
+#define USER_EEPROM_BASE		0x8100
+#define USER_EEPROM_SIZE		0x0200
+#define USER_EEPROM_SLICES		32
+
+/* MAX6875 commands */
+#define MAX6875_CMD_BLK_READ		0x84
+
+/* Each client has this additional data */
+struct max6875_data {
+	struct i2c_client	*fake_client;
+	struct mutex		update_lock;
+
+	u32			valid;
+	u8			data[USER_EEPROM_SIZE];
+	unsigned long		last_updated[USER_EEPROM_SLICES];
+};
+
+static void max6875_update_slice(struct i2c_client *client, int slice)
+{
+	struct max6875_data *data = i2c_get_clientdata(client);
+	int i, j, addr;
+	u8 *buf;
+
+	if (slice >= USER_EEPROM_SLICES)
+		return;
+
+	mutex_lock(&data->update_lock);
+
+	buf = &data->data[slice << SLICE_BITS];
+
+	if (!(data->valid & (1 << slice)) ||
+	    time_after(jiffies, data->last_updated[slice])) {
+
+		dev_dbg(&client->dev, "Starting update of slice %u\n", slice);
+
+		data->valid &= ~(1 << slice);
+
+		addr = USER_EEPROM_BASE + (slice << SLICE_BITS);
+
+		/* select the eeprom address */
+		if (i2c_smbus_write_byte_data(client, addr >> 8, addr & 0xFF)) {
+			dev_err(&client->dev, "address set failed\n");
+			goto exit_up;
+		}
+
+		if (i2c_check_functionality(client->adapter,
+					    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+			if (i2c_smbus_read_i2c_block_data(client,
+							  MAX6875_CMD_BLK_READ,
+							  SLICE_SIZE,
+							  buf) != SLICE_SIZE) {
+				goto exit_up;
+			}
+		} else {
+			for (i = 0; i < SLICE_SIZE; i++) {
+				j = i2c_smbus_read_byte(client);
+				if (j < 0) {
+					goto exit_up;
+				}
+				buf[i] = j;
+			}
+		}
+		data->last_updated[slice] = jiffies;
+		data->valid |= (1 << slice);
+	}
+exit_up:
+	mutex_unlock(&data->update_lock);
+}
+
+static ssize_t max6875_read(struct kobject *kobj,
+			    struct bin_attribute *bin_attr,
+			    char *buf, loff_t off, size_t count)
+{
+	struct i2c_client *client = kobj_to_i2c_client(kobj);
+	struct max6875_data *data = i2c_get_clientdata(client);
+	int slice, max_slice;
+
+	if (off > USER_EEPROM_SIZE)
+		return 0;
+
+	if (off + count > USER_EEPROM_SIZE)
+		count = USER_EEPROM_SIZE - off;
+
+	/* refresh slices which contain requested bytes */
+	max_slice = (off + count - 1) >> SLICE_BITS;
+	for (slice = (off >> SLICE_BITS); slice <= max_slice; slice++)
+		max6875_update_slice(client, slice);
+
+	memcpy(buf, &data->data[off], count);
+
+	return count;
+}
+
+static struct bin_attribute user_eeprom_attr = {
+	.attr = {
+		.name = "eeprom",
+		.mode = S_IRUGO,
+	},
+	.size = USER_EEPROM_SIZE,
+	.read = max6875_read,
+};
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int max6875_detect(struct i2c_client *client, int kind,
+			  struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE_DATA
+				     | I2C_FUNC_SMBUS_READ_BYTE))
+		return -ENODEV;
+
+	/* Only check even addresses */
+	if (client->addr & 1)
+		return -ENODEV;
+
+	strlcpy(info->type, "max6875", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int max6875_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct max6875_data *data;
+	int err;
+
+	if (!(data = kzalloc(sizeof(struct max6875_data), GFP_KERNEL)))
+		return -ENOMEM;
+
+	/* A fake client is created on the odd address */
+	data->fake_client = i2c_new_dummy(client->adapter, client->addr + 1);
+	if (!data->fake_client) {
+		err = -ENOMEM;
+		goto exit_kfree;
+	}
+
+	/* Init real i2c_client */
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	err = sysfs_create_bin_file(&client->dev.kobj, &user_eeprom_attr);
+	if (err)
+		goto exit_remove_fake;
+
+	return 0;
+
+exit_remove_fake:
+	i2c_unregister_device(data->fake_client);
+exit_kfree:
+	kfree(data);
+	return err;
+}
+
+static int max6875_remove(struct i2c_client *client)
+{
+	struct max6875_data *data = i2c_get_clientdata(client);
+
+	i2c_unregister_device(data->fake_client);
+
+	sysfs_remove_bin_file(&client->dev.kobj, &user_eeprom_attr);
+	kfree(data);
+
+	return 0;
+}
+
+static const struct i2c_device_id max6875_id[] = {
+	{ "max6875", 0 },
+	{ }
+};
+
+static struct i2c_driver max6875_driver = {
+	.driver = {
+		.name	= "max6875",
+	},
+	.probe		= max6875_probe,
+	.remove		= max6875_remove,
+	.id_table	= max6875_id,
+
+	.detect		= max6875_detect,
+	.address_data	= &addr_data,
+};
+
+static int __init max6875_init(void)
+{
+	return i2c_add_driver(&max6875_driver);
+}
+
+static void __exit max6875_exit(void)
+{
+	i2c_del_driver(&max6875_driver);
+}
+
+
+MODULE_AUTHOR("Ben Gardner <bgardner-ohtLXRgXiI/QT0dZR+AlfA@public.gmane.org>");
+MODULE_DESCRIPTION("MAX6875 driver");
+MODULE_LICENSE("GPL");
+
+module_init(max6875_init);
+module_exit(max6875_exit);
-- 
1.6.2
