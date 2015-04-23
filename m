From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: st: add include for pinctrl
Date: Thu, 23 Apr 2015 13:42:02 +0200
Message-ID: <1429789322-27260-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The driver uses pinctrl directly and thus should include the appropriate
header. Sort the headers while we are here to have a better view what is
included and what is not.

Reported-by: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-st.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 88057fad9dfef4..d525769db5c3d5 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -10,17 +10,18 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/i2c.h>
 #include <linux/clk.h>
-#include <linux/io.h>
 #include <linux/delay.h>
-#include <linux/interrupt.h>
 #include <linux/err.h>
-#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
 
 /* SSC registers */
 #define SSC_BRG				0x000
-- 
2.1.4
