From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=209/9=5D=20i2c=3A=20xiic=3A=20Service=20all=20interrupts=20in=20isr?=
Date: Mon, 15 Jun 2015 20:48:00 +0530
Message-ID: <1434381480-3042-9-git-send-email-shubhraj@xilinx.com>
References: <1434381480-3042-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434381480-3042-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If 2 interrupts happen then service both of them.
Currently only one interrupt can be serviced.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xii=
c.c
index 69d937e..c071897 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -403,11 +403,11 @@ static irqreturn_t xiic_process(int irq, void *de=
v_id)
 			xiic_wakeup(i2c, STATE_ERROR);
 		if (i2c->tx_msg)
 			xiic_wakeup(i2c, STATE_ERROR);
-
-	} else if (pend & XIIC_INTR_RX_FULL_MASK) {
+	}
+	if (pend & XIIC_INTR_RX_FULL_MASK) {
 		/* Receive register/FIFO is full */
=20
-		clr =3D XIIC_INTR_RX_FULL_MASK;
+		clr |=3D XIIC_INTR_RX_FULL_MASK;
 		if (!i2c->rx_msg) {
 			dev_dbg(i2c->adap.dev.parent,
 				"%s unexpexted RX IRQ\n", __func__);
@@ -440,9 +440,10 @@ static irqreturn_t xiic_process(int irq, void *dev=
_id)
 				__xiic_start_xfer(i2c);
 			}
 		}
-	} else if (pend & XIIC_INTR_BNB_MASK) {
+	}
+	if (pend & XIIC_INTR_BNB_MASK) {
 		/* IIC bus has transitioned to not busy */
-		clr =3D XIIC_INTR_BNB_MASK;
+		clr |=3D XIIC_INTR_BNB_MASK;
=20
 		/* The bus is not busy, disable BusNotBusy interrupt */
 		xiic_irq_dis(i2c, XIIC_INTR_BNB_MASK);
@@ -455,12 +456,12 @@ static irqreturn_t xiic_process(int irq, void *de=
v_id)
 			xiic_wakeup(i2c, STATE_DONE);
 		else
 			xiic_wakeup(i2c, STATE_ERROR);
-
-	} else if (pend & (XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_MASK))=
 {
+	}
+	if (pend & (XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_MASK)) {
 		/* Transmit register/FIFO is empty or =C2=BD empty */
=20
-		clr =3D pend &
-			(XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_MASK);
+		clr |=3D (pend &
+			(XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_MASK));
=20
 		if (!i2c->tx_msg) {
 			dev_dbg(i2c->adap.dev.parent,
@@ -491,11 +492,6 @@ static irqreturn_t xiic_process(int irq, void *dev=
_id)
 			 * make sure to disable tx half
 			 */
 			xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK);
-	} else {
-		/* got IRQ which is not acked */
-		dev_err(i2c->adap.dev.parent, "%s Got unexpected IRQ\n",
-			__func__);
-		clr =3D pend;
 	}
 out:
 	dev_dbg(i2c->adap.dev.parent, "%s clr: 0x%x\n", __func__, clr);
--=20
1.7.1
