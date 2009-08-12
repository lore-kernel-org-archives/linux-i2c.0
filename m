From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] U300 I2C board setup
Date: Wed, 12 Aug 2009 11:06:10 +0200
Message-ID: <1250067970-17639-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This sets up the U300 I2C subdevices so that the AB3100
analog baseband ASIC is properly detected and also the
camera devices in the U335 reference design get properly
registered.

Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
----
This is meant to be applied on top of the previous SPI board
info patch but can probably be applied cleanly by itself as
well.
---
 arch/arm/mach-u300/Makefile |    1 +
 arch/arm/mach-u300/core.c   |    8 ++++++--
 arch/arm/mach-u300/i2c.c    |   43 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-u300/i2c.h    |   23 +++++++++++++++++++++++
 4 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-u300/i2c.c
 create mode 100644 arch/arm/mach-u300/i2c.h

diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
index 4941f89..885b5c0 100644
--- a/arch/arm/mach-u300/Makefile
+++ b/arch/arm/mach-u300/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_ARCH_U300)	          += u300.o
 obj-$(CONFIG_MMC)                 += mmc.o
 obj-$(CONFIG_SPI_PL022)           += spi.o
 obj-$(CONFIG_MACH_U300_SPIDUMMY)  += dummyspichip.o
+obj-$(CONFIG_I2C_STU300)          += i2c.o
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 905b120..d4cca25 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -33,6 +33,7 @@
 #include "clock.h"
 #include "mmc.h"
 #include "spi.h"
+#include "i2c.h"
 
 /*
  * Static I/O mappings that are needed for booting the U300 platforms. The
@@ -379,14 +380,14 @@ static struct platform_device wdog_device = {
 };
 
 static struct platform_device i2c0_device = {
-	.name = "stddci2c",
+	.name = "stu300",
 	.id = 0,
 	.num_resources = ARRAY_SIZE(i2c0_resources),
 	.resource = i2c0_resources,
 };
 
 static struct platform_device i2c1_device = {
-	.name = "stddci2c",
+	.name = "stu300",
 	.id = 1,
 	.num_resources = ARRAY_SIZE(i2c1_resources),
 	.resource = i2c1_resources,
@@ -625,6 +626,9 @@ void __init u300_init_devices(void)
 
 	u300_assign_physmem();
 
+	/* Register subdevices on the I2C buses */
+	u300_i2c_register_board_devices();
+
 	/* Register subdevices on the SPI bus */
 	u300_spi_register_board_devices();
 
diff --git a/arch/arm/mach-u300/i2c.c b/arch/arm/mach-u300/i2c.c
new file mode 100644
index 0000000..d866443
--- /dev/null
+++ b/arch/arm/mach-u300/i2c.c
@@ -0,0 +1,43 @@
+/*
+ * arch/arm/mach-u300/i2c.c
+ *
+ * Copyright (C) 2009 ST-Ericsson AB
+ * License terms: GNU General Public License (GPL) version 2
+ *
+ * Register board i2c devices
+ * Author: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
+ */
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <mach/irqs.h>
+
+static struct i2c_board_info __initdata bus0_i2c_board_info[] = {
+	{
+		.type = "ab3100",
+		.addr = 0x48,
+		.irq = IRQ_U300_IRQ0_EXT,
+	},
+};
+
+static struct i2c_board_info __initdata bus1_i2c_board_info[] = {
+#ifdef CONFIG_MACH_U300_BS335
+	{
+		.type = "fwcam",
+		.addr = 0x10,
+	},
+	{
+		.type = "fwcam",
+		.addr = 0x5d,
+	},
+#else
+	{ },
+#endif
+};
+
+void u300_i2c_register_board_devices(void)
+{
+	i2c_register_board_info(0, bus0_i2c_board_info,
+				ARRAY_SIZE(bus0_i2c_board_info));
+	i2c_register_board_info(1, bus1_i2c_board_info,
+				ARRAY_SIZE(bus1_i2c_board_info));
+}
diff --git a/arch/arm/mach-u300/i2c.h b/arch/arm/mach-u300/i2c.h
new file mode 100644
index 0000000..84f2efb
--- /dev/null
+++ b/arch/arm/mach-u300/i2c.h
@@ -0,0 +1,23 @@
+/*
+ * arch/arm/mach-u300/i2c.h
+ *
+ * Copyright (C) 2009 ST-Ericsson AB
+ * License terms: GNU General Public License (GPL) version 2
+ *
+ * Register board i2c devices
+ * Author: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
+ */
+
+#ifndef MACH_U300_I2C_H
+#define MACH_U300_I2C_H
+
+#ifdef CONFIG_I2C_STU300
+void u300_i2c_register_board_devices(void);
+#else
+/* Compile out this stuff if no I2C adapter is available */
+static inline void u300_i2c_register_board_devices(void)
+{
+}
+#endif
+
+#endif
-- 
1.6.2.1
