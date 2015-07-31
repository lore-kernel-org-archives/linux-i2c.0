From: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Subject: [PATCH 4/6] i2c: Xilinx IIC: completely redo FSM/ISR logic
Date: Fri, 31 Jul 2015 14:00:32 +0200
Message-ID: <1438344034-20211-6-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438344034-20211-1-git-send-email-rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The XIIC driver was in a very poor state and would cause a NULL ptr der=
eference
for me as soon as it was used. There was no mutual exclusion when manip=
ulating
shared data/state variables.

The whole tx/rx message logic was also not safe from being pre-empted, =
so actually
writing to/reading data from an I2C slave was a matter of pure luck as =
XIIC requires
precise timing when writing to/reading from the TX/RX FIFO.

To keep things simple, the new implementation only ever enqueues one me=
ssage,
whereas the old implementation could enqueue multiple tx messages and o=
ne
rx message.
However, discovering which state the XIIC is in and recovering from pos=
sible errors
proves very difficult when multiple messages are put into the TX FIFO.
I2C being a slow protocol to begin with -- XIIC only supports 100 kHz a=
nd 400 kHz modes --
enqueing one i2c_msg at a time, the new implementation should not be si=
gnificantly slower
than the old implementation.

The new implementation still uses XIIC Dynamic mode with the drawbacks =
that I2C_M_NOSTART and
I2C_M_RECV_LEN cannot be supported. The old implementation did not supp=
ort them properly either.

This patch also adds (untested) 10-bit addressing support. HW testing w=
ould be appreciated.

Signed-off-by: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c | 973 ++++++++++++++++++++++++++++++----=
--------
 1 file changed, 689 insertions(+), 284 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xii=
c.c
index c6448f2..5c9897e 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -40,36 +40,53 @@
=20
 #define DRIVER_NAME "xiic-i2c"
=20
+/*=20
+ * I2C ISR FSM States
+ *=20
+ * IDLE -> BUSY -> DONE  : Regular State Transitions
+ * IDLE -> ERROR         : Arbitration Lost
+ * IDLE -> BUSY -> ERROR : Transmit/Receive Error
+ *
+ */
 enum xilinx_i2c_state {
+	STATE_IDLE,
 	STATE_DONE,
 	STATE_ERROR,
-	STATE_START
+	STATE_BUSY
+};
+
+enum xilinx_i2c_reason {
+	REASON_DONE,
+	REASON_UNKN,
+	REASON_ARB_LOST,
+	REASON_BUS_ERROR,
+	REASON_NACK_ON_SLA,
+	REASON_NACK_ON_D
 };
=20
 /**
  * struct xiic_i2c - Internal representation of the XIIC I2C bus
- * @base:   Memory base of the HW registers
- * @wait:   Wait queue for callers
- * @adap:   Kernel adapter representation
- * @tx_msg: Messages from above to be sent
- * @lock:   Mutual exclusion
- * @tx_pos: Position within current TX message
- * @nmsgs:  Number of messages in tx_msg
- * @state:  Current controller state
- * @rx_msg: Current RX message
- * @rx_pos: Position within current RX message
+ * @base:    Memory base of the HW registers
+ * @wait:    Wait queue for callers
+ * @adap:    Kernel adapter representation
+ * @lock:    Mutual exclusion
+ * @msg:     RX/TX message pointer
+ * @pos:     Position within current msg->buf
+ * @nmsgs:   Number of messages in i2c_msg
+ * @state:   Current controller state
+ * @reasons: Reason for entering STATE_ERROR.
+ *           Only valid while in STATE_ERROR.
  */
 struct xiic_i2c {
-	void __iomem *        base;
-	wait_queue_head_t     wait;
-	struct i2c_adapter    adap;
-	struct i2c_msg        *tx_msg;
-	spinlock_t            lock;
-	unsigned int          tx_pos;
-	unsigned int          nmsgs;
-	enum xilinx_i2c_state state;
-	struct i2c_msg        *rx_msg;
-	int                   rx_pos;
+	void __iomem *         base;
+	wait_queue_head_t      wait;
+	struct i2c_adapter     adap;
+	spinlock_t             lock;
+	struct i2c_msg         *msg;
+	unsigned int           pos;
+	unsigned int           nmsgs;
+	enum xilinx_i2c_state  state;
+	enum xilinx_i2c_reason reason;
 };
=20
=20
@@ -117,19 +134,12 @@ struct xiic_i2c {
 #define XIIC_INTR_AAS_MASK                0x20 /* 1 =3D when addr as s=
lave */
 #define XIIC_INTR_NAAS_MASK               0x40 /* 1 =3D not addr as sl=
ave  */
 #define XIIC_INTR_TX_HALF_MASK            0x80 /* 1 =3D TX FIFO half e=
mpty */
+#define XIIC_INTR_ALL_MASK                0xFF /* mask of all valid in=
terrupt enable bits */
=20
 /* The following constants specify the depth of the FIFOs */
 #define IIC_RX_FIFO_DEPTH         16 /* Rx fifo capacity              =
 */
 #define IIC_TX_FIFO_DEPTH         16 /* Tx fifo capacity              =
 */
=20
-/* The following constants specify groups of interrupts that are typic=
ally
- * enabled or disables at the same time
- */
-#define XIIC_TX_INTERRUPTS                           \
-(XIIC_INTR_TX_ERROR_MASK | XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF=
_MASK)
-
-#define XIIC_TX_RX_INTERRUPTS (XIIC_INTR_RX_FULL_MASK | XIIC_TX_INTERR=
UPTS)
-
 /* The following constants are used with the following macros to speci=
fy the
  * operation, a read or write operation.
  */
@@ -162,12 +172,9 @@ struct xiic_i2c {
  */
 #define XIIC_GINTR_ENABLE_MASK      0x80000000UL
=20
-#define xiic_tx_space(i2c) ((i2c)->tx_msg->len - (i2c)->tx_pos)
-#define xiic_rx_space(i2c) ((i2c)->rx_msg->len - (i2c)->rx_pos)
-
-static void xiic_start_xfer(struct xiic_i2c *i2c);
-static void __xiic_start_xfer(struct xiic_i2c *i2c);
+static void xiic_enqueue_msg(struct xiic_i2c *i2c);
=20
+#define xiic_msg_space(i2c) ((i2c)->msg->len - (i2c)->pos)
 #define xiic_getreg32(i2c, reg)        ioread32(i2c->base + reg)
 #define xiic_setreg32(i2c, reg, value) iowrite32(value, i2c->base + re=
g)
=20
@@ -195,26 +202,42 @@ static inline void xiic_irq_clr_en(struct xiic_i2=
c *i2c, u32 mask)
 	xiic_irq_en(i2c, mask);
 }
