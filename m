From: Alessandro Rubini <rubini@gnudd.com>
Subject: [PATCH V3 1/3] i2c-nomadik: move header to
 <linux/platform_data/i2c-nomadik.h>
Date: Mon, 11 Jun 2012 22:56:26 +0200
Message-ID: <3389c7a8712e5b550ca89a5da468db2bbde6bff7.1339447570.git.rubini@gnudd.com>
References: <cover.1339447570.git.rubini@gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1339447570.git.rubini@gnudd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Wolfram Sang <w.sang@pengutronix.de>, Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

The header and driver are only used by arm/mach-u8500 (and potentially
arm/mach-nomadik), but the STA2X11 I/O Hub exports on PCIe a number of
devices, including i2c-nomadik.  This patch allows compilation of the
driver under x86.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c                 |    2 +-
 arch/arm/mach-ux500/devices-common.h               |    2 +-
 drivers/i2c/busses/i2c-nomadik.c                   |    3 +--
 .../linux/platform_data/i2c-nomadik.h              |    6 +++---
 4 files changed, 6 insertions(+), 7 deletions(-)
 rename arch/arm/plat-nomadik/include/plat/i2c.h => include/linux/platform_data/i2c-nomadik.h (91%)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 9c74ac5..0bf24bb 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
+#include <linux/platform_data/i2c-nomadik.h>
 #include <linux/gpio.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl022.h>
@@ -39,7 +40,6 @@
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
 
-#include <plat/i2c.h>
 #include <plat/ste_dma40.h>
 #include <plat/gpio-nomadik.h>
 
diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
index 6e47065..23cf734 100644
--- a/arch/arm/mach-ux500/devices-common.h
+++ b/arch/arm/mach-ux500/devices-common.h
@@ -12,7 +12,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/sys_soc.h>
 #include <linux/amba/bus.h>
-#include <plat/i2c.h>
+#include <linux/platform_data/i2c-nomadik.h>
 #include <mach/crypto-ux500.h>
 
 struct spi_master_cntlr;
diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 5267ab9..752f1fd 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -23,8 +23,7 @@
 #include <linux/io.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
-
-#include <plat/i2c.h>
+#include <linux/platform_data/i2c-nomadik.h>
 
 #define DRIVER_NAME "nmk-i2c"
 
diff --git a/arch/arm/plat-nomadik/include/plat/i2c.h b/include/linux/platform_data/i2c-nomadik.h
similarity index 91%
rename from arch/arm/plat-nomadik/include/plat/i2c.h
rename to include/linux/platform_data/i2c-nomadik.h
index 8ba70ff..c2303c3 100644
--- a/arch/arm/plat-nomadik/include/plat/i2c.h
+++ b/include/linux/platform_data/i2c-nomadik.h
@@ -5,8 +5,8 @@
  * it under the terms of the GNU General Public License version 2, as
  * published by the Free Software Foundation.
  */
-#ifndef __PLAT_I2C_H
-#define __PLAT_I2C_H
+#ifndef __PDATA_I2C_NOMADIK_H
+#define __PDATA_I2C_NOMADIK_H
 
 enum i2c_freq_mode {
 	I2C_FREQ_MODE_STANDARD,		/* up to 100 Kb/s */
@@ -36,4 +36,4 @@ struct nmk_i2c_controller {
 	enum i2c_freq_mode	sm;
 };
 
-#endif	/* __PLAT_I2C_H */
+#endif	/* __PDATA_I2C_NOMADIK_H */
-- 
1.7.7.2
