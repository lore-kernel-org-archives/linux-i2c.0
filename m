From: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 1/2] ARM nomadik: add platform specific i2c configuration structures
Date: Fri, 8 Jan 2010 16:01:57 +0530
Message-ID: <83f14c064ee8458e9895540da4ca03c0414d9474.1262944133.git.srinidhi.kasagar@stericsson.com>
References: <cover.1262944133.git.srinidhi.kasagar@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1262944133.git.srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, sachin.verma-qxv4g6HH51o@public.gmane.org, rubini-9wsNiZum9E8@public.gmane.org, andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This adds the platform specific i2c configuration
data structures to setup the nomadik/Ux500 I2C
block.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Acked-by: Andrea Gallo <andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 arch/arm/plat-nomadik/include/plat/i2c.h |   37 ++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-nomadik/include/plat/i2c.h

diff --git a/arch/arm/plat-nomadik/include/plat/i2c.h b/arch/arm/plat-nomadik/include/plat/i2c.h
new file mode 100644
index 0000000..1621db6
--- /dev/null
+++ b/arch/arm/plat-nomadik/include/plat/i2c.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2009 ST-Ericsson
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ */
+#ifndef __PLAT_I2C_H
+#define __PLAT_I2C_H
+
+enum i2c_freq_mode {
+	I2C_FREQ_MODE_STANDARD,		/* up to 100 Kb/s */
+	I2C_FREQ_MODE_FAST,		/* up to 400 Kb/s */
+	I2C_FREQ_MODE_FAST_PLUS,	/* up to 1 Mb/s */
+	I2C_FREQ_MODE_HIGH_SPEED	/* up to 3.4 Mb/s */
+};
+
+/**
+ * struct nmk_i2c_controller - client specific controller configuration
+ * @clk_freq:	clock frequency for the operation mode
+ * @slsu:	Slave data setup time in ns.
+ *		The needed setup time for three modes of operation
+ *		are 250ns, 100ns and 10ns respectively thus leading
+ *		to the values of 14, 6, 2 for a 48 MHz i2c clk
+ * @tft:	Tx FIFO Threshold in bytes
+ * @rft:	Rx FIFO Threshold in bytes
+ * @sm:		speed mode
+ */
+struct nmk_i2c_controller {
+	unsigned long	clk_freq;
+	unsigned short	slsu;
+	unsigned char 	tft;
+	unsigned char 	rft;
+	enum i2c_freq_mode	sm;
+};
+
+#endif	/* __PLAT_I2C_H */
-- 
1.6.3.GIT
