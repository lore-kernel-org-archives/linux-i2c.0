From: Jan Glauber <jglauber@cavium.com>
Subject: [Resend PATCH 05/10] i2c-octeon: Add support for cn78XX chips
Date: Mon, 29 Feb 2016 14:46:12 +0100
Message-ID: <f4acb786d0cbd93c40e3ed1a0c9ea87ec0b29983.1456752497.git.jglauber@cavium.com>
References: <cover.1456752497.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1456752497.git.jglauber@cavium.com>
In-Reply-To: <cover.1456752497.git.jglauber@cavium.com>
References: <cover.1456752497.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, ddaney@caviumnetworks.com, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

From: David Daney <ddaney@caviumnetworks.com>

cn78XX has a different interrupt architecture, so we have to manage
the interrupts differently.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 156 ++++++++++++++++++++++++++++++++++------
 1 file changed, 136 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index d48456a..0b28d8c 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -109,11 +110,18 @@ struct octeon_i2c {
 	wait_queue_head_t	queue;
 	struct i2c_adapter	adap;
 	int			irq;
+	int			hlc_irq;	/* For cn7890 only */
 	u32			twsi_freq;
 	int			sys_freq;
 	void __iomem		*twsi_base;
 	struct device		*dev;
 	bool			hlc_enabled;
+	void			(*int_en)	(struct octeon_i2c *);
+	void			(*int_dis)	(struct octeon_i2c *);
+	void			(*hlc_int_en)	(struct octeon_i2c *);
+	void			(*hlc_int_dis)	(struct octeon_i2c *);
+	atomic_t		int_en_cnt;
+	atomic_t		hlc_int_en_cnt;
 };
 
 static int reset_how;
