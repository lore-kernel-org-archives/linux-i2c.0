From: alex.williams@ettus.com
Subject: [PATCH] i2c: cadence: Handle transfer_size rollover
Date: Thu, 31 Jan 2019 13:39:57 -0800
Message-ID: <20190131213957.11568-1-alex.williams@ettus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mical.simek@xilinx.com
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williams <alex.williams@ni.com>
List-Id: linux-i2c@vger.kernel.org

From: Alex Williams <alex.williams@ni.com>

Under certain conditions, Cadence's I2C controller's transfer_size
register will roll over and generate invalid read transactions. Before
this change, the ISR relied solely on the RXDV bit to determine when to
write more data to the user's buffer. The invalid read data would cause
overruns, smashing stacks and worse.

This change stops the buffer writes to the requested boundary and
reports the error. The controller will be reset so normal transactions
may resume.

Signed-off-by: Alex Williams <alex.williams@ni.com>
---
 drivers/i2c/busses/i2c-cadence.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b13605718291..64e1d9e888c3 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -213,6 +213,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 
 	isr_status = cdns_i2c_readreg(CDNS_I2C_ISR_OFFSET);
 	cdns_i2c_writereg(isr_status, CDNS_I2C_ISR_OFFSET);
+	id->err_status = 0;
 
 	/* Handling nack and arbitration lost interrupt */
 	if (isr_status & (CDNS_I2C_IXR_NACK | CDNS_I2C_IXR_ARB_LOST)) {
@@ -246,10 +247,17 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 			    !id->bus_hold_flag)
 				cdns_i2c_clear_bus_hold(id);
 
-			*(id->p_recv_buf)++ =
-				cdns_i2c_readreg(CDNS_I2C_DATA_OFFSET);
-			id->recv_count--;
-			id->curr_recv_count--;
+			if (id->recv_count > 0) {
+				*(id->p_recv_buf)++ =
+					cdns_i2c_readreg(CDNS_I2C_DATA_OFFSET);
+				id->recv_count--;
+				id->curr_recv_count--;
+			} else {
+				dev_err(id->adap.dev.parent,
+					"xfer_size reg rollover. xfer aborted!\n");
+				id->err_status |= CDNS_I2C_IXR_TO;
+				break;
+			}
 
 			if (cdns_is_holdquirk(id, hold_quirk))
 				break;
@@ -347,7 +355,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 	}
 
 	/* Update the status for errors */
-	id->err_status = isr_status & CDNS_I2C_IXR_ERR_INTR_MASK;
+	id->err_status |= isr_status & CDNS_I2C_IXR_ERR_INTR_MASK;
 	if (id->err_status)
 		status = IRQ_HANDLED;
 
-- 
2.14.5
