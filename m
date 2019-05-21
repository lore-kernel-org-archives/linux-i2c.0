From: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v6 3/3] i2c-ocores: sifive: add polling mode workaround for
 FU540-C000 SoC.
Date: Tue, 21 May 2019 19:02:54 +0530
Message-ID: <1558445574-16471-4-git-send-email-sagar.kadam@sifive.com>
References: <1558445574-16471-1-git-send-email-sagar.kadam@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
In-Reply-To: <1558445574-16471-1-git-send-email-sagar.kadam@sifive.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com, andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com, sagar.kadam@sifive.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The i2c-ocore driver already has a polling mode interface.But it needs
a workaround for FU540 Chipset on HiFive unleashed board (RevA00).
There is an erratum in FU540 chip that prevents interrupt driven i2c
transfers from working, and also the I2C controller's interrupt bit
cannot be cleared if set, due to this the existing i2c polling mode
interface added in mainline earlier doesn't work, and CPU stall's
infinitely, when-ever i2c transfer is initiated.

Ref:
	commit dd7dbf0eb090 ("i2c: ocores: refactor setup for polling")

The workaround / fix under OCORES_FLAG_BROKEN_IRQ is particularly for
FU540-COOO SoC.

The polling function identifies a SiFive device based on the device node
and enables the workaround.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/i2c/busses/i2c-ocores.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index b334fa2..3175c72 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -84,6 +84,10 @@ struct ocores_i2c {
 #define TYPE_GRLIB		1
 #define TYPE_SIFIVE_REV0	2
 
+#define OCORES_FLAG_BROKEN_IRQ BIT(1) /* Broken IRQ for FU540-C000 SoC */
+
+static const struct of_device_id ocores_i2c_match[];
+
 static void oc_setreg_8(struct ocores_i2c *i2c, int reg, u8 value)
 {
 	iowrite8(value, i2c->base + (reg << i2c->reg_shift));
@@ -236,9 +240,13 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
 	struct ocores_i2c *i2c = dev_id;
 	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
 
-	if (!(stat & OCI2C_STAT_IF))
+	if (irq == OCORES_FLAG_BROKEN_IRQ) {
+		if (stat & OCI2C_STAT_IF)
+			if (!(stat & OCI2C_STAT_BUSY))
+				return IRQ_NONE;
+	} else if (!(stat & OCI2C_STAT_IF)) {
 		return IRQ_NONE;
-
+	}
 	ocores_process(i2c, stat);
 
 	return IRQ_HANDLED;
@@ -340,6 +348,10 @@ static int ocores_poll_wait(struct ocores_i2c *i2c)
  */
 static void ocores_process_polling(struct ocores_i2c *i2c)
 {
+	const struct of_device_id *match;
+
+	match = of_match_node(ocores_i2c_match, i2c->adap.dev.of_node);
+
 	while (1) {
 		irqreturn_t ret;
 		int err;
@@ -350,9 +362,25 @@ static void ocores_process_polling(struct ocores_i2c *i2c)
 			break; /* timeout */
 		}
 
-		ret = ocores_isr(-1, i2c);
-		if (ret == IRQ_NONE)
-			break; /* all messages have been transferred */
+		/*
+		 * If it's a SiFive Device(FU540-C000 SoC ) use
+		 * OCORES_FLAG_BROKEN_IRQ to enable workaround in
+		 * polling mode.
+		 */
+		if (match && (long)match->data == TYPE_SIFIVE_REV0) {
+			ret = ocores_isr(OCORES_FLAG_BROKEN_IRQ, i2c);
+			if (ret == IRQ_NONE)
+				break; /* all messages have been transferred */
+			else
+				if (i2c->state == STATE_DONE)
+					break;
+		} else {
+			ret = ocores_isr(-1, i2c);
+			if (ret == IRQ_NONE)
+				break; /* all messages have been transferred */
+
+		}
+
 	}
 }
 
-- 
1.9.1
