From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/6] i2c: i2c-core: sort includes
Date: Sat, 20 Feb 2016 23:38:47 +0100
Message-ID: <1456007931-4595-3-git-send-email-wsa@the-dreams.de>
References: <1456007931-4595-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55902 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992811AbcBTWjD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 20 Feb 2016 17:39:03 -0500
In-Reply-To: <1456007931-4595-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

I request this for drivers, so the core should adhere to sorted includes as
well.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index ffe715d346d884..2949ab3c2293ad 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -28,32 +28,32 @@
  */
 
 #include <dt-bindings/i2c/i2c.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
+#include <asm/uaccess.h>
+#include <linux/acpi.h>
+#include <linux/clk/clk-conf.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gpio.h>
-#include <linux/slab.h>
+#include <linux/hardirq.h>
 #include <linux/i2c.h>
-#include <linux/init.h>
 #include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/jump_label.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/clk/clk-conf.h>
-#include <linux/completion.h>
-#include <linux/hardirq.h>
-#include <linux/irqflags.h>
-#include <linux/rwsem.h>
-#include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
-#include <linux/acpi.h>
-#include <linux/jump_label.h>
-#include <asm/uaccess.h>
-#include <linux/err.h>
 #include <linux/property.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
 
 #include "i2c-core.h"
 
-- 
2.7.0
