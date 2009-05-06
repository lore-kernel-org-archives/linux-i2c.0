From: Michael Abbott <michael-W/Bzo8D1sxa8qtKVGud/9w@public.gmane.org>
Subject: [PATCH 2.6.29.2] PXA I2C: Define log level for i2c PXA error report
Date: Wed, 6 May 2009 08:32:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0905060829580.24668@venus.araneidae.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

All the i2c pxa error messages should probably be KERN_DEBUG

At least, all the printk messages should have a log level specfied,
and KERN_DEBUG seems appropriate.

Signed-off-by: Michael Abbott <michael.abbott-l+PWtdWbHAs2EctHIo1CcQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index bdb1f75..8cb9160 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -210,11 +210,11 @@ static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
 static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 {
 	unsigned int i;
-	printk("i2c: error: %s\n", why);
-	printk("i2c: msg_num: %d msg_idx: %d msg_ptr: %d\n",
+	printk(KERN_DEBUG "i2c: error: %s\n", why);
+	printk(KERN_DEBUG "i2c: msg_num: %d msg_idx: %d msg_ptr: %d\n",
 		i2c->msg_num, i2c->msg_idx, i2c->msg_ptr);
-	printk("i2c: ICR: %08x ISR: %08x\n"
-	       "i2c: log: ", readl(_ICR(i2c)), readl(_ISR(i2c)));
+	printk(KERN_DEBUG "i2c: ICR: %08x ISR: %08x\n"
+	       KERN_DEBUG "i2c: log: ", readl(_ICR(i2c)), readl(_ISR(i2c)));
 	for (i = 0; i < i2c->irqlogidx; i++)
 		printk("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
 	printk("\n");
-- 
1.6.1.3
