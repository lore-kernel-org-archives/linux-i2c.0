From: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v1 v1 3/3] i2c-ocores: sifive: add polling mode workaround for FU540-C000 SoC.
Date: Mon,  6 May 2019 18:24:00 +0530
Message-ID: <1557147240-29551-4-git-send-email-sagar.kadam@sifive.com>
References: <1557147240-29551-1-git-send-email-sagar.kadam@sifive.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557147240-29551-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, palmer@sifive.com, paul.walmsley@sifive.com, sagar.kadam@sifive.com, peter@korsgaard.com, andrew@lunn.ch, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The i2c-ocore driver already has a polling mode interface.But it needs
a workaround for FU540 Chipset on HiFive unleashed board (RevA00).
There is an erratum in FU540 chip that prevents interrupt driven i2c
transfers from working, and also the I2C controller's interrupt bit
cannot be cleared if set, due to this the existing i2c polling mode
interface added in mainline earlier doesn't work, and CPU stall's
infinitely, when-ever i2c transfer is initiated.

	commit 69c8c0c0efa8 ("i2c: ocores: add polling interface")

The workaround / fix is particularly for FU540-COOO SoC.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/i2c/busses/i2c-ocores.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 7bf7b0c..08cdfed 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -27,6 +27,7 @@
 #include <linux/jiffies.h>
 
 #define OCORES_FLAG_POLL BIT(0)
+#define SIFIVE_FLAG_POLL BIT(1)
 
 /*
  * 'process_lock' exists because ocores_process() and ocores_process_timeout()
@@ -239,8 +240,13 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
 	struct ocores_i2c *i2c = dev_id;
 	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
 
-	if (!(stat & OCI2C_STAT_IF))
+	if (i2c->flags && SIFIVE_FLAG_POLL) {
+		if (stat & OCI2C_STAT_IF)
+			if (!(stat & OCI2C_STAT_BUSY))
+				return IRQ_NONE;
+	} else if (!(stat & OCI2C_STAT_IF)) {
 		return IRQ_NONE;
+	}
 
 	ocores_process(i2c, stat);
 
@@ -356,6 +362,11 @@ static void ocores_process_polling(struct ocores_i2c *i2c)
 		ret = ocores_isr(-1, i2c);
 		if (ret == IRQ_NONE)
 			break; /* all messages have been transferred */
+		else {
+			if (i2c->flags && SIFIVE_FLAG_POLL)
+				if (i2c->state == STATE_DONE)
+					break;
+		}
 	}
 }
 
@@ -406,7 +417,7 @@ static int ocores_xfer(struct i2c_adapter *adap,
 {
 	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
 
-	if (i2c->flags & OCORES_FLAG_POLL)
+	if ((i2c->flags & OCORES_FLAG_POLL) || (i2c->flags & SIFIVE_FLAG_POLL))
 		return ocores_xfer_polling(adap, msgs, num);
 	return ocores_xfer_core(i2c, msgs, num, false);
 }
@@ -597,6 +608,7 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c;
 	struct ocores_i2c_platform_data *pdata;
+	const struct of_device_id *match;
 	struct resource *res;
 	int irq;
 	int ret;
@@ -678,13 +690,21 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq == -ENXIO) {
-		i2c->flags |= OCORES_FLAG_POLL;
+		/*
+		 * Set a SIFIVE_FLAG_POLL to enable workaround for FU540
+		 * in polling mode interface of i2c-ocore driver.
+		 */
+		match = of_match_node(ocores_i2c_match, pdev->dev.of_node);
+		if (match && (long)match->data == TYPE_SIFIVE_REV0)
+			i2c->flags |= SIFIVE_FLAG_POLL;
+		else
+			i2c->flags |= OCORES_FLAG_POLL;
 	} else {
 		if (irq < 0)
 			return irq;
 	}
 
-	if (!(i2c->flags & OCORES_FLAG_POLL)) {
+	if (!(i2c->flags & (OCORES_FLAG_POLL | SIFIVE_FLAG_POLL))) {
 		ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
 				       pdev->name, i2c);
 		if (ret) {
-- 
1.9.1