=20
+static void xiic_clear_tx_fifo(struct xiic_i2c *i2c)
+{
+	u32 cr =3D xiic_getreg32(i2c, XIIC_CR_REG);
+=09
+	xiic_setreg32(i2c, XIIC_CR_REG, cr | XIIC_CR_TX_FIFO_RESET_MASK);
+	xiic_setreg32(i2c, XIIC_CR_REG, cr);
+=09
+}
+
 static void xiic_clear_rx_fifo(struct xiic_i2c *i2c)
 {
 	u32 sr;
-	for (sr =3D xiic_getreg32(i2c, XIIC_SR_REG);
-		!(sr & XIIC_SR_RX_FIFO_EMPTY_MASK);
-		sr =3D xiic_getreg32(i2c, XIIC_SR_REG))
+	for (sr =3D xiic_getreg32(i2c, XIIC_SR_REG);=20
+	     !(sr & XIIC_SR_RX_FIFO_EMPTY_MASK);
+	     sr =3D xiic_getreg32(i2c, XIIC_SR_REG))
 		xiic_getreg32(i2c, XIIC_DRR_REG);
 }
=20
+static void xiic_set_min_rxpirq(struct xiic_i2c *i2c, u32 len) {
+=09
+	xiic_setreg32(i2c, XIIC_RFD_REG,
+		(!len || len > IIC_RX_FIFO_DEPTH) ?
+		IIC_RX_FIFO_DEPTH - 1 :  len - 1);
+}
+
 static void xiic_reinit(struct xiic_i2c *i2c)
 {
 	xiic_setreg32(i2c, XIIC_RESETR_OFFSET, XIIC_RESET_MASK);
=20
-	/* Set receive Fifo depth to maximum (zero based). */
-	xiic_setreg32(i2c, XIIC_RFD_REG, IIC_RX_FIFO_DEPTH - 1);
+	/* Set receive fifo depth to maximum. */
+	xiic_set_min_rxpirq(i2c, IIC_RX_FIFO_DEPTH);
=20
-	/* Reset Tx Fifo. */
-	xiic_setreg32(i2c, XIIC_CR_REG, XIIC_CR_TX_FIFO_RESET_MASK);
+	/* Reset tx fifo. */
+	xiic_clear_tx_fifo(i2c);
=20
-	/* Enable IIC Device, remove Tx Fifo reset & disable general call. */
+	/* Enable IIC Device, disable general call. */
 	xiic_setreg32(i2c, XIIC_CR_REG, XIIC_CR_ENABLE_DEVICE_MASK);
=20
 	/* make sure RX fifo is empty */
@@ -239,208 +262,405 @@ static void xiic_deinit(struct xiic_i2c *i2c)
=20
 static void xiic_read_rx(struct xiic_i2c *i2c)
 {
-	u32 bytes_in_fifo;
-	int i;
-
-	bytes_in_fifo =3D xiic_getreg32(i2c, XIIC_RFO_REG) + 1;
+	u32 msg_space =3D xiic_msg_space(i2c);
+	u32 len =3D xiic_getreg32(i2c, XIIC_RFO_REG) + 1;
=20
 	dev_dbg(i2c->adap.dev.parent,
-		"%s entry, bytes in fifo: %d, msg: %d, SR: 0x%x, CR: 0x%x\n",
-		__func__, bytes_in_fifo, xiic_rx_space(i2c),
-		xiic_getreg32(i2c, XIIC_SR_REG),
-		xiic_getreg32(i2c, XIIC_CR_REG));
+	        "%s entry, len %d, rx msg space %d SR 0x%x CR 0x%x\n",
+	        __func__, len, msg_space,
+	        xiic_getreg32(i2c, XIIC_SR_REG),
+	        xiic_getreg32(i2c, XIIC_CR_REG));
=20
-	if (bytes_in_fifo > xiic_rx_space(i2c))
-		bytes_in_fifo =3D xiic_rx_space(i2c);
+	len =3D (len > msg_space) ? msg_space : len;
=20
-	for (i =3D 0; i < bytes_in_fifo; i++)
-		i2c->rx_msg->buf[i2c->rx_pos++] =3D
-			xiic_getreg32(i2c, XIIC_DRR_REG);
+	while (len--)
+		i2c->msg->buf[i2c->pos++] =3D xiic_getreg32(i2c, XIIC_DRR_REG);
=20
-	xiic_setreg32(i2c, XIIC_RFD_REG,
-		(xiic_rx_space(i2c) > IIC_RX_FIFO_DEPTH) ?
-		IIC_RX_FIFO_DEPTH - 1 :  xiic_rx_space(i2c) - 1);
+	/* program new minimum rx fifo space for interrupt generation */
+	if (msg_space - len)
+		xiic_set_min_rxpirq(i2c, msg_space - len);
 }
=20
 static int xiic_tx_fifo_space(struct xiic_i2c *i2c)
 {
 	/* return the actual space left in the FIFO */
+	if (xiic_getreg32(i2c, XIIC_SR_REG) & XIIC_SR_TX_FIFO_EMPTY_MASK)
+		return IIC_TX_FIFO_DEPTH;
+=09
 	return IIC_TX_FIFO_DEPTH - xiic_getreg32(i2c, XIIC_TFO_REG) - 1;
 }