@@ -215,6 +223,58 @@ static void octeon_i2c_disable_hlc(struct octeon_i2c *i2c)
 }
 
 /**
+ * octeon_i2c_int_enable78 - enable the CORE interrupt
+ * @i2c: The struct octeon_i2c
+ *
+ * The interrupt will be asserted when there is non-STAT_IDLE state in the
+ * SW_TWSI_EOP_TWSI_STAT register.
+ */
+static void octeon_i2c_int_enable78(struct octeon_i2c *i2c)
+{
+	atomic_inc_return(&i2c->int_en_cnt);
+	enable_irq(i2c->irq);
+}
+
+static void __octeon_i2c_irq_disable(atomic_t *cnt, int irq)
+{
+	int count;
+
+	/*
+	 * The interrupt can be disabled in two places, but we only
+	 * want to make the disable_irq_nosync() call once, so keep
+	 * track with the atomic variable.
+	 */
+	count = atomic_dec_if_positive(cnt);
+	if (count >= 0)
+		disable_irq_nosync(irq);
+}
+
+/* disable the CORE interrupt */
+static void octeon_i2c_int_disable78(struct octeon_i2c *i2c)
+{
+	__octeon_i2c_irq_disable(&i2c->int_en_cnt, i2c->irq);
+}
+
+/**
+ * octeon_i2c_hlc_int_enable78 - enable the ST interrupt
+ * @i2c: The struct octeon_i2c
+ *
+ * The interrupt will be asserted when there is non-STAT_IDLE state in
+ * the SW_TWSI_EOP_TWSI_STAT register.
+ */
+static void octeon_i2c_hlc_int_enable78(struct octeon_i2c *i2c)
+{
+	atomic_inc_return(&i2c->hlc_int_en_cnt);
+	enable_irq(i2c->hlc_irq);
+}
+
+/* disable the ST interrupt */
+static void octeon_i2c_hlc_int_disable78(struct octeon_i2c *i2c)
+{
+	__octeon_i2c_irq_disable(&i2c->hlc_int_en_cnt, i2c->hlc_irq);
+}
+
+/**
  * bitbang_unblock - unblock the bus
  * @i2c: The struct octeon_i2c
  *
@@ -251,7 +311,18 @@ static irqreturn_t octeon_i2c_isr(int irq, void *dev_id)
 {
 	struct octeon_i2c *i2c = dev_id;
 
-	octeon_i2c_int_disable(i2c);
+	i2c->int_dis(i2c);
+	wake_up(&i2c->queue);
+
+	return IRQ_HANDLED;
+}
+
+/* interrupt service routine */
+static irqreturn_t octeon_i2c_hlc_isr78(int irq, void *dev_id)
+{
+	struct octeon_i2c *i2c = dev_id;
+
+	i2c->hlc_int_dis(i2c);
 	wake_up(&i2c->queue);
 
 	return IRQ_HANDLED;
@@ -277,10 +348,10 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 {
 	long result;
 
-	octeon_i2c_int_enable(i2c);
+	i2c->int_en(i2c);
 	result = wait_event_timeout(i2c->queue, octeon_i2c_test_iflg(i2c),
 				    i2c->adap.timeout);
-	octeon_i2c_int_disable(i2c);
+	i2c->int_dis(i2c);
 	if (!result) {
 		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
 		return -ETIMEDOUT;
@@ -300,8 +371,8 @@ static int octeon_i2c_enable_hlc(struct octeon_i2c *i2c)
 
 	if (i2c->hlc_enabled)
 		return 0;
-	else
-		i2c->hlc_enabled = true;
+
+	i2c->hlc_enabled = true;
 
 	while (1) {
 		val = octeon_i2c_read_ctl(i2c) & (TWSI_CTL_STA | TWSI_CTL_STP);
@@ -635,11 +706,10 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 {
 	int result;
 
-	octeon_i2c_hlc_int_enable(i2c);
+	i2c->hlc_int_en(i2c);
 	result = wait_event_interruptible_timeout(i2c->queue,
-						  octeon_i2c_hlc_test_ready(i2c),
-						  i2c->adap.timeout);
-	octeon_i2c_int_disable(i2c);
+			octeon_i2c_hlc_test_ready(i2c), i2c->adap.timeout);
+	i2c->hlc_int_dis(i2c);
 	if (!result)
 		octeon_i2c_hlc_int_clear(i2c);
 
@@ -972,14 +1042,26 @@ static void octeon_i2c_setclock(struct octeon_i2c *i2c)
 static int octeon_i2c_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	int irq, result = 0;
+	int irq, hlc_irq = 0, result = 0;
 	struct resource *res_mem;
 	struct octeon_i2c *i2c;
-
-	/* All adaptors have an irq.  */
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	bool cn78xx_style;
+
+	cn78xx_style = of_device_is_compatible(node, "cavium,octeon-7890-twsi");
+	if (cn78xx_style) {
+		hlc_irq = platform_get_irq(pdev, 0);
+		if (hlc_irq < 0)
+			return hlc_irq;
+
+		irq = platform_get_irq(pdev, 2);
+		if (irq < 0)
+			return irq;
+	} else {
+		/* All adaptors have an irq.  */
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0)
+			return irq;
+	}
 
 	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c) {
@@ -1022,11 +1104,44 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 	init_waitqueue_head(&i2c->queue);
 	i2c->irq = irq;
 
-	result = devm_request_irq(&pdev->dev, i2c->irq,
-				  octeon_i2c_isr, 0, DRV_NAME, i2c);
-	if (result < 0) {
-		dev_err(i2c->dev, "failed to attach interrupt\n");
-		goto out;
+	if (cn78xx_style) {
+		i2c->hlc_irq = hlc_irq;
+
+		i2c->int_en = octeon_i2c_int_enable78;
+		i2c->int_dis = octeon_i2c_int_disable78;
+		i2c->hlc_int_en = octeon_i2c_hlc_int_enable78;
+		i2c->hlc_int_dis = octeon_i2c_hlc_int_disable78;
+
+		irq_set_status_flags(i2c->irq, IRQ_NOAUTOEN);
+		irq_set_status_flags(i2c->hlc_irq, IRQ_NOAUTOEN);
+
+		result = devm_request_irq(&pdev->dev, i2c->irq,
+					  octeon_i2c_isr, 0, DRV_NAME, i2c);
+
+		if (result < 0) {
+			dev_err(i2c->dev, "failed to attach interrupt\n");
+			goto out;
+		}
+		result = devm_request_irq(&pdev->dev, i2c->hlc_irq,
+					  octeon_i2c_hlc_isr78, 0,
+					  DRV_NAME, i2c);
+
+		if (result < 0) {
+			dev_err(i2c->dev, "failed to attach interrupt\n");
+			goto out;
+		}
+	} else {
+		i2c->int_en = octeon_i2c_int_enable;
+		i2c->int_dis = octeon_i2c_int_disable;
+		i2c->hlc_int_en = octeon_i2c_hlc_int_enable;
+		i2c->hlc_int_dis = octeon_i2c_int_disable;
+
+		result = devm_request_irq(&pdev->dev, i2c->irq,
+					  octeon_i2c_isr, 0, DRV_NAME, i2c);
+		if (result < 0) {
+			dev_err(i2c->dev, "failed to attach interrupt\n");
+			goto out;
+		}
 	}
 
 	result = octeon_i2c_initlowlevel(i2c);
@@ -1067,6 +1182,7 @@ static int octeon_i2c_remove(struct platform_device *pdev)
 
 static const struct of_device_id octeon_i2c_match[] = {
 	{	.compatible = "cavium,octeon-3860-twsi",	},
+	{	.compatible = "cavium,octeon-7890-twsi",	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, octeon_i2c_match);
-- 
1.9.1
