From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: nomadik: drop superfluous variable initialization
Date: Thu, 24 Jan 2013 11:30:24 +0100
Message-ID: <1359023424-9280-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

cppcheck rightfully reports those as "reassigned a value before the old
one has been used."

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index dd6a691..5b1b194 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -412,8 +412,7 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
 static int read_i2c(struct nmk_i2c_dev *dev, u16 flags)
 {
 	u32 status = 0;
-	u32 mcr;
-	u32 irq_mask = 0;
+	u32 mcr, irq_mask;
 	int timeout;
 
 	mcr = load_i2c_mcr_reg(dev, flags);
@@ -482,8 +481,7 @@ static void fill_tx_fifo(struct nmk_i2c_dev *dev, int no_bytes)
 static int write_i2c(struct nmk_i2c_dev *dev, u16 flags)
 {
 	u32 status = 0;
-	u32 mcr;
-	u32 irq_mask = 0;
+	u32 mcr, irq_mask;
 	int timeout;
 
 	mcr = load_i2c_mcr_reg(dev, flags);
@@ -731,8 +729,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 	struct nmk_i2c_dev *dev = arg;
 	u32 tft, rft;
 	u32 count;
-	u32 misr;
-	u32 src = 0;
+	u32 misr, src;
 
 	/* load Tx FIFO and Rx FIFO threshold values */
 	tft = readl(dev->virtbase + I2C_TFTR);
-- 
1.7.10.4