=20
-static void xiic_fill_tx_fifo(struct xiic_i2c *i2c)
+/*=20
+ * Fill XIIC TX FIFO with data from current i2c_msg i2c->msg.
+ * This can be called with preemption disabled, so all dev_dbg
+ * had to go.
+ */
+static void __xiic_fill_tx_fifo(struct xiic_i2c *i2c)
 {
 	u32 fifo_space =3D xiic_tx_fifo_space(i2c);
-	int len =3D xiic_tx_space(i2c);
+	int len =3D xiic_msg_space(i2c);
=20
 	len =3D (len > fifo_space) ? fifo_space : len;
=20
-	dev_dbg(i2c->adap.dev.parent, "%s entry, len: %d, fifo space: %d\n",
-		__func__, len, fifo_space);
-
 	while (len--) {
-		u16 data =3D i2c->tx_msg->buf[i2c->tx_pos++];
-		if ((xiic_tx_space(i2c) =3D=3D 0) && (i2c->nmsgs =3D=3D 1)) {
-			/* last message in transfer -> STOP */
+		u16 data =3D i2c->msg->buf[i2c->pos++];
+	=09
+		/* last message in transfer -> STOP */
+		if ((xiic_msg_space(i2c) =3D=3D 0) && (i2c->nmsgs =3D=3D 1)) {
 			data |=3D XIIC_TX_DYN_STOP_MASK;
-			dev_dbg(i2c->adap.dev.parent, "%s TX STOP\n", __func__);
 		}
 		xiic_setreg32(i2c, XIIC_DTR_REG, data);
 	}
 }
=20
-static void xiic_wakeup(struct xiic_i2c *i2c, int code)
+static void xiic_set_state(struct xiic_i2c *i2c, enum xilinx_i2c_state=
 code, enum xilinx_i2c_reason reason)
 {
-	i2c->tx_msg =3D NULL;
-	i2c->rx_msg =3D NULL;
-	i2c->nmsgs =3D 0;
 	i2c->state =3D code;
-	wake_up(&i2c->wait);
+	i2c->reason =3D reason;
 }
=20
+/*
+ * Threaded Interrupt Service Handler
+ * Notes about Interrupts:
+ * All notes only look at Master mode. Slave mode not supported.
+ * Only dynamic mode.
+ * INT(0) Arbitration Lost
+ *        Can fire whenever arbitration is lost.
+ * INT(1) Transmit Error/Slave Transmit Complete
+ *        Can only decide which of the four cases (1a, 1b, 2, [3, 4]) =
we're in by
+ *        using message direction (as CR(TX) is reset for 1a, 1b) alon=
g with
+ *        INT(2) and INT(3) state.
+ * INT(2) Transmit FIFO Empty
+ *        Only fires when XIIC is throttling bus, i.e. Master Transmit=
ter
+ *        and TX FIFO is empty and did not contain XIIC_TX_DYN_STOP_MA=
SK.
+ *        Does not fire when XIIC Master Receiver TX FIFO is empty. Ma=
ster
+ *        Receiver will issue STO regardless of XIIC_TX_DYN_STOP_MASK =
presence.
+ * INT(3) Receive FIFO Full
+ *        XIIC throttles bus until RX FIFO data count falls below RX_F=
IFO_PIRQ.
+ * INT(4) IIC Bus is Not Busy
+ *        Also fires on bus error (stuck low, stuck high).
+ * INT(7) Transmit FIFO Half Empty
+ *        XIIC reads word out of FIFO before sending it. So interrupt =
triggers
+ *        before word is seen on I2C bus.
+ *=20
+ * STA   - Start or Restart
+ * rSTA  - Restart
+ * STO   - Stop
+ * SLA+W - Slave Address + Write
+ * SLA+R - Slave Address + Read
+ * SLA+? - Slave Address + Don't Care
+ * D*    - 0 or more data words
+ * D+    - 1 or more data words
+ * Dh    - data word before Tx FIFO is half empty
+ *=20
+ * XIIC Master Transmitter/Receiver NACK on SLA:
+ * M: STA SLA+? |  STO |
+ * S:      NACK |      |
+ *             INT(1) INT(4)
+ *
+ * XIIC Master Transmitter 0 or more words w/o NACK:
+ * M: STA SLA+W   D+ |  Dh  D*  STO |
+ * S:       ACK  ACK | ACK  ACK     |
+ *                  INT(7)         INT(4)
+ * Assumes TX FIFO Half Empty is disabled for TX_FIFO_OCY < (IIC_TX_FI=
=46O_DEPTH / 2) words
+ * and disabled after last use.
+ *=20
+ * XIIC Master Transmitter >0 words w/ NACK:
+ * M: STA SLA+W  D*   D  |  STO |
+ * S:       ACK ACK NACK |      |
+ *                      INT(1) INT(4)
+ *
+ * XIIC Master Transmitter 0 or more words; w/o stop:
+ * M: STA SLA+W  D* |
+ * S:       ACK ACK |
+ *                 INT(2)
+ *
+ * XIIC Master Transmitter 0 or more words; w/ NACK w/o stop:
+ * M: STA SLA+W   D* |                               =20
+ * S:       ACK NACK |                               =20
+ *                 INT(1)                            =20
+ *                 INT(2)                            =20
+ * In case of 0 words: NACK on SLA instead of NACK on D.
+ *
+ * XIIC Master Receiver >0 words:
+ * M: STA SLA+R ACK | ACK NACK |  STO |
+ * S        ACK  D+ |  D*   D  |      |
+ *                 INT(3)     INT(1) INT(4)
+ *                            INT(3)
+ * Assumes RX_FIFO_PIRQ is reprogrammed to correct depth.
+ */
 static irqreturn_t xiic_process(int irq, void *dev_id)
 {
 	struct xiic_i2c *i2c =3D dev_id;
+	struct i2c_msg *msg =3D i2c->msg;
 	u32 pend, isr, ier;
-	unsigned long flags;
 	u32 clr =3D 0;
+	u32 tmp;
=20
 	/* Get the interrupt Status from the IPIF. There is no clearing of
 	 * interrupts in the IPIF. Interrupts must be cleared at the source.
 	 * To find which interrupts are pending; AND interrupts pending with
 	 * interrupts masked.
 	 */
-	spin_lock(&i2c->lock);
 	isr =3D xiic_getreg32(i2c, XIIC_IISR_OFFSET);
 	ier =3D xiic_getreg32(i2c, XIIC_IIER_OFFSET);
 	pend =3D isr & ier;
=20
-	dev_dbg(i2c->adap.dev.parent, "%s: IER: 0x%x, ISR: 0x%x, pend: 0x%x\n=
",
-		__func__, ier, isr, pend);
-	dev_dbg(i2c->adap.dev.parent, "%s: SR: 0x%x, msg: %p, nmsgs: %d\n",
-		__func__, xiic_getreg32(i2c, XIIC_SR_REG),
-		i2c->tx_msg, i2c->nmsgs);
+	dev_dbg(i2c->adap.dev.parent, "%s: IER 0x%x ISR 0x%x pend 0x%x\n",
+	        __func__, ier, isr, pend);
+	dev_dbg(i2c->adap.dev.parent, "%s: SR 0x%x msg %p nmsgs %d\n",
+	        __func__, xiic_getreg32(i2c, XIIC_SR_REG),
+	        msg, i2c->nmsgs);
=20
=20
 	/* Service requesting interrupt */
-	if ((pend & XIIC_INTR_ARB_LOST_MASK) ||
-		((pend & XIIC_INTR_TX_ERROR_MASK) &&
-		!(pend & XIIC_INTR_RX_FULL_MASK))) {
-		/* bus arbritration lost, or...
-		 * Transmit error _OR_ RX completed
-		 * if this happens when RX_FULL is not set
-		 * this is probably a TX error
+	if (pend & XIIC_INTR_ARB_LOST_MASK) {
+	=09
+		clr |=3D XIIC_INTR_ARB_LOST_MASK;
+		/* This is the only interrupt that is enabled
+		 * while xiic_enqueue_msg might be writing to
+		 * i2c->state as well.
+		 * Lock access.
 		 */
-
-		dev_dbg(i2c->adap.dev.parent, "%s error\n", __func__);
-
-		/* dynamic mode seem to suffer from problems if we just flushes
-		 * fifos and the next message is a TX with len 0 (only addr)
-		 * reset the IP instead of just flush fifos
-		 */
-		xiic_reinit(i2c);
-
-		if (i2c->rx_msg)
-			xiic_wakeup(i2c, STATE_ERROR);
-		if (i2c->tx_msg)
-			xiic_wakeup(i2c, STATE_ERROR);
+		spin_lock(&i2c->lock);
+		xiic_set_state(i2c, STATE_ERROR, REASON_ARB_LOST);
+		spin_unlock(&i2c->lock);
+		/* disable all interrupts to be safe */
+		xiic_irq_dis(i2c, XIIC_INTR_ALL_MASK);
+		/* try to clear arbitration lost */
+		/* clear MSMS bit */
+		tmp =3D xiic_getreg32(i2c, XIIC_CR_REG);
+		xiic_setreg32(i2c, XIIC_CR_REG, tmp & ~XIIC_CR_MSMS_MASK);
+		wake_up(&i2c->wait);
+	=09
+		/* We lost arbitration. Nothing else matters anymore */
+		goto out;
+	}
+=09
+	/* Transmit Error/Slave Transmit Complete */
+	if (pend & XIIC_INTR_TX_ERROR_MASK) {
+	=09
+		clr |=3D XIIC_INTR_TX_ERROR_MASK;
+	=09
+		switch (i2c->state) {
+		case STATE_BUSY:
+	=09
+			/* Error (if any) depends on message direction */
+			if (!(msg->flags & I2C_M_RD)) {
+				/* Write */
+				/* Case 1a: NACK on SLA */
+				/* Case 1b: NACK on D   */
+			=09
+				/* disable TX empty in case this is not NACK on last D */
+				xiic_irq_dis(i2c, XIIC_INTR_TX_EMPTY_MASK);
+				/* enable BNB to exit properly */
+				xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
+			=09
+				/* position greater than space in TX FIFO excluding 7-bit address
+				 * --> not initial FIFO contents, i.e. address already transmitted=
=2E
+				 */
+				if (i2c->pos > IIC_TX_FIFO_DEPTH - 1) {
+					xiic_set_state(i2c, STATE_ERROR, REASON_NACK_ON_D);
+					break;
+				}
+			=09
+				/* position greater than space in TX FIFO excluding 10-bit address
+				 * --> not initial FIFO contents, i.e. address already transmitted=
=2E
+				 */
+				if (msg->flags & I2C_M_TEN && i2c->pos > IIC_TX_FIFO_DEPTH - 2) {
+					xiic_set_state(i2c, STATE_ERROR, REASON_NACK_ON_D);
+					break;
+				}
+			=09
+				/* space left in fifo + data written to fifo exceeds fifo depth
+				 * --> we started transmitting data.
+				 */
+				if (xiic_tx_fifo_space(i2c) + i2c->pos > IIC_TX_FIFO_DEPTH) {
+					xiic_set_state(i2c, STATE_ERROR, REASON_NACK_ON_D);
+					break;
+				}
+			=09
+				xiic_set_state(i2c, STATE_ERROR, REASON_NACK_ON_SLA);
+				break;
+			=09
+			} else {
+				/* Read */
+				/* Case 1a: NACK on SLA
+				 * Case 2 : Master Receiver Transmit Complete
+				 *          Assume RX_FIFO_PIRQ programmed for INT(3)
+				 *          and let code below handle it.
+				 */
+				if (!(pend & XIIC_INTR_RX_FULL_MASK)) {
+					/* Case 1a */
+					/* no need to disable TX empty, as it
+					 * doesn't fire in Master Receiver mode.
+					 */
+				=09
+					/* enable BNB to exit properly */
+					xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
+				=09
+					xiic_set_state(i2c, STATE_ERROR, REASON_NACK_ON_SLA);
+				}
+			}
+			break;
+		default:
+			/* This should be impossible */
+			xiic_set_state(i2c, STATE_ERROR, REASON_UNKN);
+			break;
+		}
=20
 	}
+=09
+	/* Receive FIFO is full */
 	if (pend & XIIC_INTR_RX_FULL_MASK) {
-		/* Receive register/FIFO is full */
=20
 		clr |=3D XIIC_INTR_RX_FULL_MASK;
-		if (!i2c->rx_msg) {
+	=09
+		if (!msg) {
 			dev_dbg(i2c->adap.dev.parent,
-				"%s unexpexted RX IRQ\n", __func__);
+				"%s unexpected RX IRQ\n", __func__);
 			xiic_clear_rx_fifo(i2c);
 			goto out;
 		}
=20
+		/* copy fifo contents over to msg buffer */
+		/* set RX_FIFO_PIRQ for proper RX_FULL interrupt */
 		xiic_read_rx(i2c);
-		if (xiic_rx_space(i2c) =3D=3D 0) {
-			/* this is the last part of the message */
-			i2c->rx_msg =3D NULL;
-
-			/* also clear TX error if there (RX complete) */
-			clr |=3D (isr & XIIC_INTR_TX_ERROR_MASK);
+	=09
+		/* if this is the last part of the message
+		 * try to enqueue next message or let BNB
+		 * interrupt finalize transfer
+		 */
+		if (xiic_msg_space(i2c) =3D=3D 0) {
=20
 			dev_dbg(i2c->adap.dev.parent,
-				"%s end of message, nmsgs: %d\n",
-				__func__, i2c->nmsgs);
+			        "%s end of message: nmsgs %d\n",
+			        __func__, i2c->nmsgs);
=20
-			/* send next message if this wasn't the last,
-			 * otherwise the transfer will be finialise when
-			 * receiving the bus not busy interrupt
+			/* Leaving this interrupt after
+			 * last receive causes INT(1) to
+			 * be asserted with INT(2).
 			 */
-			if (i2c->nmsgs > 1) {
-				i2c->nmsgs--;
-				i2c->tx_msg++;
-				dev_dbg(i2c->adap.dev.parent,
-					"%s will start next...\n", __func__);
-
-				__xiic_start_xfer(i2c);
-			}
+			xiic_irq_dis(i2c, XIIC_INTR_RX_FULL_MASK);
+			xiic_enqueue_msg(i2c);
 		}
 	}
+=09
+	/* IIC bus has transitioned to not busy */
+	/* This interrupt also fires if the i2c bus is broken (stuck low, stu=
ck high),
+	 * i.e. it might fire right at the beginning of a transfer
+	 * before STA.
+	 */
 	if (pend & XIIC_INTR_BNB_MASK) {
-		/* IIC bus has transitioned to not busy */
+	=09
 		clr |=3D XIIC_INTR_BNB_MASK;
=20
 		/* The bus is not busy, disable BusNotBusy interrupt */
 		xiic_irq_dis(i2c, XIIC_INTR_BNB_MASK);
=20
-		if (!i2c->tx_msg)
-			goto out;
-
-		if ((i2c->nmsgs =3D=3D 1) && !i2c->rx_msg &&
-			xiic_tx_space(i2c) =3D=3D 0)
-			xiic_wakeup(i2c, STATE_DONE);
-		else
-			xiic_wakeup(i2c, STATE_ERROR);
-
+		switch (i2c->state) {
+		case STATE_BUSY:
+	=09
+			/* We might reach this state
+			 * A) directly when STA SLA+W D* STO
+			 *    was issued and no error occurred.
+			 *    This means there was exactly one i2c_msg.
+			 *    Note:
+			 *    Tx FIFO Empty was not issued in the
+			 *    TX case, hence we're in STATE_BUSY.
+			 * B) indirectly when STA SLA+R D+ STO
+			 *    was issued and RX Fifo Full and
+			 *    Slave Transmit Complete interrupts
+			 *    occurred.
+			 * C) when there is some kind of bus error.
+			 *    TX FIFO won't be empty.
+			 *    msg->buf might be empty, depending on
+			 *    the exact timing of the interrupt and
+			 *    msg->len.
+			 */
+			if (xiic_getreg32(i2c, XIIC_SR_REG) & XIIC_SR_TX_FIFO_EMPTY_MASK) {
+				/* Case A or B*/
+				xiic_set_state(i2c, STATE_DONE, REASON_DONE);
+				wake_up(&i2c->wait);
+				break;
+			}
+			/* Case C */
+			xiic_set_state(i2c, STATE_ERROR, REASON_BUS_ERROR);
+			/* FALL-THROUGH */
+		default:
+	=09
+			/*
+			 * We're already in some error state.
+			 * Don't overwrite error reason.
+			 */
+			wake_up(&i2c->wait);
+			break;
+		}
+	=09
 	}
-	if (pend & (XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_MASK)) {
-		/* Transmit register/FIFO is empty or =C2=BD empty */
-
-		clr |=3D (pend &
-			(XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_MASK));
-
-		if (!i2c->tx_msg) {
+=09
+	/* TX FIFO Empty interrupt */
+	/* This interrupt is used to enqueue
+	 * the next message.
+	 * If there is no next message, BNB
+	 * interrupt will finalize this transfer
+	 */
+	if (pend & XIIC_INTR_TX_EMPTY_MASK) {
+	=09
+		clr |=3D XIIC_INTR_TX_EMPTY_MASK;
+	=09
+		if (!msg) {
 			dev_dbg(i2c->adap.dev.parent,
-				"%s unexpexted TX IRQ\n", __func__);
+				"%s unexpected TX Empty IRQ\n", __func__);
 			goto out;
 		}
-
-		xiic_fill_tx_fifo(i2c);
-
-		/* current message sent and there is space in the fifo */
-		if (!xiic_tx_space(i2c) && xiic_tx_fifo_space(i2c) >=3D 2) {
+	=09
+		dev_dbg(i2c->adap.dev.parent,
+		        "%s end of message: nmsgs %d\n",
+		        __func__, i2c->nmsgs);
+
+		xiic_irq_dis(i2c, XIIC_INTR_TX_EMPTY_MASK);
+		/*=20
+		 * If NACK on last D or NACK on SLA w/ msg->len =3D=3D 0
+		 * or __xiic_enqueue_tx_msg not done yet,
+		 * must not enqueue next message.
+		 */
+		if (!(pend & XIIC_INTR_TX_ERROR_MASK) && xiic_msg_space(i2c) =3D=3D =
0)
+			xiic_enqueue_msg(i2c);
+	=09
+	}
+=09
+	/* TX FIFO Half-Empty interrupt */
+	/* This interrupt is used exclusively to
+	 * load more data from the _current_ message
+	 */
+	if (pend & XIIC_INTR_TX_HALF_MASK) {
+	=09
+		clr |=3D XIIC_INTR_TX_HALF_MASK;
+=09
+		if (!msg) {
 			dev_dbg(i2c->adap.dev.parent,
-				"%s end of message sent, nmsgs: %d\n",
-				__func__, i2c->nmsgs);
-			if (i2c->nmsgs > 1) {
-				i2c->nmsgs--;
-				i2c->tx_msg++;
-				__xiic_start_xfer(i2c);
-			} else {
-				xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK);
-
-				dev_dbg(i2c->adap.dev.parent,
-					"%s Got TX IRQ but no more to do...\n",
-					__func__);
-			}
-		} else if (!xiic_tx_space(i2c) && (i2c->nmsgs =3D=3D 1))
-			/* current frame is sent and is last,
-			 * make sure to disable tx half
-			 */
+				"%s unexpected TX Half IRQ\n", __func__);
+			goto out;
+		}
+=09
+		/* try to fill buffer */
+		__xiic_fill_tx_fifo(i2c);
+=09
+		/* whole message copied to buffer */
+		if (xiic_msg_space(i2c) =3D=3D 0)
 			xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK);
+=09
 	}
