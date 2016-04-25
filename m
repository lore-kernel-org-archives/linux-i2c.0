From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v7 07/15] i2c: octeon: Add support for cn78xx chips
Date: Mon, 25 Apr 2016 16:33:36 +0200
Message-ID: <1461594824-7215-8-git-send-email-jglauber@cavium.com>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

From: David Daney <david.daney@cavium.com>

cn78xx has a different interrupt architecture, so we have to manage
the interrupts differently.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 131 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 120 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 9520f78..76fa479 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/atomic.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -112,11 +113,18 @@ struct octeon_i2c {
 	wait_queue_head_t queue;
 	struct i2c_adapter adap;
 	int irq;
+	int hlc_irq;		/* For cn7890 only */
 	u32 twsi_freq;
 	int sys_freq;
 	void __iomem *twsi_base;
 	struct device *dev;
 	bool hlc_enabled;
+	void (*int_enable)(struct octeon_i2c *);
+	void (*int_disable)(struct octeon_i2c *);
+	void (*hlc_int_enable)(struct octeon_i2c *);
+	void (*hlc_int_disable)(struct octeon_i2c *);
+	atomic_t int_enable_cnt;
+	atomic_t hlc_int_enable_cnt;
 };
 
 static void octeon_i2c_writeq_flush(u64 val, void __iomem *addr)
@@ -217,6 +225,58 @@ static void octeon_i2c_int_disable(struct octeon_i2c *i2c)
 	octeon_i2c_write_int(i2c, 0);
 }
 
+/**
+ * octeon_i2c_int_enable78 - enable the CORE interrupt
+ * @i2c: The struct octeon_i2c
+ *
+ * The interrupt will be asserted when there is non-STAT_IDLE state in the
+ * SW_TWSI_EOP_TWSI_STAT register.
+ */
+static void octeon_i2c_int_enable78(struct octeon_i2c *i2c)
+{
+	atomic_inc_return(&i2c->int_enable_cnt);
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
+	__octeon_i2c_irq_disable(&i2c->int_enable_cnt, i2c->irq);
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
+	atomic_inc_return(&i2c->hlc_int_enable_cnt);
+	enable_irq(i2c->hlc_irq);
+}
+
+/* disable the ST interrupt */
+static void octeon_i2c_hlc_int_disable78(struct octeon_i2c *i2c)
+{
+	__octeon_i2c_irq_disable(&i2c->hlc_int_enable_cnt, i2c->hlc_irq);
+}
+
 /*
  * Cleanup low-level state & enable high-level controller.
  */
@@ -263,7 +323,18 @@ static irqreturn_t octeon_i2c_isr(int irq, void *dev_id)
 {
 	struct octeon_i2c *i2c = dev_id;
 
-	octeon_i2c_int_disable(i2c);
+	i2c->int_disable(i2c);
+	wake_up(&i2c->queue);
+
+	return IRQ_HANDLED;
+}
+
+/* HLC interrupt service routine */
+static irqreturn_t octeon_i2c_hlc_isr78(int irq, void *dev_id)
+{
+	struct octeon_i2c *i2c = dev_id;
+
+	i2c->hlc_int_disable(i2c);
 	wake_up(&i2c->queue);
 
 	return IRQ_HANDLED;
@@ -284,10 +355,10 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 {
 	long time_left;
 
-	octeon_i2c_int_enable(i2c);
+	i2c->int_enable(i2c);
 	time_left = wait_event_timeout(i2c->queue, octeon_i2c_test_iflg(i2c),
 				       i2c->adap.timeout);
-	octeon_i2c_int_disable(i2c);
+	i2c->int_disable(i2c);
 	if (!time_left) {
 		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
 		return -ETIMEDOUT;
@@ -385,11 +456,11 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 {
 	int time_left;
 
-	octeon_i2c_hlc_int_enable(i2c);
+	i2c->hlc_int_enable(i2c);
 	time_left = wait_event_timeout(i2c->queue,
 				       octeon_i2c_hlc_test_ready(i2c),
 				       i2c->adap.timeout);
-	octeon_i2c_int_disable(i2c);
+	i2c->hlc_int_disable(i2c);
 	if (!time_left) {
 		octeon_i2c_hlc_int_clear(i2c);
 		return -ETIMEDOUT;
@@ -942,14 +1013,26 @@ static struct i2c_adapter octeon_i2c_ops = {
 static int octeon_i2c_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
+	int irq, result = 0, hlc_irq = 0;
 	struct resource *res_mem;
 	struct octeon_i2c *i2c;
-	int irq, result = 0;
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
@@ -984,6 +1067,31 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 
 	i2c->irq = irq;
 
+	if (cn78xx_style) {
+		i2c->hlc_irq = hlc_irq;
+
+		i2c->int_enable = octeon_i2c_int_enable78;
+		i2c->int_disable = octeon_i2c_int_disable78;
+		i2c->hlc_int_enable = octeon_i2c_hlc_int_enable78;
+		i2c->hlc_int_disable = octeon_i2c_hlc_int_disable78;
+
+		irq_set_status_flags(i2c->irq, IRQ_NOAUTOEN);
+		irq_set_status_flags(i2c->hlc_irq, IRQ_NOAUTOEN);
+
+		result = devm_request_irq(&pdev->dev, i2c->hlc_irq,
+					  octeon_i2c_hlc_isr78, 0,
+					  DRV_NAME, i2c);
+		if (result < 0) {
+			dev_err(i2c->dev, "failed to attach interrupt\n");
+			goto out;
+		}
+	} else {
+		i2c->int_enable = octeon_i2c_int_enable;
+		i2c->int_disable = octeon_i2c_int_disable;
+		i2c->hlc_int_enable = octeon_i2c_hlc_int_enable;
+		i2c->hlc_int_disable = octeon_i2c_int_disable;
+	}
+
 	result = devm_request_irq(&pdev->dev, i2c->irq,
 				  octeon_i2c_isr, 0, DRV_NAME, i2c);
 	if (result < 0) {
@@ -1030,6 +1138,7 @@ static int octeon_i2c_remove(struct platform_device *pdev)
 
 static const struct of_device_id octeon_i2c_match[] = {
 	{ .compatible = "cavium,octeon-3860-twsi", },
+	{ .compatible = "cavium,octeon-7890-twsi", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, octeon_i2c_match);
-- 
1.9.1
