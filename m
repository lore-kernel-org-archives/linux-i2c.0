From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c-pxa: move 'blue_murder'-function into DEBUG-section
Date: Thu, 29 Jan 2009 18:09:41 +0100
Message-ID: <1233248981-9637-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This talkative function is also called on timeouts. As timeouts can
happen on regular writes to EEPROMs (no error case), this creates false
positives. Giving lots of details only interesting for developers
anyhow, let's just use the function with activated DEBUG. Removes a bit
of code for regular users, too.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 6af6814..6010d9a 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -193,20 +193,6 @@ static void i2c_pxa_show_state(struct pxa_i2c *i2c, int lno, const char *fname)
 		readl(_ISR(i2c)), readl(_ICR(i2c)), readl(_IBMR(i2c)));
 }
 
-#define show_state(i2c) i2c_pxa_show_state(i2c, __LINE__, __func__)
-#else
-#define i2c_debug	0
-
-#define show_state(i2c) do { } while (0)
-#define decode_ISR(val) do { } while (0)
-#define decode_ICR(val) do { } while (0)
-#endif
-
-#define eedbg(lvl, x...) do { if ((lvl) < 1) { printk(KERN_DEBUG "" x); } } while(0)
-
-static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
-static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
-
 static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 {
 	unsigned int i;
@@ -220,6 +206,23 @@ static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 	printk("\n");
 }
 
+#define show_state(i2c) i2c_pxa_show_state(i2c, __LINE__, __func__)
+
+#else	/* DEBUG */
+
+#define i2c_debug	0
+#define show_state(i2c) do { } while (0)
+#define decode_ISR(val) do { } while (0)
+#define decode_ICR(val) do { } while (0)
+#define i2c_pxa_scream_blue_murder(i2c, why) do { } while (0)
+
+#endif	/* DEBUG */
+
+#define eedbg(lvl, x...) do { if ((lvl) < 1) { printk(KERN_DEBUG "" x); } } while(0)
+
+static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
+static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
+
 static inline int i2c_pxa_is_slavemode(struct pxa_i2c *i2c)
 {
 	return !(readl(_ICR(i2c)) & ICR_SCLE);
-- 
1.5.6.5