+
 out:
 	dev_dbg(i2c->adap.dev.parent, "%s clr: 0x%x\n", __func__, clr);
=20
-	xiic_setreg32(i2c, XIIC_IISR_OFFSET, clr);
-	spin_unlock(&i2c->lock);
+	/* must use xiic_irq_clr instead of xiic_setreg32
+	 * b/c xiic_reinit, xiic_enqueue_msg might have reset
+	 * irq already and ISR is toggle register.
+	 */
+	xiic_irq_clr(i2c, clr);
 	return IRQ_HANDLED;
 }
=20
@@ -456,11 +676,11 @@ static int xiic_busy(struct xiic_i2c *i2c)
 	int tries =3D 3;
 	int err;
=20
-	if (i2c->tx_msg)
+	if (i2c->msg)
 		return -EBUSY;
=20
 	/* for instance if previous transfer was terminated due to TX error
-	 * it might be that the bus is on it's way to become available
+	 * it might be that the bus is on its way to become available
 	 * give it at most 3 ms to wake
 	 */
 	err =3D xiic_bus_busy(i2c);
@@ -472,80 +692,13 @@ static int xiic_busy(struct xiic_i2c *i2c)
 	return err;
 }
=20
-static void xiic_start_recv(struct xiic_i2c *i2c)
-{
-	u8 rx_watermark;
-	struct i2c_msg *msg =3D i2c->rx_msg =3D i2c->tx_msg;
-
-	/* Clear and enable Rx full interrupt. */
-	xiic_irq_clr_en(i2c, XIIC_INTR_RX_FULL_MASK | XIIC_INTR_TX_ERROR_MASK=
);
-
-	/* we want to get all but last byte, because the TX_ERROR IRQ is used
-	 * to inidicate error ACK on the address, and negative ack on the las=
t
-	 * received byte, so to not mix them receive all but last.
-	 * In the case where there is only one byte to receive
-	 * we can check if ERROR and RX full is set at the same time
-	 */
-	rx_watermark =3D msg->len;
-	if (rx_watermark > IIC_RX_FIFO_DEPTH)
-		rx_watermark =3D IIC_RX_FIFO_DEPTH;
-	xiic_setreg32(i2c, XIIC_RFD_REG, rx_watermark - 1);
-
-	if (!(msg->flags & I2C_M_NOSTART))
-		/* write the address */
-		xiic_setreg32(i2c, XIIC_DTR_REG,
-			(msg->addr << 1) | XIIC_READ_OPERATION |
-			XIIC_TX_DYN_START_MASK);
-
-	xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
-
-	xiic_setreg32(i2c, XIIC_DTR_REG,
-		msg->len | ((i2c->nmsgs =3D=3D 1) ? XIIC_TX_DYN_STOP_MASK : 0));
-	if (i2c->nmsgs =3D=3D 1)
-		/* very last, enable bus not busy as well */
-		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
-
-	/* the message is tx:ed */
-	i2c->tx_pos =3D msg->len;
-}
-
-static void xiic_start_send(struct xiic_i2c *i2c)
-{
-	struct i2c_msg *msg =3D i2c->tx_msg;
-
-	xiic_irq_clr(i2c, XIIC_INTR_TX_ERROR_MASK);
-
-	dev_dbg(i2c->adap.dev.parent, "%s entry, msg: %p, len: %d",
-		__func__, msg, msg->len);
-	dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
-		__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
-		xiic_getreg32(i2c, XIIC_CR_REG));
-
-	if (!(msg->flags & I2C_M_NOSTART)) {
-		/* write the address */
-		u16 data =3D ((msg->addr << 1) & 0xfe) | XIIC_WRITE_OPERATION |
-			XIIC_TX_DYN_START_MASK;
-		if ((i2c->nmsgs =3D=3D 1) && msg->len =3D=3D 0)
-			/* no data and last message -> add STOP */
-			data |=3D XIIC_TX_DYN_STOP_MASK;
-
-		xiic_setreg32(i2c, XIIC_DTR_REG, data);
-	}
-
-	xiic_fill_tx_fifo(i2c);
-
-	/* Clear any pending Tx empty, Tx Error and then enable them. */
-	xiic_irq_clr_en(i2c, XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_ERROR_MAS=
K |
-		XIIC_INTR_BNB_MASK);
-}
-
 static irqreturn_t xiic_isr(int irq, void *dev_id)
 {
 	struct xiic_i2c *i2c =3D dev_id;
 	u32 pend, isr, ier;
 	irqreturn_t ret =3D IRQ_HANDLED;
-	/* Do not processes a devices interrupts if the device has no
-	 * interrupts pending
+	/* Do not process device interrupts if the device has no
+	 * interrupts pending.
 	 */
=20
 	dev_dbg(i2c->adap.dev.parent, "%s entry\n", __func__);
@@ -559,62 +712,243 @@ static irqreturn_t xiic_isr(int irq, void *dev_i=
d)
 	return ret;
 }
