From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] mfd: Fix I2C_DESIGNWARE_PLATFORM dependencies
Date: Mon, 21 Jan 2019 16:11:28 +0200
Message-ID: <20190121141128.5283-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, Hans de Goede <hdegoede@redhat.com>, Rajmohan Mani <rajmohan.mani@intel.com>, linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Stable <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

INTEL_SOC_PMIC, INTEL_SOC_PMIC_CHTWC and MFD_TPS68470 select the
I2C_DESIGNWARE_PLATFORM without its dependencies making it possible to see
warning and build error like below:

WARNING: unmet direct dependencies detected for I2C_DESIGNWARE_PLATFORM
  Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ACPI [=y] && COMMON_CLK [=n] || !ACPI [=y])
  Selected by [y]:
  - MFD_TPS68470 [=y] && HAS_IOMEM [=y] && ACPI [=y] && I2C [=y]=y

/usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_resume':
i2c-designware-platdrv.c:(.text+0x62): undefined reference to `i2c_dw_prepare_clk'
/usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_suspend':
i2c-designware-platdrv.c:(.text+0x9a): undefined reference to `i2c_dw_prepare_clk'
/usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_probe':
i2c-designware-platdrv.c:(.text+0x41c): undefined reference to `i2c_dw_prepare_clk'
/usr/bin/ld: i2c-designware-platdrv.c:(.text+0x438): undefined reference to `i2c_dw_read_comp_param'
/usr/bin/ld: i2c-designware-platdrv.c:(.text+0x545): undefined reference to `i2c_dw_probe'
/usr/bin/ld: i2c-designware-platdrv.c:(.text+0x727): undefined reference to `i2c_dw_probe_slave'

Fix this by making above options to depend on I2C_DESIGNWARE_PLATFORM
being built-in. I2C_DESIGNWARE_PLATFORM is a visible symbol with
dependencies so in general the select should be avoided.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: acebcff9eda8 ("mfd: intel_soc_pmic: Select designware i2c-bus driver")
Fixes: de85d79f4aab ("mfd: Add Cherry Trail Whiskey Cove PMIC driver")
Fixes: 9bbf6a15ce19 ("mfd: Add support for TPS68470 device")
Cc: Stable <stable@vger.kernel.org> # v4.14+
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/mfd/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f461460a2aeb..6a84a8ecd4a9 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -519,10 +519,10 @@ config INTEL_SOC_PMIC
 	bool "Support for Crystal Cove PMIC"
 	depends on ACPI && HAS_IOMEM && I2C=y && GPIOLIB && COMMON_CLK
 	depends on X86 || COMPILE_TEST
+	depends on I2C_DESIGNWARE_PLATFORM=y
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
-	select I2C_DESIGNWARE_PLATFORM
 	help
 	  Select this option to enable support for Crystal Cove PMIC
 	  on some Intel SoC systems. The PMIC provides ADC, GPIO,
@@ -548,10 +548,10 @@ config INTEL_SOC_PMIC_CHTWC
 	bool "Support for Intel Cherry Trail Whiskey Cove PMIC"
 	depends on ACPI && HAS_IOMEM && I2C=y && COMMON_CLK
 	depends on X86 || COMPILE_TEST
+	depends on I2C_DESIGNWARE_PLATFORM=y
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
-	select I2C_DESIGNWARE_PLATFORM
 	help
 	  Select this option to enable support for the Intel Cherry Trail
 	  Whiskey Cove PMIC found on some Intel Cherry Trail systems.
@@ -1420,9 +1420,9 @@ config MFD_TPS65217
 config MFD_TPS68470
 	bool "TI TPS68470 Power Management / LED chips"
 	depends on ACPI && I2C=y
+	depends on I2C_DESIGNWARE_PLATFORM=y
 	select MFD_CORE
 	select REGMAP_I2C
-	select I2C_DESIGNWARE_PLATFORM
 	help
 	  If you say yes here you get support for the TPS68470 series of
 	  Power Management / LED chips.
-- 
2.20.1
