From: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Subject: [PATCH 2/6] i2x: Xilinx IIC: remove non-initial tabs
Date: Fri, 31 Jul 2015 14:00:30 +0200
Message-ID: <1438344034-20211-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438344034-20211-1-git-send-email-rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c | 110 +++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index dd897b5..e566ccb 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -48,28 +48,28 @@ enum xilinx_i2c_state {
 
 /**
  * struct xiic_i2c - Internal representation of the XIIC I2C bus
- * @base:	Memory base of the HW registers
- * @wait:	Wait queue for callers
- * @adap:	Kernel adapter representation
- * @tx_msg:	Messages from above to be sent
- * @lock:	Mutual exclusion
- * @tx_pos:	Current pos in TX message
- * @nmsgs:	Number of messages in tx_msg
- * @state:	See STATE_
- * @rx_msg:	Current RX message
- * @rx_pos:	Position within current RX message
+ * @base:   Memory base of the HW registers
+ * @wait:   Wait queue for callers
+ * @adap:   Kernel adapter representation
+ * @tx_msg: Messages from above to be sent
+ * @lock:   Mutual exclusion
+ * @tx_pos: Position within current TX message
+ * @nmsgs:  Number of messages in tx_msg
+ * @state:  Current controller state
+ * @rx_msg: Current RX message
+ * @rx_pos: Position within current RX message
  */
 struct xiic_i2c {
-	void __iomem		*base;
-	wait_queue_head_t	wait;
-	struct i2c_adapter	adap;
-	struct i2c_msg		*tx_msg;
-	spinlock_t		lock;
-	unsigned int		tx_pos;
-	unsigned int		nmsgs;
-	enum xilinx_i2c_state	state;
-	struct i2c_msg		*rx_msg;
-	int			rx_pos;
+	void __iomem *        base;
+	wait_queue_head_t     wait;
+	struct i2c_adapter    adap;
+	struct i2c_msg        *tx_msg;
+	spinlock_t            lock;
+	unsigned int          tx_pos;
+	unsigned int          nmsgs;
+	enum xilinx_i2c_state state;
+	struct i2c_msg        *rx_msg;
+	int                   rx_pos;
 };
 
 
@@ -78,49 +78,49 @@ struct xiic_i2c {
 /*
  * Register offsets in bytes from RegisterBase.
  */
-#define XIIC_CR_REG   (0x00+XIIC_REG_OFFSET)	/* Control Register   */
-#define XIIC_SR_REG   (0x04+XIIC_REG_OFFSET)	/* Status Register    */
-#define XIIC_DTR_REG  (0x08+XIIC_REG_OFFSET)	/* Data Tx Register   */
-#define XIIC_DRR_REG  (0x0C+XIIC_REG_OFFSET)	/* Data Rx Register   */
-#define XIIC_ADR_REG  (0x10+XIIC_REG_OFFSET)	/* Address Register   */
-#define XIIC_TFO_REG  (0x14+XIIC_REG_OFFSET)	/* Tx FIFO Occupancy  */
-#define XIIC_RFO_REG  (0x18+XIIC_REG_OFFSET)	/* Rx FIFO Occupancy  */
-#define XIIC_TBA_REG  (0x1C+XIIC_REG_OFFSET)	/* 10 Bit Address reg */
-#define XIIC_RFD_REG  (0x20+XIIC_REG_OFFSET)	/* Rx FIFO Depth reg  */
-#define XIIC_GPO_REG  (0x24+XIIC_REG_OFFSET)	/* Output Register    */
+#define XIIC_CR_REG   (0x00+XIIC_REG_OFFSET) /* Control Register   */
+#define XIIC_SR_REG   (0x04+XIIC_REG_OFFSET) /* Status Register    */
+#define XIIC_DTR_REG  (0x08+XIIC_REG_OFFSET) /* Data Tx Register   */
+#define XIIC_DRR_REG  (0x0C+XIIC_REG_OFFSET) /* Data Rx Register   */
+#define XIIC_ADR_REG  (0x10+XIIC_REG_OFFSET) /* Address Register   */
+#define XIIC_TFO_REG  (0x14+XIIC_REG_OFFSET) /* Tx FIFO Occupancy  */
+#define XIIC_RFO_REG  (0x18+XIIC_REG_OFFSET) /* Rx FIFO Occupancy  */
+#define XIIC_TBA_REG  (0x1C+XIIC_REG_OFFSET) /* 10 Bit Address reg */
+#define XIIC_RFD_REG  (0x20+XIIC_REG_OFFSET) /* Rx FIFO Depth reg  */
+#define XIIC_GPO_REG  (0x24+XIIC_REG_OFFSET) /* Output Register    */
 
 /* Control Register masks */
-#define XIIC_CR_ENABLE_DEVICE_MASK        0x01	/* Device enable = 1      */
-#define XIIC_CR_TX_FIFO_RESET_MASK        0x02	/* Transmit FIFO reset=1  */
-#define XIIC_CR_MSMS_MASK                 0x04	/* Master starts Txing=1  */
-#define XIIC_CR_DIR_IS_TX_MASK            0x08	/* Dir of tx. Txing=1     */
-#define XIIC_CR_NO_ACK_MASK               0x10	/* Tx Ack. NO ack = 1     */
-#define XIIC_CR_REPEATED_START_MASK       0x20	/* Repeated start = 1     */
-#define XIIC_CR_GENERAL_CALL_MASK         0x40	/* Gen Call enabled = 1   */
+#define XIIC_CR_ENABLE_DEVICE_MASK        0x01 /* Device enable = 1      */
+#define XIIC_CR_TX_FIFO_RESET_MASK        0x02 /* Transmit FIFO reset=1  */
+#define XIIC_CR_MSMS_MASK                 0x04 /* Master starts Txing=1  */
+#define XIIC_CR_DIR_IS_TX_MASK            0x08 /* Dir of tx. Txing=1     */
+#define XIIC_CR_NO_ACK_MASK               0x10 /* Tx Ack. NO ack = 1     */
+#define XIIC_CR_REPEATED_START_MASK       0x20 /* Repeated start = 1     */
+#define XIIC_CR_GENERAL_CALL_MASK         0x40 /* Gen Call enabled = 1   */
 
 /* Status Register masks */
-#define XIIC_SR_GEN_CALL_MASK             0x01	/* 1=a mstr issued a GC   */
-#define XIIC_SR_ADDR_AS_SLAVE_MASK        0x02	/* 1=when addr as slave   */
-#define XIIC_SR_BUS_BUSY_MASK             0x04	/* 1 = bus is busy        */
-#define XIIC_SR_MSTR_RDING_SLAVE_MASK     0x08	/* 1=Dir: mstr <-- slave  */
-#define XIIC_SR_TX_FIFO_FULL_MASK         0x10	/* 1 = Tx FIFO full       */
-#define XIIC_SR_RX_FIFO_FULL_MASK         0x20	/* 1 = Rx FIFO full       */
-#define XIIC_SR_RX_FIFO_EMPTY_MASK        0x40	/* 1 = Rx FIFO empty      */
-#define XIIC_SR_TX_FIFO_EMPTY_MASK        0x80	/* 1 = Tx FIFO empty      */
+#define XIIC_SR_GEN_CALL_MASK             0x01 /* 1=a mstr issued a GC   */
+#define XIIC_SR_ADDR_AS_SLAVE_MASK        0x02 /* 1=when addr as slave   */
+#define XIIC_SR_BUS_BUSY_MASK             0x04 /* 1 = bus is busy        */
+#define XIIC_SR_MSTR_RDING_SLAVE_MASK     0x08 /* 1=Dir: mstr <-- slave  */
+#define XIIC_SR_TX_FIFO_FULL_MASK         0x10 /* 1 = Tx FIFO full       */
+#define XIIC_SR_RX_FIFO_FULL_MASK         0x20 /* 1 = Rx FIFO full       */
+#define XIIC_SR_RX_FIFO_EMPTY_MASK        0x40 /* 1 = Rx FIFO empty      */
+#define XIIC_SR_TX_FIFO_EMPTY_MASK        0x80 /* 1 = Tx FIFO empty      */
 
 /* Interrupt Status Register masks    Interrupt occurs when...       */
-#define XIIC_INTR_ARB_LOST_MASK           0x01	/* 1 = arbitration lost   */
-#define XIIC_INTR_TX_ERROR_MASK           0x02	/* 1=Tx error/msg complete */
-#define XIIC_INTR_TX_EMPTY_MASK           0x04	/* 1 = Tx FIFO/reg empty  */
-#define XIIC_INTR_RX_FULL_MASK            0x08	/* 1=Rx FIFO/reg=OCY level */
-#define XIIC_INTR_BNB_MASK                0x10	/* 1 = Bus not busy       */
-#define XIIC_INTR_AAS_MASK                0x20	/* 1 = when addr as slave */
-#define XIIC_INTR_NAAS_MASK               0x40	/* 1 = not addr as slave  */
-#define XIIC_INTR_TX_HALF_MASK            0x80	/* 1 = TX FIFO half empty */
+#define XIIC_INTR_ARB_LOST_MASK           0x01 /* 1 = arbitration lost   */
+#define XIIC_INTR_TX_ERROR_MASK           0x02 /* 1=Tx error/msg complete */
+#define XIIC_INTR_TX_EMPTY_MASK           0x04 /* 1 = Tx FIFO/reg empty  */
+#define XIIC_INTR_RX_FULL_MASK            0x08 /* 1=Rx FIFO/reg=OCY level */
+#define XIIC_INTR_BNB_MASK                0x10 /* 1 = Bus not busy       */
+#define XIIC_INTR_AAS_MASK                0x20 /* 1 = when addr as slave */
+#define XIIC_INTR_NAAS_MASK               0x40 /* 1 = not addr as slave  */
+#define XIIC_INTR_TX_HALF_MASK            0x80 /* 1 = TX FIFO half empty */
 
 /* The following constants specify the depth of the FIFOs */
-#define IIC_RX_FIFO_DEPTH         16	/* Rx fifo capacity               */
-#define IIC_TX_FIFO_DEPTH         16	/* Tx fifo capacity               */
+#define IIC_RX_FIFO_DEPTH         16 /* Rx fifo capacity               */
+#define IIC_TX_FIFO_DEPTH         16 /* Tx fifo capacity               */
 
 /* The following constants specify groups of interrupts that are typically
  * enabled or disables at the same time
-- 
2.5.0