=20
-static void __xiic_start_xfer(struct xiic_i2c *i2c)
+/* Enqueue Master Receive Message
+ * We must not be pre-empted in this code-section, because then
+ * read length might not be written to TX FIFO in time
+ * for XIIC to use it. But, when TX FIFO runs empty,=20
+ * XIIC does not throttle the bus in Master Receiver mode.
+ * Instead, it will read one word from I2C slave and issue STO.
+ * We cannot recover from that state, so we must prevent it
+ * happening in the first place.
+ */
+static void __xiic_enqueue_rx_msg(struct xiic_i2c *i2c)
 {
-	int first =3D 1;
-	int fifo_space =3D xiic_tx_fifo_space(i2c);
-	dev_dbg(i2c->adap.dev.parent, "%s entry, msg: %p, fifos space: %d\n",
-		__func__, i2c->tx_msg, fifo_space);
+	struct i2c_msg *msg =3D i2c->msg;
+	u16 data =3D XIIC_TX_DYN_START_MASK | XIIC_READ_OPERATION;
=20
-	if (!i2c->tx_msg)
-		return;
+	/* Clear and enable Rx full interrupt. */
+	xiic_irq_clr_en(i2c, XIIC_INTR_RX_FULL_MASK | XIIC_INTR_TX_ERROR_MASK=
);
+=09
+	/* By making sure receive and transmit never run simultaneously,
+	 * we enable the ISR to determine which of the four possible=20
+	 * INT(1) Transmit Error/Slave Transmit Complete states it is in.
+	 * Therefore we do not need to program RX_FIFO_PIRQ one word short
+	 * to distinguish states.
+	 * This driver uses dynamic mode, so we don't need to care about
+	 * standard mode program case: M-1 to RX_FIFO_PIRQ, set AXAK, etc.
+	 */
+	xiic_set_min_rxpirq(i2c, msg->len);
+=09
+	if (msg->flags & I2C_M_TEN) {
+	=09
+		/* generate 10-bit 1st address byte */
+		data |=3D 0xF0 | ((msg->addr >> 7) & 0x06);
+		/* 10-bit 2nd address byte should have been
+		 * transmitted with previous master tx.
+		 */
+	} else {
+	=09
+		/* generate 7-bit address */
+		data |=3D ((msg->addr << 1) & 0xfe);
+	=09
+	}
=20
-	i2c->rx_pos =3D 0;
-	i2c->tx_pos =3D 0;
-	i2c->state =3D STATE_START;
-	while ((fifo_space >=3D 2) && (first || (i2c->nmsgs > 1))) {
-		if (!first) {
-			i2c->nmsgs--;
-			i2c->tx_msg++;
-			i2c->tx_pos =3D 0;
-		} else
-			first =3D 0;
-
-		if (i2c->tx_msg->flags & I2C_M_RD) {
-			/* we dont date putting several reads in the FIFO */
-			xiic_start_recv(i2c);
-			return;
+	xiic_setreg32(i2c, XIIC_DTR_REG, data);
+
+	/*
+	 * Master Receive without length byte will receive 1 byte and STO.
+	 * INT(2) won't fire (because it's not Master Transmitter mode).
+	 * Master Receiver will issue STO after receive regardless of
+	 * TX FIFO occupancy in dynamic mode.
+	 * Therefore don't check i2c->nmsgs and set XIIC_TX_DYN_STOP_MASK
+	 * to make it obvious that STO will happen.
+	 */
+	xiic_setreg32(i2c, XIIC_DTR_REG, msg->len | XIIC_TX_DYN_STOP_MASK);
+=09
+	/*=20
+	 * Must enable BNB only _after_ filling FIFO, or it
+	 * will fire immediately.
+	 * Because Master Receiver will issue STO after receive
+	 * regardless of TX FIFO occupancy, INT(4) BNB fires
+	 * in-between transfers.
+	 * Therefore clear and enable BNB interrupt for last
+	 * transfer only.
+	 */
+	if (i2c->nmsgs =3D=3D 1)
+		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
+=09
+}
+
+/* Enqueue Master Transmitter Message
+ * We must not be pre-empted in this code-section, because then
+ * it's not certain that register writes to clear interrupts
+ * follow immediately after writing to TX FIFO.
+ * Clearing certain interrupts (TX_EMPTY_MASK) is impossible
+ * without first writing to TX FIFO, so it cannot be done
+ * beforehand.
+ * However, if we're pre-empted after writing to TX FIFO,
+ * but before clearing TX_EMPTY_MASK or TX_ERROR_MASK,
+ * we might re-enter this code _after_ XIIC already wrote to the bus
+ * and correctly set the interrupts pending, but _before_
+ * ISR thread had time to handle them (if they were enabled
+ * in the first place).
+ * This will result in the controller seemingly timing out,
+ * because it is done and no other interrupts might fire
+ * due to being disabled or overwritten during clear
+ * by the time we exit this function.
+ */
+static void __xiic_enqueue_tx_msg(struct xiic_i2c *i2c)
+{
+	struct i2c_msg *msg =3D i2c->msg;
+	u16 data =3D XIIC_TX_DYN_START_MASK | XIIC_WRITE_OPERATION;
+
+	xiic_irq_clr(i2c, XIIC_INTR_TX_ERROR_MASK);
+=09
+	/* Skip generating STA when I2C_M_NOSTART is set.
+	 * If this is set on the first message
+	 * controller will time out.
+	 */
+	if (!(msg->flags & I2C_M_NOSTART)) {
+		if (msg->flags & I2C_M_TEN) {
+		=09
+			/* generate 10-bit 1st address byte */
+			data |=3D 0xF0 | ((msg->addr >> 7) & 0x06);
+			xiic_setreg32(i2c, XIIC_DTR_REG, data);
+			/* generate 10-bit 2nd address byte */
+			data =3D msg->addr & 0xff;
+		=09
 		} else {
-			xiic_start_send(i2c);
-			if (xiic_tx_space(i2c) !=3D 0) {
-				/* the message could not be completely sent */
-				break;
-			}
+		=09
+			/* generate 7-bit address */
+			data |=3D ((msg->addr << 1) & 0xfe);
+		=09
 		}
+	=09
+		/* no data and last message -> add STOP */
+		if ((i2c->nmsgs =3D=3D 1) && msg->len =3D=3D 0)
+			data |=3D XIIC_TX_DYN_STOP_MASK;
=20
-		fifo_space =3D xiic_tx_fifo_space(i2c);
+		xiic_setreg32(i2c, XIIC_DTR_REG, data);
 	}
-
-	/* there are more messages or the current one could not be completely
-	 * put into the FIFO, also enable the half empty interrupt
+	__xiic_fill_tx_fifo(i2c);
+=09
+	/* Clear any pending Tx empty, Tx Error and then enable them. */
+	xiic_irq_clr_en(i2c, XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_ERROR_MAS=
K);
+=09
+	/* If this message did not fit into fifo, enable half empty interrupt=
=2E
+	 * We don't use half empty to load further messages, because then
+	 * failure/success states cannot be discerned from ISR as they rely
+	 * on tx fifo empty/full logic.
 	 */
-	if (i2c->nmsgs > 1 || xiic_tx_space(i2c))
+	if (xiic_msg_space(i2c))
 		xiic_irq_clr_en(i2c, XIIC_INTR_TX_HALF_MASK);
-
+=09
+	/* Clear and enable BNB interrupt for last transfer only */
+	/* Must enable BNB only _after_ filling FIFO, or it will fire
+	 * immediately.
+	 */
+	if (i2c->nmsgs =3D=3D 1)
+		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
 }
=20
-static void xiic_start_xfer(struct xiic_i2c *i2c)
+static void xiic_enqueue_msg(struct xiic_i2c *i2c)
 {
-	unsigned long flags;
-
-
-	__xiic_start_xfer(i2c);
+	struct i2c_msg *msg;
+	/*=20
+	 * Must not overwrite state when
+	 * in error state, i.e. arbitration lost.
+	 * In a perfect world, this function should
+	 * only be called for i2c->nmsgs >=3D1, check
+	 * anyway.
+	 */
+	spin_lock(&i2c->lock);
+	if (i2c->state =3D=3D STATE_ERROR || !i2c->nmsgs) {
+		spin_unlock(&i2c->lock);
+		return;
+	}
+=09
+	if (i2c->state !=3D STATE_IDLE) {
+		i2c->msg++;
+		i2c->nmsgs--;
+	}
+	/* Reset FSM to start */
+	i2c->state =3D STATE_BUSY;
+	i2c->pos =3D 0;
+	spin_unlock(&i2c->lock);
+=09
+	/* At this point, arbitration might be lost.
+	 * Depending on exact timing of threads,
+	 * user sees either arbitration lost or
+	 * timeout.
+	 */
+=09
+	/* If this was the last message, we must not
+	 * read past end of msg buffer.
+	 */
+	if (!i2c->nmsgs)
+		return;
+=09
+	msg =3D i2c->msg;
+=09
+	/* print detailed debug information
+	 * outside of non-preemptible section.
+	 */
+	dev_dbg(i2c->adap.dev.parent,
+	        "%s: ISR 0x%02X IER 0x%02X SR 0x%02X CR 0x%02X\n",
+	        __func__,
+	        xiic_getreg32(i2c, XIIC_IISR_OFFSET),
+	        xiic_getreg32(i2c, XIIC_IIER_OFFSET),
+	        xiic_getreg32(i2c, XIIC_SR_REG),
+	        xiic_getreg32(i2c, XIIC_CR_REG)
+	        );
+	dev_dbg(i2c->adap.dev.parent,
+	        "%s: enqueue %s msg %p addr 0x%03X len %d flags 0x%04X nmsgs =
%d\n",
+	        __func__,
+	        msg->flags & I2C_M_RD ? "rx" : "tx",
+	        msg,
+	        msg->addr,
+	        msg->len,
+	        msg->flags,
+	        i2c->nmsgs
+	        );
+=09
+	/*
+	 * XIIC Dynamic Mode cannot support I2C_M_NOSTART for I2C_M_RD.
+	 * XIIC Dynamic Mode cannot support I2C_M_RECV_LEN (I2C_M_RD implicit=
).
+	 * Let controller time out, so user gets at least one additional=20
+	 * error message pointing out the actual problem.
+	 * FIXME: Rewrite Master Receiver code to Standard Controller Flow?
+	 *        Will that clash with Dynamic Controller Flow for Master
+	 *        Transmitter?
+	 */
+	if (msg->flags & I2C_M_RD) {
+		if (msg->flags & (I2C_M_RECV_LEN | I2C_M_NOSTART)) {
+			dev_err(i2c->adap.dev.parent,
+			        "%s: unsupported I2C_M_RECV_LEN or I2C_M_NOSTART flag in dy=
namic read mode.\n",
+			        __func__
+			        );
+			return;
+		}
+	}
+=09
+	preempt_disable();
+=09
+	/* assume at least 3 words free in TX FIFO */
+	if (msg->flags & I2C_M_RD) {
+		__xiic_enqueue_rx_msg(i2c);
+	} else {
+		__xiic_enqueue_tx_msg(i2c);
+	}
+=09
+	preempt_enable();
 }
=20
 static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, i=
nt num)
 {
 	struct xiic_i2c *i2c =3D i2c_get_adapdata(adap);
 	int err;
+	int ret =3D num;
+	u32 tmp;
=20
 	dev_dbg(adap->dev.parent, "%s entry SR: 0x%x\n", __func__,
 		xiic_getreg32(i2c, XIIC_SR_REG));
@@ -623,26 +957,97 @@ static int xiic_xfer(struct i2c_adapter *adap, st=
ruct i2c_msg *msgs, int num)
 	if (err)
 		return err;
=20
-	i2c->tx_msg =3D msgs;
+	i2c->msg =3D msgs;
 	i2c->nmsgs =3D num;
=20
-	xiic_start_xfer(i2c);
+	xiic_enqueue_msg(i2c);
=20
-	if (wait_event_timeout(i2c->wait, (i2c->state =3D=3D STATE_ERROR) ||
-		(i2c->state =3D=3D STATE_DONE), HZ))
-		return (i2c->state =3D=3D STATE_DONE) ? num : -EIO;
-	else {
-		i2c->tx_msg =3D NULL;
-		i2c->rx_msg =3D NULL;
-		i2c->nmsgs =3D 0;
+	if (!wait_event_timeout(i2c->wait, (i2c->state =3D=3D STATE_ERROR) ||=
 (i2c->state =3D=3D STATE_DONE), HZ)) {
 		dev_err(adap->dev.parent, "Controller timed out\n");
-		return -ETIMEDOUT;
+		ret =3D -ETIMEDOUT;
 	}
+=09
+	/* Disable all interrupts
+	 * 1) because this might be timeout
+	 * where all bets are off.
+	 * 2) because clearing tx/rx fifo might
+	 * result in additional interrupts,
+	 * which will confuse the ISR.
+	 */
+	xiic_irq_dis(i2c, XIIC_INTR_ALL_MASK);
+	tmp =3D xiic_getreg32(i2c, XIIC_IISR_OFFSET);
+=09
+	if (i2c->state =3D=3D STATE_ERROR) {
+	=09
+		switch (i2c->reason) {
+		case REASON_ARB_LOST:
+			dev_err(adap->dev.parent, "Arbitration Lost\n");
+			break;
+		case REASON_BUS_ERROR:
+			dev_err(adap->dev.parent, "Bus Error\n");
+			break;
+		case REASON_NACK_ON_D:
+			dev_err(adap->dev.parent,
+			        "i2c_msg #%d addr 0x%03X len %d: NACK on TX data\n",
+			        num - i2c->nmsgs,
+			        i2c->msg->addr,
+			        i2c->msg->len
+			        );
+			break;
+		case REASON_NACK_ON_SLA:
+			dev_err(adap->dev.parent,
+			        "i2c_msg #%d addr 0x%03X len %d: NACK on SLA+%s\n",
+			        num - i2c->nmsgs,
+			        i2c->msg->addr,
+			        i2c->msg->len,
+			        i2c->msg->flags & I2C_M_RD ? "R" : "W"
+			        );
+			break;
+		case REASON_UNKN:
+			/* FALL-THROUGH */
+		default:
+			dev_err(adap->dev.parent, "Unknown Error\n");
+			break;
+		}
+	=09
+		ret =3D -EIO;
+	}
+=09
+	/* clear/drain remaining tx/rx fifo contents */
+	xiic_clear_tx_fifo(i2c);
+	xiic_clear_rx_fifo(i2c);
+=09
+	/* try to clear arbitration lost */
+	if (tmp & XIIC_INTR_ARB_LOST_MASK) {
+		/* clear MSMS bit */
+		tmp =3D xiic_getreg32(i2c, XIIC_CR_REG);
+		xiic_setreg32(i2c, XIIC_CR_REG, tmp & ~XIIC_CR_MSMS_MASK);
+	}
+=09
+	/* Try to clear all pending interrupts.
+	 * This might not have been possible before
+	 * clearing fifos/clearing MSMS bit in CR.
+	 */
+	xiic_irq_clr(i2c, XIIC_INTR_ALL_MASK);
+=09
+	/* all IRQs are disabled, no need to lock */
+	/* One more interrupt might have fired while
+	 * xiic_irq_dis(i2c, XIIC_INTR_ALL_MASK) was
+	 * called, but ISR thread would have dismissed
+	 * it, because IER =3D=3D 0x00.
+	 */
+	i2c->state =3D STATE_IDLE;
+	i2c->nmsgs =3D 0;
+	i2c->msg =3D NULL;
+=09
+	xiic_irq_clr_en(i2c, XIIC_INTR_ARB_LOST_MASK);
+=09
+	return ret;
 }
=20
 static u32 xiic_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SMBUS_EMUL;
 }
=20
 static const struct i2c_algorithm xiic_algorithm =3D {
@@ -665,7 +1070,6 @@ static int xiic_i2c_probe(struct platform_device *=
pdev)
 	struct resource *res;
 	int ret, irq;
 	u8 i;
-	u32 sr;
=20
 	i2c =3D devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
@@ -688,6 +1092,7 @@ static int xiic_i2c_probe(struct platform_device *=
pdev)
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent =3D &pdev->dev;
 	i2c->adap.dev.of_node =3D pdev->dev.of_node;
+	i2c->state =3D STATE_IDLE;
=20
 	spin_lock_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
--=20
2.5.0
