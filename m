From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: [PATCH 2/3] [OMAP:I2C]In case of a NACK|ARDY|AL return from the ISR
Date: Tue, 21 Jul 2009 10:14:40 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202958D2F88@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

In case of a NACK or ARDY or AL interrupt, complete the request.
There is no need to service the RRDY/RDR or XRDY/XDR interrupts.

Refer TRM SWPU114: Figure 18-31.I2C Master Transmitter Mode, Interrupt Method,
in F/S and HS Modes

http://focus.ti.com/pdfs/wtbu/SWPU114T_PrelimFinalEPDF_06_25_2009.pdf

Signed-off-by: Moiz Sonasath<m-sonasath@ti.com>
Signed-off-by: Vikram pandita<vikram.pandita@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d280acf..05b5e4c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -685,8 +685,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			err |= OMAP_I2C_STAT_AL;
 		}
 		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
-					OMAP_I2C_STAT_AL))
+					OMAP_I2C_STAT_AL)) {
 			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
+		}
 		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
 			u8 num_bytes = 1;
 			if (dev->fifo_size) {
-- 
1.5.6.3

